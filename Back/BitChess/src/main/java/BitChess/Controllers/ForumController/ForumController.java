package BitChess.Controllers.ForumController;

import BitChess.Controllers.AuthenticationController;
import BitChess.Models.ExistsUserModel;
import BitChess.Models.Forum.ExistsModel;
import BitChess.Models.Forum.OnePost;
import BitChess.Models.Forum.OneThread;
import BitChess.Models.Forum.PostModel;
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
 * Project name BitChess.
 * Created by Turcu Nicusor on 13-May-17.
 */
@RestController
public class ForumController {
    @Autowired
    private ConcreteDatabaseService databaseService;
    @Autowired
    ThreadController threadController;
    @Autowired
    AuthenticationController authentificationController;
    @Autowired
    ThreadController threadcontroller;
    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/{category}/{thread}/addpost", method = RequestMethod.POST)
    public ResponseEntity addPost(@RequestHeader("Authorization") String token, @RequestBody OnePost onePost,
                                  @PathVariable int category, @PathVariable int thread) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            if (onePost.getContent() == null)
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

            onePost.setThreadId(thread);
            onePost.setUserId(databaseService.getIdByToken(token));
            NicknameModel nicknameModel = new NicknameModel();
            nicknameModel.setNickname(databaseService.getNicknameById(onePost.getUserId()));
            ExistsUserModel existsModel2 = authentificationController.checkExistsUser(nicknameModel).getBody();
            if (existsModel2.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(onePost.getUserId()));
            if (userModel.getStatus_id() == 3)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Blocked user, can not add Post"), HttpStatus.OK);

            OneThread oneThread = new OneThread();
            oneThread.setId(onePost.getThreadId());
            ExistsModel existsModel = threadController.checkExistsThread(token, oneThread.getId(), category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);
            databaseService.addPost(onePost);

            return new ResponseEntity
                    (new ResponseMessageModel("Post Added"), HttpStatus.CREATED);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "{category}/{thread}/getPostByThread", method = RequestMethod.GET)
    public ResponseEntity getPostsByThreads(@RequestHeader("Authorization") String token, @PathVariable int category, @PathVariable int thread) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            PostModel postModel = new PostModel();
            ExistsModel existsModel = threadcontroller.checkExistsThread(token, category, thread).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            postModel.posts = databaseService.getPostsByThread(thread);
            for (OnePost post : postModel.posts) {
                post.setUserName(databaseService.getNicknameById(post.getUserId()));
            }
            return new ResponseEntity(postModel, HttpStatus.CREATED);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public int getNrComm(int th) {
        try {
            PostModel postModel = new PostModel();
            postModel.posts = databaseService.getPostsByThread(th);
            return (postModel.posts.size());
        } catch (SQLException sqlEx) {
            return -1;
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/{thread}/deletePost/{postId}", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deletePost(@RequestHeader("Authorization") String token,
                                                           @PathVariable int category, @PathVariable int thread,
                                                           @PathVariable int postId) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            ExistsModel existsModel = checkExistsPost(token, category, thread, postId).getBody();

            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Post does not exists in database"), HttpStatus.OK);

            NicknameModel nicknameModel = new NicknameModel();
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(databaseService.getIdByToken(token)));
            if (userModel.getStatus_id() != 1)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Not Admin, can not delete Post"), HttpStatus.OK);

            databaseService.deletePost(postId);
            return new ResponseEntity<>(new ResponseMessageModel("Post deleted successfully."), HttpStatus.CREATED);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/{thread}/{post}/postExists", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsPost(@RequestHeader("Authorization") String token,
                                                       @PathVariable int category, @PathVariable int thread, @PathVariable int post) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ExistsModel(0), HttpStatus.UNAUTHORIZED);

            ExistsModel existsModel = threadController.checkExistsThread(token, thread, category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            ExistsModel existsPost = new ExistsModel();
            existsPost.setExists(databaseService.checkPostExits(post));
            return new ResponseEntity<>(existsPost, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
