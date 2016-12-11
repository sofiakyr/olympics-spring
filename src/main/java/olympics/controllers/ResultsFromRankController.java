package olympics.controllers;

import com.google.gson.Gson;
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
@SessionAttributes({"rankResult","eventName"})
public class ResultsFromRankController {
     ResultsFromRankPrepared prepared = new ResultsFromRankPrepared();


    @RequestMapping(value="/ResultsFromRank", method = RequestMethod.GET)
    public ModelAndView addPatient(@RequestParam(name = "eventName", required = false) String eventName,Model model) throws SQLException {
        ResultsFormObject formObject = new ResultsFormObject();
        if (eventName==null){
            model.addAttribute("eventName", "eventName");
        }else{
            model.addAttribute("eventName", eventName);

        }
        model.addAttribute("form",formObject);
        return new ModelAndView("/ResultsFromRank",(Map<String,?>) model.asMap());
    }

    @RequestMapping(value = "/ResultsFromRank", method = RequestMethod.POST)
    public ModelAndView addPersonFromForm
            (@Valid ResultsFormObject form, BindingResult bindingResult, Model attrs) throws SQLException {

        if (bindingResult.hasErrors()) {
            System.out.println("Binding Error.  There were " + bindingResult.getErrorCount() + " errors.");
            System.out.println(bindingResult.getAllErrors().toString());
            attrs.addAttribute("form", form);
            return new ModelAndView("addPatient", attrs.asMap());
        }

        System.out.println("Form Received");

        attrs.addAttribute("rankResult",prepared.getResult(form.getEventName(), form.getRank()));
        return new ModelAndView("redirect:/ResultsFromRank", attrs.asMap());


    }



}
