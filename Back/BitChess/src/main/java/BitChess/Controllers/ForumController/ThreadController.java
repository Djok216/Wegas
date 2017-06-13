package BitChess.Controllers.ForumController;

import BitChess.Controllers.AuthenticationController;
import BitChess.Models.ExistsUserModel;
import BitChess.Models.Forum.ExistsModel;
import BitChess.Models.Forum.OneThread;
import BitChess.Models.Forum.ThreadModel;
import BitChess.Models.NicknameModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Models.UserModel;
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
    @Autowired
    ForumController forumController;
    @Autowired
    ThreadController threadController;
    @Autowired
    CategoryController categoryController;

    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/AllThreads", method = RequestMethod.GET)
    public ResponseEntity getAllThreads(@RequestHeader("Authorization") String token) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            ThreadModel threadModel = new ThreadModel();
            threadModel.thread = databaseService.getAllThreads();
            for (OneThread th : threadModel.thread) {
                th.setUserName(databaseService.getNicknameById(th.getUserId()));
                th.setNrPosts(forumController.getNrComm(th.getId()));
            }

            for (OneThread xcat : threadModel.thread) {
                xcat.setNrPosts(forumController.getNrComm(xcat.getId()));
            }
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/getThreadByCategory/{category}", method = RequestMethod.GET)
    public ResponseEntity getThreadsByCategory(@RequestHeader("Authorization") String token, @PathVariable int category) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            ThreadModel threadModel = new ThreadModel();
            ExistsModel existsModel = categorycontroller.checkExistsCategory(token, category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);
            threadModel.thread = databaseService.getThreadsByCategory(category);
            for (OneThread th : threadModel.thread) {
                th.setUserName(databaseService.getNicknameById(th.getUserId()));
                th.setNrPosts(forumController.getNrComm(th.getId()));
            }

            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public int getNrThread(int category) {
        ThreadModel threadModel = new ThreadModel();
        try {
            threadModel.thread = databaseService.getThreadsByCategory(category);
            return (threadModel.thread.size());
        } catch (SQLException sqlEx) {
            return -1;
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/getThreadsByUser/{user}", method = RequestMethod.GET)
    public ResponseEntity getThreadsByUser(@RequestHeader("Authorization") String token, @PathVariable int user) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if(!databaseService.existsUser(user))
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);
            ThreadModel threadModel = new ThreadModel();
            NicknameModel nicknameModel = new NicknameModel();
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(user));
            nicknameModel.setNickname(userModel.getNickname());
            ExistsUserModel existsModel = authentificationController.checkExistsUser(nicknameModel).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);

            threadModel.thread = databaseService.getThreadsByUser(nicknameModel.getNickname());
            for (OneThread th : threadModel.thread) {
                th.setUserName(databaseService.getNicknameById(th.getUserId()));
                th.setNrPosts(forumController.getNrComm(th.getId()));
            }
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/threadExists/{thread}", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsThread(@RequestHeader("Authorization") String token, @PathVariable int category, @PathVariable int thread) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

            ExistsModel existsModel = new ExistsModel();
            existsModel.setExists(0);

            existsModel = categorycontroller.checkExistsCategory(token, category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity<>(existsModel, HttpStatus.OK);

            ExistsModel existsThread = new ExistsModel();
            existsThread.setExists(databaseService.checkThreadExits(thread));
            return new ResponseEntity<>(existsThread, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/AddThread", method = RequestMethod.POST)
    public ResponseEntity addThread(@RequestHeader("Authorization") String token, @RequestBody OneThread oneThread,
                                    @PathVariable int category) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            if (oneThread.getName() == null || oneThread.getDescription() == null)
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            oneThread.setCategoryId(category);
            oneThread.setUserId(databaseService.getIdByToken(token));
            oneThread.setStatusId(1);
            ExistsModel existsModel = categorycontroller.checkExistsCategory(token, oneThread.getCategoryId()).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Category does not exists in database"), HttpStatus.OK);
            NicknameModel nicknameModel = new NicknameModel();
            nicknameModel.setNickname(databaseService.getNicknameById(oneThread.getUserId()));
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(oneThread.getUserId()));
            if (userModel.getStatus_id() == 3)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Blocked user, can not add thread"), HttpStatus.OK);
            databaseService.addThread(oneThread);
            return new ResponseEntity
                    (new ResponseMessageModel("Thread Added"), HttpStatus.CREATED);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(new ResponseMessageModel(sqlEx.getMessage()) , HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/{threadId}", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deleteThread(@RequestHeader("Authorization") String token, @PathVariable int category,
                                                             @PathVariable int threadId) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            OneThread thread = new OneThread();
            thread.setUserId(databaseService.getIdByToken(token));

            ExistsModel existsModel = checkExistsThread(token, threadId, category).getBody();
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
