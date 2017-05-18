package BitChess.Controllers;

import BitChess.Models.*;
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
    CategoryController category;

    @CrossOrigin
    @RequestMapping(value = "/AllThreads", method = RequestMethod.GET)
    public ResponseEntity getAllCategories() {
        try {
            ThreadModel threadModel = new ThreadModel();
            threadModel.thread = databaseService.getAllThreads();
            System.out.print(threadModel.thread.toString());
            return new ResponseEntity(threadModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/category/ThreadExists", method = RequestMethod.POST)
    public ResponseEntity<ExistsModel> checkExistsThread(@RequestBody OneThread oneThread) {
        try {
            if (oneThread.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsModel existsThread = new ExistsModel();
            existsThread.setExists(databaseService.checkThreadExits(oneThread.getId()));
            return new ResponseEntity<>(existsThread, HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
