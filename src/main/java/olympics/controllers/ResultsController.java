package olympics.controllers;

import com.google.gson.Gson;
import olympics.domain.formObjects.StringObject;
import olympics.domain.modelObjects.ResultsModelObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import olympics.domain.formObjects.ResultsFormObject;
import javax.validation.Valid;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import olympics.JdbcConnection.*;
/**
 * Created by c1519287 on 01/12/2016.
 */
@Controller
@SessionAttributes({"results","eventName"})
public class ResultsController {


    @RequestMapping(value="/results", method = RequestMethod.GET)
    public ModelAndView addPatient(@RequestParam(name = "eventName", required = false) String eventName,Model model) throws SQLException {
        model.addAttribute("form",new StringObject());
        if (eventName==null){
            model.addAttribute("eventName", "eventName");
        }else{
            model.addAttribute("eventName", eventName);

        }
        return new ModelAndView("/results",(Map<String,?>) model.asMap());
    }

    @RequestMapping(value = "/results", method = RequestMethod.POST)
    public ModelAndView addPersonFromForm
            ( @Valid StringObject form, BindingResult bindingResult, Model attrs) throws SQLException {

        if (bindingResult.hasErrors()) {
            System.out.println("Binding Error.  There were " + bindingResult.getErrorCount() + " errors.");
            System.out.println(bindingResult.getAllErrors().toString());
            attrs.addAttribute("form", form);
            return new ModelAndView("results", attrs.asMap());
        }

        System.out.println("Form Received");
        EventsResultPrepared prepared = new EventsResultPrepared();
        attrs.addAttribute("results", prepared.getEventsResult(form.getValue()));
        return new ModelAndView("redirect:/results", attrs.asMap());


    }



}
