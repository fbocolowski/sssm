package app.sssm.controllers;

import app.sssm.domains.User;
import app.sssm.services.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class RegistrationController {

    @Autowired
    UserService userService;

    private Logger logger = LoggerFactory.getLogger(RegistrationController.class);

    @GetMapping("/registration")
    public String show(Model model, Principal principal) {
        User user = userService.getUser(principal);
        if (user != null) {
            return "redirect:/groups";
        }

        User userModel = new User();
        model.addAttribute("userModel", userModel);
        return "registration/show";
    }

    @PostMapping("/registration")
    public String create(Model model, @ModelAttribute User userModel, Principal principal) {
        User user = userService.getUser(principal);
        if (user != null) {
            return "redirect:/groups";
        }

        List<String> errors = userService.validate(userModel);
        if (errors.isEmpty()) {
            userService.register(userModel);
            return "redirect:/groups";
        } else {
            model.addAttribute("userModel", userModel);
            model.addAttribute("errors", errors);
        }

        return "registration/show";
    }

}
