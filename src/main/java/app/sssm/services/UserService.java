package app.sssm.services;

import app.sssm.domains.Role;
import app.sssm.domains.User;
import app.sssm.repositories.RoleRepository;
import app.sssm.repositories.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    SecurityService securityService;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    GroupService groupService;

    private Logger logger = LoggerFactory.getLogger(UserService.class);

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = getUser(email);
        if (user != null) {
            List<GrantedAuthority> authorities = getUserAuthority(user.getRoles());
            return buildUserForAuthentication(user, authorities);
        } else {
            throw new UsernameNotFoundException("username not found");
        }
    }

    public User getUser(String email) {
        return userRepository.findByEmail(cleanEmailString(email));
    }

    public User getUser(Principal principal) {
        if (principal != null && principal.getName() != null) {
            return getUser(principal.getName());
        }

        return null;
    }

    private String cleanEmailString(String email) {
        return email.trim().toLowerCase();
    }

    private List<GrantedAuthority> getUserAuthority(Set<Role> userRoles) {
        Set<GrantedAuthority> roles = new HashSet<>();
        userRoles.forEach((role) -> {
            roles.add(new SimpleGrantedAuthority(role.getRole()));
        });

        List<GrantedAuthority> grantedAuthorities = new ArrayList<>(roles);
        return grantedAuthorities;
    }

    private UserDetails buildUserForAuthentication(User user, List<GrantedAuthority> authorities) {
        return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(), authorities);
    }

    public List<String> validateEmail(String email) {
        List<String> errors = new ArrayList<>();

        email = cleanEmailString(email);

        if (email.isEmpty()) {
            errors.add("E-mail can't be blank");
        } else if (!validateEmailFormat(email)) {
            errors.add("E-mail is not valid");
        } else if (userRepository.countByEmail(email) > 0) {
            errors.add("E-mail alredy used");
        }

        return errors;
    }

    public Boolean validateEmailFormat(String email) {
        Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(email);
        return matcher.find();
    }

    public List<String> validatePassword(String password) {
        List<String> errors = new ArrayList<>();

        if (password.isEmpty()) {
            errors.add("Password can't be blank");
        } else if (password.length() <= 4) {
            errors.add("Password too small");
        }

        return errors;
    }

    public List<String> validate(User user) {
        List<String> errors = new ArrayList<>();

        // Validate email
        errors.addAll(validateEmail(user.getEmail()));

        // Validate password
        errors.addAll(validatePassword(user.getPassword()));

        return errors;
    }

    public void register(User user) {
        user.setEmail(cleanEmailString(user.getEmail()));
        user.setPassword(user.getPassword());
        String rawPassword = user.getPassword();
        if (rawPassword != null) {
            user.setPassword(bCryptPasswordEncoder.encode(rawPassword));
        }
        Set<Role> roles = new HashSet<>();
        roles.add(roleRepository.findByRole("USER"));
        user.setRoles(roles);
        userRepository.save(user);

        securityService.doLogin(user.getEmail(), rawPassword);

        groupService.create(user, "My servers");

    }

    public void update(User user, User updatedUser) {
        Boolean changed = false;

        if (!user.getEmail().equals(updatedUser.getEmail())) {
            if (validateEmail(updatedUser.getEmail()).isEmpty()) {
                changed = true;
                user.setEmail(cleanEmailString(updatedUser.getEmail()));
            }
        }

        if (changed) {
            userRepository.save(user);
        }
    }

    public void changePassword(User user, String newPassword, String confirmPassword) {
        Boolean changed = false;

        logger.info("changePassword => newPassword " + newPassword);
        logger.info("changePassword => confirmPassword " + confirmPassword);

        if (newPassword.equals(confirmPassword)) {
            logger.info("New password confirmed!");
            if (validatePassword(newPassword).isEmpty()) {
                logger.info("Password valid!");
                changed = true;
                user.setPassword(bCryptPasswordEncoder.encode(newPassword));
            }
        }

        if (changed) {
            logger.info("Password changed!");
            userRepository.save(user);
        }
    }
}
