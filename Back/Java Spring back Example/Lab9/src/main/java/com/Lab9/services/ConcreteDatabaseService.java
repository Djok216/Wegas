package com.Lab9.services;

import org.springframework.stereotype.Service;

import java.sql.*;

/**
 * Project name Lab9.
 * Created by Turcu Nicusor on 02-May-17.
 */
@Service
public class ConcreteDatabaseService implements DatabaseService {
    private Connection connection;

    public ConcreteDatabaseService() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "java", "sql");

            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
            System.out.println("  CONNECTED TO ORACLE DATABASE  ");
            System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        }
        catch (ClassNotFoundException e){
            System.err.println("FATAL ERROR: " + e.getMessage());
        }
        catch (SQLException e){
            System.err.println("DATABASE ERROR: " + e.getMessage());
        }
    }

    public String getTeamNamebyId(int id) {
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet =  statement.executeQuery("select name from teams where id = " + Integer.toString(id));
            resultSet.next();
            return resultSet.getString(1);
        }
        catch (Exception ex) {
            System.err.println("Error at getTeamNamebyId querry: " + ex.getMessage());
        }
        return null;
    }
    public String getPlayerNamebyId(int id) {
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet =  statement.executeQuery("select name from players where id = " + Integer.toString(id));
            resultSet.next();
            return resultSet.getString(1);
        }
        catch (Exception ex) {
            System.err.println("Error at getPlayerNamebyId querry: " + ex.getMessage());
        }
        return null;
    }
}
