package BitChess.Controllers;

import BitChess.Models.*;
import BitChess.Models.Login.LoginFBModel;
import BitChess.Models.Login.LoginModel;
import BitChess.Models.Users.UserInfo;
import BitChess.Services.AutorizationService;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */

@RestController
public class AuthenticationController {
    @Autowired
    private ConcreteDatabaseService databaseService;
    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public ResponseEntity<?> validateLogin(@RequestBody LoginModel loginModel) {
        if (!loginModel.isValid())
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        NicknameModel username = new NicknameModel();
        username.setNickname(loginModel.getUsername());
        ExistsUserModel existsUserModel = checkExistsUser(username).getBody();
        if (existsUserModel.getExists() == 0)
            return new ResponseEntity<>(new ResponseMessageModel("Username does not exists in database."), HttpStatus.OK);

        UserInfo userInfo;
        try {
            userInfo = databaseService.getUserInformationByUsername(loginModel.getUsername());
        } catch (Exception ex) {
            userInfo = new UserInfo();
        }
        ResponseMessageModel password = getPassword(username).getBody();
        if (!password.getResponseMessage().equals(loginModel.getPassword()))
            return new ResponseEntity<>(new ResponseMessageModel("Invalid password"), HttpStatus.OK);
        TokenModel tokenModel = new TokenModel(autorizationService.generateToken(userInfo.getNickname(), userInfo.getEmail()));
        try {
            databaseService.setTokenByNickname(username.getNickname(), tokenModel.getToken());
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(tokenModel, HttpStatus.CREATED);
    }

    @CrossOrigin
    @RequestMapping(value = "/user/loginFB", method = RequestMethod.POST)
    public ResponseEntity<?> validateLoginFB(@RequestBody LoginFBModel loginModel) {
        if (!loginModel.isValid())
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

        String nickname = loginModel.getName().replaceAll("\\s+", "");
        String nickname_copy = nickname;

        String aux = "";
        Integer cnt = 0;
        while (checkExistsUser(new NicknameModel(nickname + aux)).getBody().getExists() > 0) {
            aux = cnt.toString();
            ++cnt;
        }
        nickname = nickname + aux;
        try {
            TokenModel tokenModel;
            if (databaseService.registerUserFb(loginModel, nickname))
                tokenModel = new TokenModel(autorizationService.generateToken(nickname, loginModel.getEmail()));
            else tokenModel = new TokenModel(autorizationService.generateToken(nickname_copy, loginModel.getEmail()));
            try {
                databaseService.setTokenByFBId(loginModel.getFacebookId(), tokenModel.getToken());
            } catch (SQLException ex) {
                return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
            }
            return new ResponseEntity<>(tokenModel, HttpStatus.CREATED);
        } catch (SQLException ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/logout", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> logOut(@RequestHeader("Authorization") String token) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            databaseService.logOutUser(token);
            return new ResponseEntity<>(new ResponseMessageModel("Logged out successful!"), HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(new ResponseMessageModel(sqlEx.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/checkToken", method = RequestMethod.POST)
    public ResponseEntity<?> checkToken(@RequestBody TokenModel tokenModel) {
        if (tokenModel.getToken() == null)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        try {
            tokenModel.setValid(autorizationService.checkCredentials(tokenModel.getToken()));
            return new ResponseEntity<>(tokenModel, HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/user/userExists", method = RequestMethod.POST)
    public ResponseEntity<ExistsUserModel> checkExistsUser(@RequestBody NicknameModel userNickname) {
        try {
            if (userNickname.getNickname() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsUserModel existsUser = new ExistsUserModel();
            existsUser.setExists(databaseService.existsUser(userNickname.getNickname()) ? 1 : 0);
            System.out.println(existsUser.getExists() + "fuckoff");
            return new ResponseEntity<>(existsUser, HttpStatus.CREATED);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/findUsers/string_match=\"{stringMatch}\"", method = RequestMethod.GET)
    public ResponseEntity<?> findUsers(@RequestHeader("Authorization") String token, @PathVariable String stringMatch) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            return new ResponseEntity<>(databaseService.findUsers(stringMatch), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    //@RequestMapping(value = "/user/getPassword", method = RequestMethod.POST)
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
            if (!registerModel.isValid())
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

            NicknameModel username = new NicknameModel();
            username.setNickname(registerModel.getUsername());
            ExistsUserModel existsUserModel = checkExistsUser(username).getBody();
            if (existsUserModel.getExists() > 0)
                return new ResponseEntity<>(new ResponseMessageModel("Username already exists."), HttpStatus.OK);
            databaseService.register(registerModel.getUsername(), registerModel.getPassword(), registerModel.getEmail());
            return new ResponseEntity<>(new ResponseMessageModel("Register success!"), HttpStatus.CREATED);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
