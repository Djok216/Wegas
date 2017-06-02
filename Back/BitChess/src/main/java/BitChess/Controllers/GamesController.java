package BitChess.Controllers;

import BitChess.Models.Games.GameEndedModel;
import BitChess.Models.Games.GameIdModel;
import BitChess.Models.Games.GameStartedModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Services.AutorizationService;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 27-May-17.
 */
@RestController
public class GamesController {
    @Autowired
    private ConcreteDatabaseService databaseService;
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/games/addGameStarted", method = RequestMethod.POST)
    public ResponseEntity<?> addGameStarted(@RequestHeader("Authorization") String token, @RequestBody GameStartedModel gameStartedModel) {
        try {
            if (!gameStartedModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if (!databaseService.existsUser(gameStartedModel.getFirstPlayerId()))
                return new ResponseEntity<Object>(new ResponseMessageModel("First user does not exists in database."), HttpStatus.OK);
            if (!databaseService.existsUser(gameStartedModel.getSecondPlayerId()))
                return new ResponseEntity<Object>(new ResponseMessageModel("Second user does not exists in database."), HttpStatus.OK);
            if (!autorizationService.checkCredentials(databaseService, token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            GameIdModel gameIdModel = new GameIdModel(databaseService.addGameStarted(gameStartedModel));
            return new ResponseEntity<>(gameIdModel, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/games/addGameEnded", method = RequestMethod.PUT)
    public ResponseEntity<?> addGameEnded(@RequestHeader("Authorization") String token, @RequestBody GameEndedModel gameEndedModel) {
        try {
            if (!gameEndedModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if(!databaseService.existsGame(gameEndedModel.getGameId()))
                return new ResponseEntity<Object>(new ResponseMessageModel("Invalid game id."), HttpStatus.OK);
            if (!autorizationService.checkCredentials(databaseService, token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            databaseService.addGameEnded(gameEndedModel);
            return new ResponseEntity<>(new ResponseMessageModel("Game successfully saved."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
