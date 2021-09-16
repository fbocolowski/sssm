package app.sssm.controllers;

import app.sssm.domains.Group;
import app.sssm.domains.Server;
import app.sssm.domains.User;
import app.sssm.services.ChartService;
import app.sssm.services.GroupService;
import app.sssm.services.ServerService;
import app.sssm.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
public class ChartsController {

    @Autowired
    UserService userService;

    @Autowired
    ServerService serverService;

    @Autowired
    ChartService chartService;

    @Autowired
    GroupService groupService;

    @GetMapping("/groups/{groupId}/servers/{id}/charts/ram")
    public List<Map> ramChart(Principal principal, @PathVariable String groupId, @PathVariable String id) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        Server server = serverService.get(id, group.getId());

        return chartService.ramChart(server);
    }

    @GetMapping("/groups/{groupId}/servers/{id}/charts/disk")
    public List<Map> diskChart(Principal principal, @PathVariable String groupId, @PathVariable String id) {
        User user = userService.getUser(principal);
        Group group = groupService.get(user.getId(), groupId);
        Server server = serverService.get(id, group.getId());

        return chartService.diskChart(server);
    }
}
