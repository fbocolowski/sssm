package app.sssm.repositories;

import app.sssm.domains.Role;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface RoleRepository extends MongoRepository<Role, String> {

    Role findByRole(String role);

    List<Role> findAll();
}
