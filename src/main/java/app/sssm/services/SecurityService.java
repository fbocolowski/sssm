package app.sssm.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class SecurityService {

    @Autowired
    @Lazy
    AuthenticationManager authManager;

    private Logger logger = LoggerFactory.getLogger(SecurityService.class);

    public void doLogin(String email, String password) {

        if (email == null) {
            email = "";
        }

        if (password == null) {
            password = "";
        }

        email = email.trim();

        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(email, password);

        Authentication authentication = authManager.authenticate(authRequest);

        if (authentication.isAuthenticated()) {
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
    }

}