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
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "{category}/{thread}/addpost", method = RequestMethod.POST)
    public ResponseEntity addPost(@RequestHeader("Authorization") String token, @RequestBody OnePost onePost,
                                  @PathVariable int category, @PathVariable int thread) {
        try {
            if (!autorizationService.checkCredentials(databaseService, token))
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
            ExistsModel existsModel = threadController.checkExistsThread(oneThread.getId(), category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);
            databaseService.addPost(onePost);

            return new ResponseEntity
                    (new ResponseMessageModel("Post Added"), HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @CrossOrigin
    @RequestMapping(value = "{category}/{thread}/getPostByThread", method = RequestMethod.GET)
    public ResponseEntity getPostsByThreads(@PathVariable int thread, @PathVariable int category) {
        try {
            PostModel postModel = new PostModel();
            ExistsModel existsModel = threadcontroller.checkExistsThread(thread, category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            postModel.posts = databaseService.getPostsByThread(thread);
            System.out.print(postModel.posts.toString());
            return new ResponseEntity(postModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(sqlEx.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/{thread}/deletePost", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deletePost(@RequestHeader("Authorization") String token, @RequestBody OnePost post,
                                                           @PathVariable int category, @PathVariable int thread) {
        try {
            if (!autorizationService.checkCredentials(databaseService, token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            if (post.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsModel existsModel = checkExistsPost(post, category, thread).getBody();

            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Post does not exists in database"), HttpStatus.OK);

            NicknameModel nicknameModel = new NicknameModel();
            UserModel userModel = databaseService.setUserByNickname(databaseService.getNicknameById(databaseService.getIdByToken(token)));
            if (userModel.getStatus_id() != 1)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Not Admin, can not delete Post"), HttpStatus.OK);

            databaseService.deletePost(post.getId());
            return new ResponseEntity<>(new ResponseMessageModel("Post deleted successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/{thread}/postExists", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsPost(@RequestBody OnePost post, @PathVariable int category, @PathVariable int thread) {
        try {
            ExistsModel existsModel = threadController.checkExistsThread(thread, category).getBody();
            if (existsModel.getExists() == 0)
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            if (post.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsModel existsPost = new ExistsModel();
            existsPost.setExists(databaseService.checkPostExits(post.getId()));
            return new ResponseEntity<>(existsPost, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
