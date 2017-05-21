package BitChess.Models.Clubs;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;
import java.util.Vector;

/**
 * Project name BitChess.
 * Created by Turcu Nicusor on 20-May-17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MembersModel extends Vector {
    private List<String> members;

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
        return getMembers() == null;
    }
}
