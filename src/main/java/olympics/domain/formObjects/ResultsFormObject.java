package olympics.domain.formObjects;

/**
 * Created by c1519287 on 01/12/2016.
 */
public class ResultsFormObject {
    private String eventName;
    private int rank;

    public ResultsFormObject(String eventName, int rank) {
        this.eventName = eventName;
        this.rank = rank;
    }

    public ResultsFormObject(){}

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
