package olympics.domain.services;
import olympics.JdbcConnection.*;
import olympics.domain.formObjects.ResultsFormObject;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

/**
 * Created by c1519287 on 01/12/2016.
 */
@Service
public class ResultService implements ResultServiceImpl {

        private String eventName;
        private int rank;


    @Override
    public String getResult(ResultsFormObject form) throws SQLException {
        String result = null;
        eventName = form.getEventName();
        rank = form.getRank();
        PreparedCallOnResults prepared = new PreparedCallOnResults();
        result = prepared.getResult(eventName,rank);
        System.out.println(prepared.getResult(eventName,rank));
        return result;
    }

}
