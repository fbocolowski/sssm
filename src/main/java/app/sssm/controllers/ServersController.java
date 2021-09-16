package app.sssm.controllers;

import app.sssm.domains.Group;
import app.sssm.domains.Report;
import app.sssm.domains.Server;
import app.sssm.domains.User;
import app.sssm.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class ServersController {

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

    @GetMapping("/groups/{id}/servers")
    public String servers(Model model, Principal principal, @PathVariable String id) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        Group group = groupService.get(user.getId(), id);
        model.addAttribute("group", group);
        model.addAttribute("isLastGroup", groupService.countAll(user.getId()) == 1);

        List<Server> servers = serverService.getAll(group.getId());
        model.addAttribute("servers", servers);

        return "servers/index";
    }

    @GetMapping("/groups/{groupId}/servers/{id}")
    public String showServer(Model model, Principal principal, @PathVariable String groupId, @PathVariable String id) {
        User user = userService.getUser(principal);
        controllerHelperService.generateModel(model, user);

        Group group = groupService.get(user.getId(), groupId);
        model.addAttribute("group", group);

        Server server = serverService.get(id, group.getId());
        model.addAttribute("server", server);

        List<Report> reports = reportService.getAll(server.getId());
        model.addAttribute("reports", reports);

        return "servers/show";
    }

    @PostMapping("/groups/{groupId}/servers")
    public String createServer(Principal principal, @PathVariable String groupId) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        Server server = serverService.create(group);
        if (server != null) {
            return "redirect:/groups/" + group.getId() + "/servers/" + server.getId();
        }

        return "redirect:/groups";
    }

    @GetMapping("/groups/{groupId}/servers/{id}/delete")
    public String deleteServer(Principal principal, @PathVariable String groupId, @PathVariable String id) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        if (group != null) {
            Server server = serverService.get(id, group.getId());
            if (server != null) {
                serverService.delete(server);
            }
        }

        return "redirect:/groups";
    }
}
