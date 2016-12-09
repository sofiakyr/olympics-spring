package olympics.controllers;

import olympics.JdbcConnection.AllSports;
import olympics.JdbcConnection.SportsPrepared;
import olympics.domain.formObjects.StringObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.Map;


@Controller
@SessionAttributes({"formEvents","formSports"})
public class ResultsFormController {

       AllSports prepared = new AllSports();


        @RequestMapping(value="/resultForm", method = RequestMethod.GET)
        public ModelAndView addPatient(Model model) throws SQLException {
            model.addAttribute("formSports", prepared.getSports());
            return new ModelAndView("resultForm",(Map<String,?>) model.asMap());
        }

    }

