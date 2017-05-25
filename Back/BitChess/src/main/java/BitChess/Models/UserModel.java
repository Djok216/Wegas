package BitChess.Models;

import java.text.DateFormat;

/**
 * Created by Tamara on 25.05.2017.
 */
public class UserModel {
    private String email, nickname, password, name, createdAt, status_description, facebook_id;
    private int id, wins, loses, draws, status_id, club_id;

    public UserModel(){
    }
    public UserModel(int id){
        this.id=id;
        }
    public UserModel(int id, String facebook_id, String name, String email, String nickname, String password, int wins,
                     int loses, int draws, String createdAt, int club_id, int status_id, String status_description){
        this.id  = id;
        this.facebook_id = facebook_id;
        this.name = name;
        this.email = email;
        this.nickname = nickname;
        this.password = password;
        this.wins = wins;
        this.loses = loses;
        this.draws = draws;
        this.status_id = status_id;
        this.club_id=club_id;
        this.createdAt = createdAt;
        this.status_description = status_description;
    }

    public String getName() {
        return name;
    }

    public String getStatus_description() {
        return status_description;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFacebook_id() {
        return facebook_id;
    }

    public void setFacebook_id(String facebook_id) {
        this.facebook_id = facebook_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public int getClub_id() {
        return club_id;
    }

    public int getDraws() {
        return draws;
    }

    public int getId() {
        return id;
    }

    public int getLoses() {
        return loses;
    }

    public int getStatus_id() {
        return status_id;
    }

    public int getWins() {
        return wins;
    }

    public String getEmail() {
        return email;
    }

    public String getNickname() {
        return nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public void setDraws(int draws) {
        this.draws = draws;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setLoses(int looses) {
        this.loses = loses;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public void setWins(int wins) {
        this.wins = wins;
    }

    @Override
    public String toString() {
        String s = id + "\n" + facebook_id + "\n" + name + "\n" + nickname + "\n" + createdAt + "\n" + status_description;
        return s;
    }
}
