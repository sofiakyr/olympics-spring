package olympics.domain.modelObjects;

/**
 * Created by c1519287 on 06/12/2016.
 */
public class ResultsModelObject {
    private int rank;
    private String name;
    private String record;

    public ResultsModelObject(String name, String record, int rank) {
        this.rank = rank;
        this.name = name;
        this.record = record;
    }

    public ResultsModelObject() {

    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }

    @Override
    public String toString() {
        return "ResultsModelObject{" +
                "rank=" + rank +
                ", name='" + name + '\'' +
                ", record='" + record + '\'' +
                '}';
    }
}
