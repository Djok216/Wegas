package BitChess.Controllers;

import BitChess.Models.Clubs.ClubStatisticsModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Models.Users.UserInfo;
import BitChess.Services.AutorizationService;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 07-Jun-17.
 */

@RestController
public class UserController {
    @Autowired
    private ConcreteDatabaseService databaseService;
    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ResponseEntity<?> getGeneralStatistics(@RequestHeader("Authorization") String token) {
        try {
            // hmm we will see this
            //if (!databaseService.existsUser(token))
            //    return new ResponseEntity<>(new ResponseMessageModel("Username does not exists in database"), HttpStatus.OK);
            return new ResponseEntity<>(databaseService.getUserInformation(token), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/getUserId", method = RequestMethod.GET)
    public ResponseEntity<?> getUserId(@RequestHeader("Authorization") String token) {
        try {
            return new ResponseEntity<>(databaseService.getIdByToken(token), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
