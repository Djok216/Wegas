package BitChess.Controllers.ForumController;

import BitChess.Models.CategoryModel;
import BitChess.Models.Forum.ExistsModel;
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
    AutorizationService autorizationService = new AutorizationService();

    @CrossOrigin
    @RequestMapping(value = "/Allcategory", method = RequestMethod.GET)
    public ResponseEntity getAllCategories() {
        try {
            CategoryModel categoryModel = new CategoryModel();
            categoryModel.category = databaseService.getAllCategories();
            System.out.print(categoryModel.category.toString());
            return new ResponseEntity(categoryModel, HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>( sqlEx.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/{category}/exists", method = RequestMethod.GET)
    public ResponseEntity<ExistsModel> checkExistsCategory(@PathVariable int category) {
        try {
            ExistsModel existsCategory = new ExistsModel();
            existsCategory.setExists(databaseService.checkCategoryExits(category));
            return new ResponseEntity<>(existsCategory, HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
