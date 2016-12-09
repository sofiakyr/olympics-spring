package olympics.controllers;

import com.google.gson.Gson;
import olympics.JdbcConnection.EventsFromSports;
import olympics.JdbcConnection.SportsPrepared;
import olympics.JdbcConnection.StagesPrepared;
import olympics.domain.formObjects.StringObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by c1519287 on 09/12/2016.
 */

@Controller
@SessionAttributes("getSports")
public class SportController {

    SportsPrepared prepared = new SportsPrepared();

    @RequestMapping(value="/events", method = RequestMethod.GET)
    public ModelAndView addPatient(Model model) throws SQLException {
        model.addAttribute( "getSports", prepared.getSports());
        return new ModelAndView("/events",(Map<String,?>) model.asMap());
    }

}
