package olympics.domain.services;

import olympics.domain.formObjects.ResultsFormObject;

import java.sql.SQLException;

/**
 * Created by c1519287 on 01/12/2016.
 */
public interface ResultServiceImpl {
    public String getResult(ResultsFormObject form) throws SQLException;
}
