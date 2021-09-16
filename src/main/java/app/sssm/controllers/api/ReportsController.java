package app.sssm.controllers.api;

import app.sssm.domains.Server;
import app.sssm.services.ReportService;
import app.sssm.services.ServerService;
import app.sssm.domains.Report;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
public class ReportsController {

    @Autowired
    ServerService serverService;

    @Autowired
    ReportService reportService;

    @PostMapping("/api/reports")
    public void create(@RequestBody Report report,
                       @RequestHeader("Server-Token") String serverToken,
                       HttpServletResponse response,
                       HttpServletRequest request) {
        Server server = serverService.getByToken(serverToken);
        if (server != null) {
            reportService.save(report, server, request);
        } else {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        }
    }

}
