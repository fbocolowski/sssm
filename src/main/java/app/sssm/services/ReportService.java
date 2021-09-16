package app.sssm.services;

import app.sssm.domains.Report;
import app.sssm.domains.Server;
import app.sssm.repositories.ReportRepository;
import app.sssm.repositories.ServerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class ReportService {

    @Autowired
    ReportRepository reportRepository;

    @Autowired
    ServerRepository serverRepository;

    public void save(Report report, Server server, HttpServletRequest request) {
        report.setServerId(server.getId());
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || "".equals(ip)) {
            ip = request.getRemoteAddr();
        }
        report.setIp(ip);
        reportRepository.save(report);

        server.setLastReport(new Date());
        server.setUptime(report.getUptime());
        server.setHostname(report.getHostname());
        server.setDistro(report.getDistro());
        server.setIp(report.getIp());
        Integer ramUsed = Float.valueOf(((report.getRamUsed() * 100) / report.getRamTotal())).intValue();
        server.setRamUsage(ramUsed);
        Integer diskUsed = Float.valueOf(((report.getDiskUsed() * 100) / report.getDiskTotal())).intValue();
        server.setDiskUsage(diskUsed);
        serverRepository.save(server);
    }

    public List<Report> getAll(String serverId) {
        return reportRepository.findAllByServerId(serverId);
    }

    public List<Report> getLast24Hours(String serverId) {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        return reportRepository.findAllByServerIdAndDateCreatedGreaterThanEqual(serverId, calendar.getTime());
    }

}
