package app.sssm.controllers;

import app.sssm.domains.Group;
import app.sssm.domains.User;
import app.sssm.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
public class GroupsController {

    @Autowired
    UserService userService;

    @Autowired
    ServerService serverService;

    @Autowired
    ReportService reportService;

    @Autowired
    ControllerHelperService controllerHelperService;

    @Autowired
    GroupService groupService;

    @Autowired
    ChartService chartService;

    @GetMapping("/groups")
    public String index(Model model, Principal principal) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        List<Group> groups = groupService.getAll(user.getId());
        model.addAttribute("groups", groups);

        return "groups/index";
    }

    @GetMapping("/groups/{id}")
    public String edit(Model model, Principal principal, @PathVariable String id) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        Group group = groupService.get(user.getId(), id);
        if (group != null) {
            model.addAttribute("group", group);
            model.addAttribute("isLastGroup", groupService.countAll(user.getId()) == 1);
            model.addAttribute("users", groupService.getUsers(group));

            return "groups/show";
        } else {
            return "redirect:/groups";
        }
    }

    @PostMapping("/groups")
    public String create(Principal principal) {
        User user = userService.getUser(principal);
        groupService.create(user, "New group");

        return "redirect:/groups";
    }

    @GetMapping("/groups/{id}/delete")
    public String delete(Principal principal, @PathVariable String id) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), id);
        if (group != null && groupService.countAll(user.getId()) > 1) {
            groupService.delete(group);
        }

        return "redirect:/groups";
    }

    @PostMapping("/groups/{id}")
    public String update(Principal principal, @PathVariable String id, @ModelAttribute Group groupModel) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), id);
        if (group != null) {
            groupService.update(group, groupModel);
        }

        return "redirect:/groups";
    }

    @PostMapping("/groups/{groupId}/users")
    public String addUser(Principal principal, @PathVariable String groupId, @RequestParam String email) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        groupService.addUser(group, email);

        return "redirect:/groups/" + group.getId();
    }

    @GetMapping("/groups/{groupId}/users/{id}/delete")
    public String removeUser(Principal principal, @PathVariable String groupId, @PathVariable String id) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        groupService.removeUser(group, id);

        return "redirect:/groups/" + group.getId();
    }

}
