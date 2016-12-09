package olympics.JdbcConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by c1519287 on 02/12/2016.
 */
public class AllSports {

    public List<String> getSports () throws SQLException {
        System.out.println("in  boyzz");
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;
        List<String> sports = new ArrayList<>();

        try {
            con = jdbcCon.getCon();
            Statement stmt = con.createStatement();
            String query = "select * from sports";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {

                String sportsName = rs.getString(2);
                sports.add(rs.getString(2));
                System.out.println(sportsName );
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null){
                jdbcCon.closeCon(con);
            }
        }

        return sports;
    }
}