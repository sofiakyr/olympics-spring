package olympics.controllers;

import olympics.domain.formObjects.StringObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.Map;

/**
 * Created by c1519287 on 09/12/2016.
 */
@Controller
public class IntroController {

    @RequestMapping(value="/", method = RequestMethod.GET)
    public ModelAndView addPatient(Model model) throws SQLException {

        return new ModelAndView("/intro",(Map<String,?>) model.asMap());
    }

}
