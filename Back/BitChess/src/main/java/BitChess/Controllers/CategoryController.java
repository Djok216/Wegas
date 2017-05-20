package BitChess.Controllers;

import BitChess.Models.*;
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
    @RequestMapping(value = "/category/categoryExists", method = RequestMethod.POST)
    public ResponseEntity<ExistsModel> checkExistsCategory(@RequestBody OneCategory oneCategory) {
        try {
            if (oneCategory.getId() == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            ExistsModel existsCategory = new ExistsModel();
            existsCategory.setExists(databaseService.checkCategoryExits(oneCategory.getId()));
            return new ResponseEntity<>(existsCategory, HttpStatus.OK);
        }catch (SQLException sqlEx) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}