package app.sssm.domains;

import org.springframework.data.annotation.Id;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Group {

    @Id
    private String id;

    private Date dateCreated = new Date();

    private String name;

    private String ownerId;

    private Set<String> userIdList = new HashSet<>();

    public Group() {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public Set<String> getUserIdList() {
        return userIdList;
    }

    public void setUserIdList(Set<String> userIdList) {
        this.userIdList = userIdList;
    }

}
