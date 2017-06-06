package BitChess.Controllers.ForumController;

import BitChess.Controllers.AuthenticationController;
import BitChess.Models.*;
import BitChess.Models.Forum.*;
import BitChess.Services.AutorizationService;
import BitChess.Services.ConcreteDatabaseService;
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
    AuthenticationController authentificationController;
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/AllThreads", method = RequestMethod.GET)
    public ResponseEntity getAllThreads() {
        try {
            ThreadModel threadModel = new ThreadModel();
            threadModel.thread = databaseService.getAllThreads();
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/getThreadByCategory/{category}", method = RequestMethod.GET)
    public ResponseEntity getThreadsByCategory(@PathVariable int category) {
        try {
            ThreadModel threadModel = new ThreadModel();
            ExistsModel existsModel = categorycontroller.checkExistsCategory(category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);
            threadModel.thread = databaseService.getThreadsByCategory(category);
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/getThreadsByUser/{user}", method = RequestMethod.GET)
    public ResponseEntity getThreadsByUser(@PathVariable int user) {
        try {
            ThreadModel threadModel = new ThreadModel();
            NicknameModel nicknameModel = new NicknameModel();
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(user));
            nicknameModel.setNickname(userModel.getNickname());
            ExistsUserModel existsModel = authentificationController.checkExistsUser(nicknameModel).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);

            threadModel.thread = databaseService.getThreadsByUser(nicknameModel.getNickname());
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/threadExists/{thread}", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsThread(@PathVariable int category, @PathVariable int thread) {
        try {
            ExistsModel existsModel = categorycontroller.checkExistsCategory(category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);

            ExistsModel existsThread = new ExistsModel();
            existsThread.setExists(databaseService.checkThreadExits(thread));
            return new ResponseEntity<>(existsThread, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/AddThread", method = RequestMethod.POST)
    public ResponseEntity addThread(@RequestHeader("Authorization") String token, @RequestBody OneThread oneThread, @PathVariable int category) {
        try {
            if (!autorizationService.checkCredentials(databaseService, token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if (oneThread.getName() == null)
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            oneThread.setCategoryId(category);
            oneThread.setUserId(databaseService.getIdByToken(token));
            ExistsModel existsModel = categorycontroller.checkExistsCategory(category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);

            NicknameModel nicknameModel = new NicknameModel();
            nicknameModel.setNickname(databaseService.getNicknameById(oneThread.getUserId()));
            ExistsUserModel existsModel2 = authentificationController.checkExistsUser(nicknameModel).getBody();
            if (existsModel2.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(oneThread.getUserId()));
            if (userModel.getStatus_id() == 3)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Blocked user, can not add thread"), HttpStatus.OK);
            databaseService.addThread(oneThread);
            return new ResponseEntity
                    (new ResponseMessageModel("Thread Added"), HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/deleteThread", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deleteThread(@RequestHeader("Authorization") String token, @RequestBody OneThread thread, @PathVariable int category) {
        try {
            if (!autorizationService.checkCredentials(databaseService, token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            if (thread.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            thread.setUserId(databaseService.getIdByToken(token));

            ExistsModel existsModel = checkExistsThread(thread.getId(), category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            NicknameModel nicknameModel = new NicknameModel();
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(databaseService.getIdByToken(token)));
            if (userModel.getStatus_id() != 1)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Not Admin, can not delete Thread"), HttpStatus.OK);

            databaseService.deleteThread(thread.getId());
            return new ResponseEntity<>(new ResponseMessageModel("Thread deleted successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
