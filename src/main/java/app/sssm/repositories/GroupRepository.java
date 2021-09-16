package app.sssm.repositories;

import app.sssm.domains.Group;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface GroupRepository extends MongoRepository<Group, String> {

    Group findByUserIdListInAndId(String id, String userId);

    List<Group> findAllByUserIdListIn(String userId);

    Integer countAllByUserIdListIn(String userId);

}
