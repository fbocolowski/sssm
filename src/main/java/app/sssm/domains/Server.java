package app.sssm.domains;

import org.springframework.data.annotation.Id;

import java.util.Date;
import java.util.concurrent.TimeUnit;

public class Server {

    @Id
    private String id;

    private Date dateCreated = new Date();

    private String groupId;

    private String token;

    private Date firstReport;

    private Date lastReport;

    private String ip;

    private String hostname;

    private String distro;

    private Float uptime;

    private Integer ramUsage;

    private Integer diskUsage;

    public Server() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getFirstReport() {
        return firstReport;
    }

    public void setFirstReport(Date firstReport) {
        this.firstReport = firstReport;
    }

    public Date getLastReport() {
        return lastReport;
    }

    public void setLastReport(Date lastReport) {
        this.lastReport = lastReport;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getHostname() {
        return hostname;
    }

    public void setHostname(String hostname) {
        this.hostname = hostname;
    }

    public String getDistro() {
        return distro;
    }

    public void setDistro(String distro) {
        this.distro = distro;
    }

    public Float getUptime() {
        return uptime;
    }

    public void setUptime(Float uptime) {
        this.uptime = uptime;
    }

    public Integer getRamUsage() {
        return ramUsage;
    }

    public void setRamUsage(Integer ramUsage) {
        this.ramUsage = ramUsage;
    }

    public Integer getDiskUsage() {
        return diskUsage;
    }

    public void setDiskUsage(Integer diskUsage) {
        this.diskUsage = diskUsage;
    }

    public String getLogoName() {
        if (this.getDistro() != null) {
            if (this.getDistro().contains("Fedora")) return "fedora";
            if (this.getDistro().contains("Debian")) return "debian";
            if (this.getDistro().contains("Ubuntu")) return "ubuntu";
            if (this.getDistro().contains("Raspbian")) return "raspbian";
            if (this.getDistro().contains("CentOS")) return "centos";
            if (this.getDistro().contains("Manjaro")) return "manjaro";
            if (this.getDistro().contains("Mint")) return "mint";
            if (this.getDistro().contains("Antergos")) return "antergos";
            if (this.getDistro().contains("Arch")) return "arch";
        }

        return null;
    }

    public Integer getLastReportMinutes() {
        if (this.getLastReport() != null) {
            Long minutes = TimeUnit.MINUTES.convert((new Date().getTime() - this.getLastReport().getTime()), TimeUnit.MILLISECONDS);
            return minutes.intValue();
        }

        return null;
    }

    public String getFormattedUptime() {
        if (this.getUptime() != null) {
            long seconds = this.getUptime().longValue();
            long numberOfDays;
            long numberOfHours;
            long numberOfMinutes;
            long numberOfSeconds;

            numberOfDays = seconds / 86400;
            numberOfHours = (seconds % 86400) / 3600;
            numberOfMinutes = ((seconds % 86400) % 3600) / 60;
//            numberOfSeconds = ((seconds % 86400) % 3600) % 60;

            return String.format("%dd %dh %dm", numberOfDays, numberOfHours, numberOfMinutes);
        }

        return null;
    }
}
