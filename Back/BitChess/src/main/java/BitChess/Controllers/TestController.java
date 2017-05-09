package BitChess.Controllers;

import BitChess.Models.TestModel;
import BitChess.Services.DatabaseService;
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
    private DatabaseService databaseService;

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ResponseEntity<TestModel> test() {
        TestModel test = new TestModel();
        test.test = databaseService.test();
        return new ResponseEntity<TestModel>(test, HttpStatus.OK);
    }
}