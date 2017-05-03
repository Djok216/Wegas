package com.Lab9.controllers;

import com.Lab9.models.Request;
import com.Lab9.models.Response;
import com.Lab9.services.DatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Project name Lab9.
 * Created by Turcu Nicusor on 02-May-17.
 */

@RestController
public class HTTPController {
    @Autowired
    private DatabaseService databaseService;

    @RequestMapping(value = "/getTeamNameById", method = RequestMethod.POST)
    public ResponseEntity<Response> getTeamName(@RequestBody Request request) {
        Response response = new Response();
        response.name = databaseService.getTeamNamebyId(request.id);
        return new ResponseEntity<Response>(response, HttpStatus.OK);
    }
    @RequestMapping(value = "/getPlayerNameById", method = RequestMethod.POST)
    public ResponseEntity<Response> getPlayerName(@RequestBody Request request) {
        Response response = new Response();
        response.name = databaseService.getPlayerNamebyId(request.id);
        return new ResponseEntity<Response>(response, HttpStatus.OK);
    }
}
