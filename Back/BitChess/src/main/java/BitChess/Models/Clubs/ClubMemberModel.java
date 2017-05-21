package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 21-May-17.
 */
public class ClubMemberModel {
    private String memberName;

    public ClubMemberModel() {
    }

    public ClubMemberModel(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    @JsonIgnore
    public Boolean isValid() {
        if(getMemberName() == null) return false;
        return true;
    }
}
