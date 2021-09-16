package app.sssm.services;

import app.sssm.domains.Group;
import app.sssm.domains.Server;
import app.sssm.repositories.ServerRepository;
import app.sssm.domains.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ServerService {

    private Logger logger = LoggerFactory.getLogger(ServerService.class);

    @Autowired
    ServerRepository serverRepository;

    public Server create(Group group) {
        Server server = new Server();
        server.setToken(UUID.randomUUID().toString());
        server.setGroupId(group.getId());
        serverRepository.save(server);

        return server;
    }

    public List<Server> getAll(String groupId) {
        return serverRepository.findAllByGroupId(groupId);
    }

    public Server get(String serverId, String groupId) {
        return serverRepository.findByIdAndGroupId(serverId, groupId);
    }

    public void delete(Server server) {
        serverRepository.delete(server);
        // TODO Delete all reports
    }

    public Server getByToken(String token) {
        return serverRepository.findByToken(token);
    }

}
