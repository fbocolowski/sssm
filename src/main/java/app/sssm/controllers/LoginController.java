package app.sssm.controllers;

import app.sssm.domains.User;
import app.sssm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class LoginController {

    @Autowired
    UserService userService;

    @GetMapping("/login")
    public String show(Model model, Principal principal) {
        User user = userService.getUser(principal);
        if (user != null) {
            return "redirect:/groups";
        }

        return "login/show";
    }

}
