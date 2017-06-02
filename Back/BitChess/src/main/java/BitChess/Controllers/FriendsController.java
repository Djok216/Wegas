package BitChess.Controllers;

import BitChess.Models.Friends.FriendshipModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 28-May-17.
 */
@RestController
public class FriendsController {
    @Autowired
    private ConcreteDatabaseService databaseService;

    @CrossOrigin
    @RequestMapping(value = "/friends/checkFriendshipExist/id1={first_user_id}:id2={second_user_id}", method = RequestMethod.GET)
    public ResponseEntity<?> checkFriendshipExists(@PathVariable Integer first_user_id, @PathVariable Integer second_user_id) {
        try {
            FriendshipModel friendshipModel = new FriendshipModel(first_user_id,second_user_id);
            if (databaseService.existsFriendship(friendshipModel))
                return new ResponseEntity<>(new ResponseMessageModel("Friendship exist."), HttpStatus.OK);
            return new ResponseEntity<>(new ResponseMessageModel("Friendship doesn't exist."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/friends/addFriendship", method = RequestMethod.POST)
    public ResponseEntity<?> addFriendship(@RequestBody FriendshipModel friendshipModel) {
        try {
            if (databaseService.existsFriendship(friendshipModel))
                return new ResponseEntity<>(new ResponseMessageModel("Friendship already exist."), HttpStatus.OK);
            databaseService.addFriends(friendshipModel);
            return new ResponseEntity<>(new ResponseMessageModel("Friendship added successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}