package olympics.domain.modelObjects;

/**
 * Created by c1519287 on 07/12/2016.
 */
public class StageEntriesObject {
    private String StageName;
    private String teamName1;
    private String teamName2;
    private Integer rank1;
    private Integer rank2;

    public StageEntriesObject(String stageName, String teamName1, String teamName2, Integer rank1, Integer rank2) {
        StageName = stageName;
        this.teamName1 = teamName1;
        this.teamName2 = teamName2;
        this.rank1 = rank1;
        this.rank2 = rank2;

    }

    public StageEntriesObject() {
    }
        public String getStageName() {
        return StageName;
    }

    public void setStageName(String stageName) {
        StageName = stageName;
    }

    public String getTeamName1() {
        return teamName1;
    }

    public void setTeamName1(String teamName1) {
        this.teamName1 = teamName1;
    }

    public String getTeamName2() {
        return teamName2;
    }

    public void setTeamName2(String teamName2) {
        this.teamName2 = teamName2;
    }

    public Integer getRank1() {
        return rank1;
    }

    public void setRank1(Integer rank1) {
        this.rank1 = rank1;
    }

    public Integer getRank2() {
        return rank2;
    }

    public void setRank2(Integer rank2) {
        this.rank2 = rank2;
    }





    @Override
    public String toString() {
        return "StageEntriesObject{" +
                "StageName='" + StageName + '\'' +
                ", teamName1='" + teamName1 + '\'' +
                ", teamName2='" + teamName2 + '\'' +
                ", rank1=" + rank1 +
                ", rank2=" + rank2 +

                '}';
    }
}
