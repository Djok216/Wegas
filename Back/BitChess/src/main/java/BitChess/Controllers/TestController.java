package BitChess.Controllers;

import BitChess.Models.TestModel;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 09-May-17.
 */

@RestController
public class TestController {
    @Autowired
    private ConcreteDatabaseService databaseService;

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ResponseEntity<?> test() {
            TestModel test = new TestModel();
            test.test = databaseService.test();
            return new ResponseEntity<>(test, HttpStatus.OK);
    }
}