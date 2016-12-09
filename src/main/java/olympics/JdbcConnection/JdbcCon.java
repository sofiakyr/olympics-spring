package olympics.JdbcConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by c1519287 on 01/12/2016.
 */
public class JdbcCon {

    public Connection getCon()throws SQLException, ClassNotFoundException{
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/olympics", "root", "comsc");
            return con;
        }catch (Exception e){
            e.printStackTrace();
            throw e;
        }
    }

    public void closeCon(Connection con) throws SQLException {
        con.close();
    }

}
