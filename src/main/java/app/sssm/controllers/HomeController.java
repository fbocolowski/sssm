package app.sssm.controllers;

import app.sssm.domains.User;
import app.sssm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class HomeController {

    @Autowired
    UserService userService;

    @GetMapping("/")
    public String index(Principal principal) {
        User user = userService.getUser(principal);
        if (user != null) {
            return "redirect:/groups";
        }

        return "home/index";
    }

}
