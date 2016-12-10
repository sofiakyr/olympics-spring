package olympics.domain.modelObjects;

/**
 * Created by c1519287 on 06/12/2016.
 */
public class ResultsModelObject {
    private int rank;
    private String name;
    private String record;
    private String country;

    public ResultsModelObject(String name, String record, int rank, String country) {
        this.rank = rank;
        this.name = name;
        this.record = record;
        this.country = country;
    }

    public ResultsModelObject() {

    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
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
