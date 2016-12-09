package olympics.JdbcConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by c1519287 on 02/12/2016.
 */
public class EventsFromSports {

    public List getEvents(String sportName) throws SQLException {
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;
        List<String> events = new ArrayList<>();
        try {
            con = jdbcCon.getCon();
            PreparedStatement getName = con.prepareStatement
                    ("CALL select_events_from_sports(?)");

            getName.setString(1, sportName);
            ResultSet rs = getName.executeQuery();

            while (rs.next()) {
                  events.add(rs.getString(1));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null){
                jdbcCon.closeCon(con);
            }
        }
       return events;
    }

}
