package app.sssm.services;

import app.sssm.domains.Report;
import app.sssm.domains.Server;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChartService {

    @Autowired
    ReportService reportService;

    public List<Map> ramChart(Server server) {
        Map usedData = new HashMap<>();
        Map totalData = new HashMap<>();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        List<Report> last24HoursReports = reportService.getLast24Hours(server.getId());
        for (Report report : last24HoursReports) {
            String dateCreatedString = sdf.format(report.getDateCreated());
            usedData.put(dateCreatedString, report.getRamUsed());
            totalData.put(dateCreatedString, report.getRamTotal());
        }

        Map used = new HashMap<>();
        used.put("name", "RAM used");
        used.put("data", usedData);

        Map total = new HashMap<>();
        total.put("name", "RAM total");
        total.put("data", totalData);


        List<Map> result = new ArrayList<>();
        result.add(used);
        result.add(total);

        return result;
    }

    public List<Map> diskChart(Server server) {
        Map usedData = new HashMap<>();
        Map totalData = new HashMap<>();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        List<Report> last24HoursReports = reportService.getLast24Hours(server.getId());
        for (Report report : last24HoursReports) {
            String dateCreatedString = sdf.format(report.getDateCreated());
            usedData.put(dateCreatedString, report.getDiskUsed());
            totalData.put(dateCreatedString, report.getDiskTotal());
        }

        Map used = new HashMap<>();
        used.put("name", "Disk used");
        used.put("data", usedData);

        Map total = new HashMap<>();
        total.put("name", "Disk total");
        total.put("data", totalData);


        List<Map> result = new ArrayList<>();
        result.add(used);
        result.add(total);

        return result;
    }


}
