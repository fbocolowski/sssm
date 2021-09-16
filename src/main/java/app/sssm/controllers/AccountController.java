package app.sssm.controllers;

import app.sssm.domains.User;
import app.sssm.services.ControllerHelperService;
import app.sssm.services.ReportService;
import app.sssm.services.ServerService;
import app.sssm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
public class AccountController {

    @Autowired
    UserService userService;

    @Autowired
    ServerService serverService;

    @Autowired
    ReportService reportService;

    @Autowired
    ControllerHelperService controllerHelperService;

    @GetMapping("/account")
    public String index(Model model, Principal principal) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        return "account/show";
    }

    @PostMapping("/account")
    public String update(Model model, Principal principal, @ModelAttribute User userModel) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        userService.update(user, userModel);

        return "redirect:/login";
    }

    @PostMapping("/changePassword")
    public String update(Model model, Principal principal,
                         @RequestParam String newPassword,
                         @RequestParam String confirmPassword) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        userService.changePassword(user, newPassword, confirmPassword);

        return "redirect:/account";
    }
}
