package BitChess.Controllers;

import BitChess.Models.Clubs.*;
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
 * Created by Turcu Nicusor on 20-May-17.
 */
@RestController
public class ClubsController {
    @Autowired
    private ConcreteDatabaseService databaseService;
    @Autowired
    AutorizationService autorizationService = new AutorizationService();

    @RequestMapping(value = "/clubs/addClub", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> addClub(@RequestHeader("Authorization") String token, @RequestBody ClubModel clubModel) {
        try {
            if (!clubModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            databaseService.insertNewClub(clubModel.getClubName());
            return new ResponseEntity<>(new ResponseMessageModel("Club added successfully."), HttpStatus.OK);
        } catch (SQLException sqlEx) {
            return new ResponseEntity<>(new ResponseMessageModel("A club with the same name already exists."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/deleteClub", method = RequestMethod.DELETE)
    public ResponseEntity<ResponseMessageModel> deleteClub(@RequestHeader("Authorization") String token, @RequestBody ClubModel clubModel) {
        try {
            if (!clubModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if (!databaseService.existsClub(clubModel.getClubName()))
                return new ResponseEntity<>(new ResponseMessageModel("Cannot delete nonexistent club."), HttpStatus.OK);
            else databaseService.deleteClub(clubModel.getClubName());
            return new ResponseEntity<>(new ResponseMessageModel("Club deleted successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/general", method = RequestMethod.GET)
    public ResponseEntity<?> getGeneralStatistics(@RequestHeader("Authorization") String token) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            return new ResponseEntity<>(databaseService.getGeneralStatistic(), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/rating/{topX}", method = RequestMethod.GET)
    public ResponseEntity<?> getRatingStatistics(@RequestHeader("Authorization") String token, @PathVariable Integer topX) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            return new ResponseEntity<>(databaseService.getClubsByRating(topX), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/statistics/popularity/{topX}", method = RequestMethod.GET)
    public ResponseEntity<?> getPopularityStatistics(@RequestHeader("Authorization") String token, @PathVariable Integer topX) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            return new ResponseEntity<>(databaseService.getClubsByPopularity(topX), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/{clubName}/addMember", method = RequestMethod.POST)
    public ResponseEntity<ResponseMessageModel> addClubMember(@RequestHeader("Authorization") String token, @PathVariable
            String clubName, @RequestBody ClubMemberModel clubMemberModel) {
        try {
            if (!clubMemberModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if (!databaseService.existsClub(clubName))
                return new ResponseEntity<>(new ResponseMessageModel("Cannot add member to a nonexistent club."), HttpStatus.OK);
            if (!databaseService.existsUser(clubMemberModel.getMemberName()))
                return new ResponseEntity<>(new ResponseMessageModel("Cannot add nonexistent user to a club."), HttpStatus.OK);
            if (databaseService.isClubMember(clubName, clubMemberModel.getMemberName()))
                return new ResponseEntity<>(new ResponseMessageModel("User is already a member to this club."), HttpStatus.OK);
            else databaseService.addClubMember(clubName, clubMemberModel.getMemberName());
            return new ResponseEntity<>(new ResponseMessageModel("Member added successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/{clubName}/deleteMember", method = RequestMethod.PUT)
    public ResponseEntity<ResponseMessageModel> deleteClubMember(@RequestHeader("Authorization") String token, @PathVariable
            String clubName, @RequestBody ClubMemberModel clubMemberModel) {
        try {
            if (!clubMemberModel.isValid()) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if (!databaseService.existsClub(clubName))
                return new ResponseEntity<>(new ResponseMessageModel("Cannot delete member from a nonexistent club."), HttpStatus.OK);
            if (!databaseService.existsUser(clubMemberModel.getMemberName()))
                return new ResponseEntity<>(new ResponseMessageModel("Cannot delete nonexistent user from a club."), HttpStatus.OK);
            if (!databaseService.isClubMember(clubName, clubMemberModel.getMemberName()))
                return new ResponseEntity<>(new ResponseMessageModel("User don't belong to this club."), HttpStatus.OK);
            else databaseService.deleteClubMember(clubMemberModel.getMemberName());
            return new ResponseEntity<>(new ResponseMessageModel("Member deleted successfully."), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(new ResponseMessageModel(ex.getMessage()), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @CrossOrigin
    @RequestMapping(value = "/clubs/{clubName}/members", method = RequestMethod.GET)
    public ResponseEntity<?> getMembers(@RequestHeader("Authorization") String token, @PathVariable String clubName) {
        try {
            if (!autorizationService.checkCredentials(token))
                return new ResponseEntity<>(new ResponseMessageModel("Invalid credentials!"), HttpStatus.UNAUTHORIZED);
            if (!databaseService.existsClub(clubName))
                return new ResponseEntity<>(new ResponseMessageModel("Club does not exists."), HttpStatus.OK);
            return new ResponseEntity<>(databaseService.getClubMembers(clubName), HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
