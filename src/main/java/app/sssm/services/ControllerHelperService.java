package app.sssm.services;

import app.sssm.domains.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class ControllerHelperService {

    @Value("${server.url}")
    String url;

    public void generateModel(Model model, User user) {
        model.addAttribute("user", user);
        model.addAttribute("url", url);
    }

}
