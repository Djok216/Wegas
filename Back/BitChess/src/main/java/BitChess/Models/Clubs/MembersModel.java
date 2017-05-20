package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonRootName;

import java.util.List;
import java.util.Vector;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MembersModel extends Vector {
    List<String> members;

    public MembersModel() {
        members = new Vector<>();
    }

    public MembersModel(List<String> members) {
        this.members = members;
    }

    public List<String> getMembers() {
        return members;
    }

    public void setMembers(List<String> members) {
        this.members = members;
    }

    @JsonIgnore
    public Boolean isValid() {
        if(members == null) return false;
        return true;
    }
}
