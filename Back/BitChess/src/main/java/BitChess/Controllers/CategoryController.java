package BitChess.Controllers;

import BitChess.Models.CategoryModel;
import BitChess.Services.ConcreteDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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
    @RequestMapping(value = "/category", method = RequestMethod.GET)
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
}
