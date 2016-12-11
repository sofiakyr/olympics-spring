package olympics.controllers;

import com.google.gson.Gson;
import olympics.JdbcConnection.EventsFromSports;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by c1519287 on 11/12/2016.
 */
@Controller
public class eventsFromSportsAPI {

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
