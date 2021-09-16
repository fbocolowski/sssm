package app.sssm;

import app.sssm.domains.Role;
import app.sssm.repositories.RoleRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class SSSMApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(SSSMApplication.class, args);
//        Environment environment = context.getBean(Environment.class);

        RoleRepository roleRepository = context.getBean(RoleRepository.class);
        if (roleRepository.findByRole("USER") == null) {
            roleRepository.save(new Role("USER"));
        }
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

}
