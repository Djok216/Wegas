package BitChess.Controllers;

import BitChess.Models.Clubs.ClubModel;
import BitChess.Models.Clubs.ClubStatisticsModel;
import BitChess.Models.Clubs.MembersModel;
import BitChess.Models.Clubs.SimpleStatisticModel;
import BitChess.Models.ResponseMessageModel;
import BitChess.Services.ConcreteDatabaseService;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Vector;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
@RestController
public class ClubsController {
    @Autowired
    private ConcreteDatabaseService databaseService;

    @CrossOrigin
    @RequestMapping(value = "/clubs/addClub", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> addClub(@RequestBody ClubModel clubModel) {
        try {
            return new ResponseEntity<>(new ResponseMessageModel("Club added successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/deleteClub", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deleteClub(@RequestBody ClubModel clubModel) {
        try {
            return new ResponseEntity<>(new ResponseMessageModel("Club deleted successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/general", method = RequestMethod.GET)
    public ResponseEntity<ClubStatisticsModel> getGeneralStatistics() {
        try {
            SimpleStatisticModel simpleStatisticModel = new SimpleStatisticModel("Romania Club", 3);
            SimpleStatisticModel simpleStatisticModel1 = new SimpleStatisticModel("Ungaria Club", 2);
            SimpleStatisticModel simpleStatisticModel2 = new SimpleStatisticModel("Bulgaria Club", 1);
            Vector<SimpleStatisticModel> v = new Vector<>();
            v.add(simpleStatisticModel);
            v.add(simpleStatisticModel1);
            v.add(simpleStatisticModel2);
            ClubStatisticsModel clubStatisticsModel = new ClubStatisticsModel(v);
            return new ResponseEntity<>(clubStatisticsModel, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/rating", method = RequestMethod.GET)
    public ResponseEntity<ClubStatisticsModel> getRatingStatistics() {
        try {
            SimpleStatisticModel simpleStatisticModel = new SimpleStatisticModel("test Club", 10);
            SimpleStatisticModel simpleStatisticModel1 = new SimpleStatisticModel("AK Club", 15);
            SimpleStatisticModel simpleStatisticModel2 = new SimpleStatisticModel("example Club", 1);
            Vector<SimpleStatisticModel> v = new Vector<>();
            v.add(simpleStatisticModel);
            v.add(simpleStatisticModel1);
            v.add(simpleStatisticModel2);
            ClubStatisticsModel clubStatisticsModel = new ClubStatisticsModel(v);
            return new ResponseEntity<>(clubStatisticsModel, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/popularity", method = RequestMethod.GET)
    public ResponseEntity<ClubStatisticsModel> getPopularityStatistics() {
        try {
            SimpleStatisticModel simpleStatisticModel = new SimpleStatisticModel("test Club", 10);
            SimpleStatisticModel simpleStatisticModel1 = new SimpleStatisticModel("AK Club", 15);
            SimpleStatisticModel simpleStatisticModel2 = new SimpleStatisticModel("example Club", 1);
            Vector<SimpleStatisticModel> v = new Vector<>();
            v.add(simpleStatisticModel);
            v.add(simpleStatisticModel1);
            v.add(simpleStatisticModel2);
            ClubStatisticsModel clubStatisticsModel = new ClubStatisticsModel(v);
            return new ResponseEntity<>(clubStatisticsModel, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @GetMapping(value = "/clubs/{clubName}/addMember")
    public ResponseEntity<ResponseMessageModel> addClubMember(@PathVariable String clubName) {
        try {
            // check if club name exists
            return new ResponseEntity<>(new ResponseMessageModel(clubName), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @GetMapping(value = "/clubs/{clubName}/deleteMember")
    public ResponseEntity<ResponseMessageModel> deleteClubMember(@PathVariable String clubName) {
        try {
            // check if clubname exists
            return new ResponseEntity<>(new ResponseMessageModel(clubName), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @GetMapping(value = "/clubs/{clubName}/members")
    public ResponseEntity<MembersModel> getMembers(@PathVariable String clubName) {
        try {
            MembersModel membersModel = new MembersModel();
            membersModel.add("Cornel");
            membersModel.add("Ionel");

            return new ResponseEntity<>(membersModel, HttpStatus.OK);
        } catch (Exception ex ) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
