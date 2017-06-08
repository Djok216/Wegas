package BitChess.Controllers.StatsController;

import BitChess.Models.Stats.CategoriesSModel;
import BitChess.Models.Stats.GamesAndDays;
import BitChess.Models.Stats.TopActiveUsersModel;
import BitChess.Models.Stats.TopThreadsModel;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

/**
 * Created by CristinaU on 28/05/2017.
 */
@RestController
public class StatisticsController {
    @Autowired
    ConcreteDatabaseService databaseService;

    @CrossOrigin
    @RequestMapping(value = "/stats/nrofusers", method = RequestMethod.GET)
    public ResponseEntity getNrOfUsers() {
        try {
            Integer nr = databaseService.getNumberOfUsers();
            //System.out.print(i);
            return new ResponseEntity(nr, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/stats/{nroflatestgames}", method = RequestMethod.GET)
    public ResponseEntity getNrOfLatestGames(@PathVariable int nroflatestgames) {
        try {
            Integer nr = databaseService.getNumberOfLatestGames(nroflatestgames);
            return new ResponseEntity(nr, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/stats/topdiscussed", method = RequestMethod.GET)
    public ResponseEntity getTopThreads() {
        try {
            TopThreadsModel t = databaseService.getTopDiscussedThreads();
            //System.out.print(i);
            return new ResponseEntity(t, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/stats/topactive", method = RequestMethod.GET)
    public ResponseEntity getTopActive() {
        try {
            TopActiveUsersModel t = databaseService.getTopActiveUsers();
            //System.out.print(i);
            return new ResponseEntity(t, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/stats/categoriesstats", method = RequestMethod.GET)
    public ResponseEntity getNrThreadsByCategory() {
        try {
            CategoriesSModel t = databaseService.getThreadsbyCategory();
            //System.out.print(i);
            return new ResponseEntity(t, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
