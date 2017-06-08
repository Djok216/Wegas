package BitChess.Models.Users;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 07-Jun-17.
 */
public class UserInfo {
    private String email, nickname, name, createdAt, status, clubName;
    private Integer wins, loses, draws;

    public UserInfo() {

    }

    public UserInfo(String email, String nickname, String name, String createdAt, String status_description, String clubName, Integer wins, Integer loses, Integer draws) {
        this.email = email;
        this.nickname = nickname;
        this.name = name;
        this.createdAt = createdAt;
        this.status = status_description;
        this.clubName = clubName;
        this.wins = wins;
        this.loses = loses;
        this.draws = draws;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public Integer getWins() {
        return wins;
    }

    public void setWins(Integer wins) {
        this.wins = wins;
    }

    public Integer getLoses() {
        return loses;
    }

    public void setLoses(Integer loses) {
        this.loses = loses;
    }

    public Integer getDraws() {
        return draws;
    }

    public void setDraws(Integer draws) {
        this.draws = draws;
    }
}
