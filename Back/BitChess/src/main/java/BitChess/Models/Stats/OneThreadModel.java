package BitChess.Models.Stats;

/**
 * Created by CristinaU on 28/05/2017.
 */
public class OneThreadModel {
    private String threadName;
    private Integer nrComments;

    public OneThreadModel(String name, Integer nr) {
        threadName = name;
        nrComments = nr;
    }

    public Integer getNrComments() {
        return nrComments;
    }

    public String getThreadName() {
        return threadName;
    }

    public void setThreadName(String threadName) {
        this.threadName = threadName;
    }

    public void setNrComments(Integer nrComments) {
        this.nrComments = nrComments;
    }
}
