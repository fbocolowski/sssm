package app.sssm.domains;

import org.springframework.data.annotation.Id;

import java.util.Date;

public class Report {

    @Id
    private String id;

    private Date dateCreated = new Date();

    private String serverId;

    private Float uptime;

    private String hostname;

    private String distro;

    private String ip;

    private Float ramTotal;

    private Float ramUsed;

    private Float diskTotal;

    private Float diskUsed;

    public Report() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getServerId() {
        return serverId;
    }

    public void setServerId(String serverId) {
        this.serverId = serverId;
    }

    public Float getUptime() {
        return uptime;
    }

    public void setUptime(Float uptime) {
        this.uptime = uptime;
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

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Float getRamTotal() {
        return ramTotal;
    }

    public void setRamTotal(Float ramTotal) {
        this.ramTotal = ramTotal;
    }

    public Float getRamUsed() {
        return ramUsed;
    }

    public void setRamUsed(Float ramUsed) {
        this.ramUsed = ramUsed;
    }

    public Float getDiskTotal() {
        return diskTotal;
    }

    public void setDiskTotal(Float diskTotal) {
        this.diskTotal = diskTotal;
    }

    public Float getDiskUsed() {
        return diskUsed;
    }

    public void setDiskUsed(Float diskUsed) {
        this.diskUsed = diskUsed;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
}
