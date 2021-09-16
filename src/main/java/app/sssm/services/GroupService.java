package app.sssm.services;

import app.sssm.domains.Group;
import app.sssm.domains.User;
import app.sssm.repositories.GroupRepository;
import app.sssm.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class GroupService {

    @Autowired
    GroupRepository groupRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserService userService;

    public Group create(User user, String name) {
        Group group = new Group();
        group.setName(name);
        group.setOwnerId(user.getId());
        group.getUserIdList().add(user.getId());
        groupRepository.save(group);

        return group;
    }

    public Group get(String userId, String groupId) {
        return groupRepository.findByUserIdListInAndId(userId, groupId);
    }

    public List<Group> getAll(String userId) {
        return groupRepository.findAllByUserIdListIn(userId);
    }

    public Integer countAll(String userId) {
        return groupRepository.countAllByUserIdListIn(userId);
    }

    public void delete(Group group) {
        groupRepository.delete(group);
        // TODO Delete servers and reports
    }

    public void update(Group group, Group updatedGroup) {
        Boolean changed = false;

        if (!group.getName().equals(updatedGroup.getName())) {
            changed = true;
            group.setName(updatedGroup.getName());
        }

        if (changed) {
            groupRepository.save(group);
        }
    }

    public List<User> getUsers(Group group) {
        List<User> users = new ArrayList<>();
        for (String userId : group.getUserIdList()) {
            Optional<User> userOptional = userRepository.findById(userId);
            if (userOptional.isPresent()) {
                users.add(userOptional.get());
            }
        }
        return users;
    }

    public User getOwner(Group group) {
        Optional<User> userOptional = userRepository.findById(group.getOwnerId());
        if (userOptional.isPresent()) {
            return userOptional.get();
        }
        return null;
    }

    public void addUser(Group group, String email) {
        User user = userService.getUser(email);
        if (user != null) {
            group.getUserIdList().add(user.getId());
            groupRepository.save(group);
        }
    }

    public void removeUser(Group group, String userId) {
        if (!userId.equals(group.getOwnerId())) {
            group.getUserIdList().remove(userId);
            groupRepository.save(group);
        }
    }

}
