package olympics.domain.modelObjects;

/**
 * Created by c1519287 on 09/12/2016.
 */
public class SportModelObject {
    private String SportName;
    private String iconUrl;

    public SportModelObject(String sportName, String iconUrl) {
        SportName = sportName;
        this.iconUrl = iconUrl;
    }

    public SportModelObject(){

    }

    public String getSportName() {
        return SportName;
    }

    public void setSportName(String sportName) {
        SportName = sportName;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }

    @Override
    public String toString() {
        return "SportModelObject{" +
                "SportName='" + SportName + '\'' +
                ", iconUrl='" + iconUrl + '\'' +
                '}';
    }
}
