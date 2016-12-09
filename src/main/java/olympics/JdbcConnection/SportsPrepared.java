package olympics.JdbcConnection;

import olympics.domain.modelObjects.SportModelObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by c1519287 on 02/12/2016.
 */
public class SportsPrepared {

    public List<SportModelObject> getSports () throws SQLException {
        System.out.println("in  boyzz");
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;
        List<SportModelObject> sports = new ArrayList<>();

        try {
            con = jdbcCon.getCon();
            Statement stmt = con.createStatement();
            String query = "select * from sports";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {

                SportModelObject sport = new SportModelObject();
                sport.setSportName(rs.getString(2));
                sport.setIconUrl(rs.getString(3));
                sports.add(sport);
                System.out.println(sport.toString());

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