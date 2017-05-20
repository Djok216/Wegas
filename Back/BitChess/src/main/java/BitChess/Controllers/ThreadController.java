package BitChess.Controllers;

import BitChess.Models.*;
import BitChess.Services.ConcreteDatabaseService;
import BitChess.Controllers.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

/**
 * Created by Tamara on 18.05.2017.
 */
@RestController
public class ThreadController {
    @Autowired
    ConcreteDatabaseService databaseService;
    @Autowired
    CategoryController categorycontroller;
    @Autowired
    AuthenticationController authenticationController;

    @CrossOrigin
    @RequestMapping(value = "/AllThreads", method = RequestMethod.GET)
    public ResponseEntity getAllCategories() {
        try {
            ThreadModel threadModel = new ThreadModel();
            threadModel.thread = databaseService.getAllThreads();
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/ThreadsByCategory", method = RequestMethod.POST)
    public ResponseEntity getThreadsByCategory(@RequestBody OneCategory category) {
        try {
            ThreadModel threadModel = new ThreadModel();
            ExistsModel existsModel = categorycontroller.checkExistsCategory(category).getBody();
            if(existsModel.getExists() == 0 )
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);
            threadModel.thread = databaseService.getThreadsByCategory(category.getId());
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/ThreadsByUser", method = RequestMethod.POST)
    public ResponseEntity getThreadsByUser(@RequestBody LoginModel loginModel) {
        try {
            ThreadModel threadModel = new ThreadModel();
            NicknameModel nicknameModel=new NicknameModel();
            nicknameModel.setNickname(loginModel.getUsername());
            ExistsUserModel existsModel = authenticationController.checkExistsUser(nicknameModel).getBody();
            if(existsModel.getExists() == 0 )
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);
            threadModel.thread = databaseService.getThreadsByUser(nicknameModel.getNickname());
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @CrossOrigin
    @RequestMapping(value = "/category/ThreadExists", method = RequestMethod.POST)
    public ResponseEntity<ExistsModel> checkExistsThread(@RequestBody OneThread oneThread) {
        try {
            if (oneThread.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsModel existsThread = new ExistsModel();
            existsThread.setExists(databaseService.checkThreadExits(oneThread.getId()));
            return new ResponseEntity<>(existsThread, HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
