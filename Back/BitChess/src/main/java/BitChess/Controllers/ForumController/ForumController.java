package BitChess.Controllers.ForumController;

import BitChess.Controllers.AuthenticationController;
import BitChess.Models.ExistsUserModel;
import BitChess.Models.Forum.ExistsModel;
import BitChess.Models.Forum.OneCategory;
import BitChess.Models.Forum.OnePost;
import BitChess.Models.Forum.OneThread;
import BitChess.Models.NicknameModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Models.UserModel;
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

    @CrossOrigin
    @RequestMapping(value = "/category/thread/addpost", method = RequestMethod.POST)
    public ResponseEntity addPost(@RequestBody OnePost onePost) {
        try {
            if (onePost.getContent() == null || onePost.getUserId() == null || onePost.getThreadId() == null)
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            OneThread thread = new OneThread();
            thread.setId(onePost.getThreadId());
            ExistsModel existsModel = threadController.checkExistsThread(thread).getBody();
            if(existsModel.getExists() == 0 )
                return new ResponseEntity
                        (new ResponseMessageModel("Thread does not exists in database"), HttpStatus.OK);

            NicknameModel nicknameModel=new NicknameModel();
            nicknameModel.setNickname(databaseService.getNicknameById(onePost.getUserId()));
            ExistsUserModel existsModel2 = authentificationController.checkExistsUser(nicknameModel).getBody();
            System.out.println("!!1");
            if(existsModel2.getExists() == 0 )
                return new ResponseEntity
                        (new ResponseMessageModel("User does not exists in database"), HttpStatus.OK);
            UserModel userModel =  databaseService.setUserByNickname(databaseService.getNicknameById(onePost.getUserId()));
            System.out.println("!!2");
            if(userModel.getStatus_id()==3)//blocked
                return new ResponseEntity
                        (new ResponseMessageModel("Blocked user, can not add comment"), HttpStatus.OK);
            System.out.println("!!3");
            databaseService.addPost(onePost);
            System.out.println("!!4");
            return new ResponseEntity
                    (new ResponseMessageModel("Post Added"), HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
