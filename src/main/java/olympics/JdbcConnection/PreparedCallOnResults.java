package olympics.JdbcConnection; /**
 * Created by c1519287 on 22/11/2016.
 */
import java.sql.*;

public class PreparedCallOnResults {
   private String names = "there is such recored";
    public String getResult (String eventName, Integer rank) throws SQLException {
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;

        try {
            con = jdbcCon.getCon();
            PreparedStatement getName = con.prepareStatement
                    ("CALL new_getResultFromRank(?,?)");
            System.out.println("quering");
            System.out.println(eventName);
            getName.setString(1, eventName);
            getName.setInt(2, rank);
            System.out.println("rs");
            ResultSet rs = getName.executeQuery();
            if(rs.next()){
                if(rs.getString(1) != null) {
                    names = rs.getString(1);
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null){
                jdbcCon.closeCon(con);
            }
        }

        return names;
    }
}