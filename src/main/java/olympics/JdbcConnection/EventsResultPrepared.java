package olympics.JdbcConnection;

import olympics.domain.modelObjects.ResultsModelObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by c1519287 on 06/12/2016.
 */
public class EventsResultPrepared {
    public List<ResultsModelObject> getEventsResult(String eventName) throws SQLException {
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;
        List<ResultsModelObject> resultsModelObjects = new ArrayList<>();
        try {
            con = jdbcCon.getCon();
            PreparedStatement getResults = con.prepareStatement
                    ("CALL get_event_results (?)");

            getResults.setString(1, eventName);
            ResultSet rs = getResults.executeQuery();

            while (rs.next()) {
                ResultsModelObject rmo = new ResultsModelObject(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4)
                );
                System.out.println(rmo.toString());
                resultsModelObjects.add(rmo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null){
                jdbcCon.closeCon(con);

                return resultsModelObjects;
            }
        }
        return null;
    }
}
