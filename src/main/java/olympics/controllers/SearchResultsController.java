package olympics.controllers;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import olympics.domain.formObjects.ResultsFormObject;
import olympics.domain.services.ResultServiceImpl;
import javax.validation.Valid;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import olympics.JdbcConnection.*;
/**
 * Created by c1519287 on 01/12/2016.
 */
@Controller
@SessionAttributes({"searchResult","sports","eventName"})
public class SearchResultsController {
    private ResultServiceImpl resultService;
    private AllSports sports = new AllSports();
    @Autowired
    public SearchResultsController(ResultServiceImpl aresultService) {

        resultService = aresultService;
    }

    @RequestMapping(value="/searchResults", method = RequestMethod.GET)
    public ModelAndView addPatient(@RequestParam(name = "eventName", required = false) String eventName,Model model) throws SQLException {
        ResultsFormObject formObject = new ResultsFormObject();
        if (eventName==null){
            model.addAttribute("eventName", "eventName");
        }else{
            model.addAttribute("eventName", eventName);

        }
        model.addAttribute("form",formObject);
        model.addAttribute( "sports", sports.getSports());
        return new ModelAndView("/searchResults",(Map<String,?>) model.asMap());
    }

    @RequestMapping(value = "/searchResults", method = RequestMethod.POST)
    public ModelAndView addPersonFromForm
            (@Valid ResultsFormObject form, BindingResult bindingResult, Model attrs) throws SQLException {

        if (bindingResult.hasErrors()) {
            System.out.println("Binding Error.  There were " + bindingResult.getErrorCount() + " errors.");
            System.out.println(bindingResult.getAllErrors().toString());
            attrs.addAttribute("form", form);
            return new ModelAndView("addPatient", attrs.asMap());
        }

        System.out.println("Form Received");
        resultService.getResult(form);

        attrs.addAttribute("searchResult",resultService.getResult(form));
        return new ModelAndView("redirect:/searchResults", attrs.asMap());


    }

    @RequestMapping(value = "/eventsFromSport", method = RequestMethod.POST)
    @ResponseBody
    public String eventFromSport(@RequestParam("sport") String sport) {
        final String ERROR_TEXT = "There was an error";
        EventsFromSports eventsFromSports = new EventsFromSports();
        try {
            List<String> events = eventsFromSports.getEvents(sport);
            return new Gson().toJson(events);
        } catch (SQLException e) {
            e.printStackTrace();
            return ERROR_TEXT;
        }
    }

}
