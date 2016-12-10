package olympics.controllers;

import olympics.JdbcConnection.EventsResultPrepared;
import olympics.JdbcConnection.StagesPrepared;
import olympics.domain.formObjects.StringObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.sql.SQLException;
import java.util.Map;

/**
 * Created by c1519287 on 08/12/2016.
 */
@Controller
@SessionAttributes({"stageResults","eventName"})
public class StageEntriesController {

    @RequestMapping(value="/stageEntries", method = RequestMethod.GET)
    public ModelAndView addPatient(@RequestParam(name = "eventName", required = false) String eventName, Model model) throws SQLException {
        if (eventName==null){
            model.addAttribute("eventName", "eventName");
        }else{
            model.addAttribute("eventName", eventName);

        }
        model.addAttribute("form",new StringObject());
        return new ModelAndView("/stageEntries",(Map<String,?>) model.asMap());
    }

    @RequestMapping(value = "/stageEntries", method = RequestMethod.POST)
    public ModelAndView addPersonFromForm
            (@Valid StringObject form, BindingResult bindingResult, Model attrs) throws SQLException {

        if (bindingResult.hasErrors()) {
            System.out.println("Binding Error.  There were " + bindingResult.getErrorCount() + " errors.");
            System.out.println(bindingResult.getAllErrors().toString());
            attrs.addAttribute("form", form);
            return new ModelAndView("stageEntries", attrs.asMap());
        }

        System.out.println("Form Received");
        StagesPrepared prepared = new StagesPrepared();

        attrs.addAttribute("stageResults", prepared.getStages(form.getValue()));
        return new ModelAndView("redirect:/stageEntries", attrs.asMap());

    }

}
