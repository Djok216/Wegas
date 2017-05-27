package BitChess.Controllers;

import BitChess.Models.Games.GameEndedModel;
import BitChess.Models.Games.GameIdModel;
import BitChess.Models.Games.GameStartedModel;
import BitChess.Models.ResponseMessageModel;
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

    @CrossOrigin
    @RequestMapping(value = "/games/addGameStarted", method = RequestMethod.POST)
    public ResponseEntity<?> addGameStarted(@RequestBody GameStartedModel gameStartedModel) {
        try {
            if(!gameStartedModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            GameIdModel gameIdModel = new GameIdModel(databaseService.addGameStarted(gameStartedModel));
            return new ResponseEntity<>(gameIdModel, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/games/addGameEnded", method = RequestMethod.PUT)
    public ResponseEntity<?> addGameEnded(@RequestBody GameEndedModel gameEndedModel) {
        try {
            if(!gameEndedModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            databaseService.addGameEnded(gameEndedModel);
            return new ResponseEntity<>(new ResponseMessageModel("Game successfully saved."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
