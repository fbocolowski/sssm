package app.sssm.repositories;

import app.sssm.domains.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepository extends MongoRepository<User, String> {

    User findByEmail(String email);

    Integer countByEmail(String email);

}
