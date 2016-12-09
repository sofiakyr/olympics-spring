package olympics.JdbcConnection;

import olympics.domain.modelObjects.ResultsModelObject;
import olympics.domain.modelObjects.StageEntriesObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by c1519287 on 08/12/2016.
 */
public class StagesPrepared {
    private int i=2;
    public List<StageEntriesObject> getStages(String eventName) throws SQLException {
        System.out.println("in stages");
        JdbcCon jdbcCon = new JdbcCon();
        Connection con=null;

        List<StageEntriesObject> stageEntriesObject = new ArrayList<>();

        try {
            con = jdbcCon.getCon();
            PreparedStatement getResults = con.prepareStatement
                    ("CALL get_stages(?)");

            getResults.setString(1, eventName);
            ResultSet rs = getResults.executeQuery();


            StageEntriesObject entry=null;
            while (rs.next()) {
                System.out.println(i);

               if((i%2)==0) {
                   System.out.println("even");
                   entry = new StageEntriesObject();
                   if (rs.getInt(1) == 1) {
                       entry.setStageName("Final");
                   } else if (rs.getInt(1) == 2) {
                       entry.setStageName("Semi-Final");
                   } else if (rs.getInt(1) == 3) {
                       entry.setStageName("single-elimination tournament");
                   }

                   entry.setTeamName1(rs.getString(2));
                   entry.setRank1(rs.getInt(3));
                   i++;
               }else{
                   System.out.println("odd");
                   entry.setTeamName2(rs.getNString(2));
                   entry.setRank2(rs.getInt(3));
                   stageEntriesObject.add(entry);
                   System.out.println(entry.toString());
                   i++;
               }


            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null){
                jdbcCon.closeCon(con);
                return stageEntriesObject;
            }
        }
        return null;
    }
}
