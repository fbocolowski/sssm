package app.sssm.repositories;

import app.sssm.domains.Report;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Date;
import java.util.List;

public interface ReportRepository extends MongoRepository<Report, String> {

    List<Report> findAllByServerId(String serverId);

    List<Report> findAllByServerIdAndDateCreatedGreaterThanEqual(String serverId, Date dateCreated);

}
