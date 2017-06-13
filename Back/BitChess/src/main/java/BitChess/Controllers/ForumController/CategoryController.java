package BitChess.Controllers.ForumController;

import BitChess.Models.CategoryModel;
import BitChess.Models.Forum.ExistsModel;
import BitChess.Models.ResponseMessageModel;
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
public class CategoryController {
    @Autowired
    ConcreteDatabaseService databaseService;
    @Autowired
    ThreadController threadController;
    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/Allcategory", method = RequestMethod.GET)
    public ResponseEntity getAllCategories(@RequestHeader("Authorization") String token) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);

            CategoryModel categoryModel = new CategoryModel();
            categoryModel.category = databaseService.getAllCategories();
//            System.out.print(categoryModel.category.toString());
//            for(OneCategory xcat : categoryModel.category){
//                xcat.setNrThreads(threadController.getNrThread(xcat.getId()));
//            }
            return new ResponseEntity(categoryModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/exists", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsCategory(@RequestHeader("Authorization") String token, @PathVariable int category) {
        try {
//            if (!autorizationService.checkCredentials(token))
//                return new ResponseEntity<>(new ExistsModel(0), HttpStatus.UNAUTHORIZED);

            ExistsModel existsCategory = new ExistsModel();
            existsCategory.setExists(databaseService.checkCategoryExits(category));
            return new ResponseEntity<>(existsCategory, HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
