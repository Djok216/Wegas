package BitChess.Controllers;

import BitChess.Models.*;
import BitChess.Services.ConcreteDatabaseService;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.UUID;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */

@RestController
public class AuthenticationController {
    @Autowired
    private ConcreteDatabaseService databaseService;

    @CrossOrigin
    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public ResponseEntity<?> validateLogin(@RequestBody LoginModel loginModel) {
        if (loginModel.getUsername() == null || loginModel.getPassword() == null)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        NicknameModel username = new NicknameModel();
        username.setNickname(loginModel.getUsername());
        ExistsUserModel existsUserModel = checkExistsUser(username).getBody();
        if (existsUserModel.getExists() == 0)
            return new ResponseEntity<>(new ResponseMessageModel("Username does not exists in database"), HttpStatus.OK);

        ResponseMessageModel password = getPassword(username).getBody();

        if (!password.getResponseMessage().equals(loginModel.getPassword()))
            return new ResponseEntity<>(new ResponseMessageModel("Invalid password"), HttpStatus.OK);
        String key = UUID.randomUUID().toString().toUpperCase() + "|" + loginModel.getUsername() + "|" +
                loginModel.getPassword() + "|" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithMD5AndDES");
        encryptor.setPassword("SDGsd356904#$%#^TfdDSG##@");
        String token = encryptor.encrypt(key);
        TokenModel tokenModel = new TokenModel(token);
        try {
            databaseService.setToken(username.getNickname(), tokenModel.getToken());
        } catch (SQLException sqlEx){
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(tokenModel, HttpStatus.OK);
    }

    @CrossOrigin
    @RequestMapping(value = "/user/logout", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> logOut(@RequestBody TokenModel tokenModel) {
        if (tokenModel.getToken() == null)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        try {
            Integer res=databaseService.logOutUser(tokenModel.getToken());
            if (res==0)
                return new ResponseEntity<>(new ResponseMessageModel("Token not found"), HttpStatus.OK);
            return new ResponseEntity<>(new ResponseMessageModel("Logged out successful!"), HttpStatus.OK);
        } catch (SQLException sqlEx){
            return new ResponseEntity<>(new ResponseMessageModel(sqlEx.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/checkToken", method = RequestMethod.POST)
    public ResponseEntity<?> checkToken(@RequestBody TokenModel tokenModel) {
        if (tokenModel.getToken() == null)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        try {
            Integer res=databaseService.checkToken(tokenModel.getToken());
            System.out.println(res);
            if (res==-1 || res==0)
                tokenModel.setValid(false);
            if(res==1)
                tokenModel.setValid(true);
            return new ResponseEntity<>(tokenModel, HttpStatus.OK);

        } catch (SQLException sqlEx){
            return new ResponseEntity<>(new ResponseMessageModel(sqlEx.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/userExists", method = RequestMethod.POST)
    public ResponseEntity<ExistsUserModel> checkExistsUser(@RequestBody NicknameModel userNickname) {
        try {
            if (userNickname.getNickname() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsUserModel existsUser = new ExistsUserModel();
            existsUser.setExists(databaseService.existsUser(userNickname.getNickname())?1:0);
            return new ResponseEntity<>(existsUser, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/findUsers/string_match=\"{stringMatch}\"", method = RequestMethod.GET)
    public ResponseEntity<?> findUsers(@PathVariable String stringMatch) {
        try {
            return new ResponseEntity<>(databaseService.findUsers(stringMatch), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/getPassword", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> getPassword(@RequestBody NicknameModel userNickname) {
        try {
            if (userNickname.getNickname() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ResponseMessageModel responseMessageModel = new ResponseMessageModel("");
            responseMessageModel.setResponseMessage(databaseService.getPassword(userNickname.getNickname()));
            return new ResponseEntity<>(responseMessageModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> register(@RequestBody RegisterModel registerModel) {
        try {
            if (registerModel.getUsername() == null || registerModel.getPassword() == null || registerModel.getEmail() == null)
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

            NicknameModel username = new NicknameModel();
            username.setNickname(registerModel.getUsername());
            ExistsUserModel existsUserModel = checkExistsUser(username).getBody();
            if (existsUserModel.getExists() > 0)
                return new ResponseEntity<>(new ResponseMessageModel("Username already exists."), HttpStatus.OK);
            databaseService.register(registerModel.getUsername(), registerModel.getPassword(), registerModel.getEmail());
            return new ResponseEntity<>(new ResponseMessageModel("Register success!"), HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
