package app.sssm.repositories;

import app.sssm.domains.Server;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ServerRepository extends MongoRepository<Server, String> {

    Server findByIdAndGroupId(String id, String userId);

    Server findByToken(String token);

    List<Server> findAllByGroupId(String userId);

}
