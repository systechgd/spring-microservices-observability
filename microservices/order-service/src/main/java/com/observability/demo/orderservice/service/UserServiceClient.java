package com.observability.demo.orderservice.service;

import com.observability.demo.orderservice.model.User;
import io.micrometer.observation.annotation.Observed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
@Slf4j
@RequiredArgsConstructor
@Observed(name = "user.service.client")
public class UserServiceClient {

    private final WebClient userServiceWebClient;

    public User getUserById(Long userId) {
        log.info("Calling user-service to fetch user with id: {}", userId);
        try {
            return userServiceWebClient
                .get()
                .uri("/api/users/{id}", userId)
                .retrieve()
                .bodyToMono(User.class)
                .block();
        } catch (Exception e) {
            log.error("Error calling user-service for userId: {}", userId, e);
            return null;
        }
    }

    public Mono<User> getUserByIdAsync(Long userId) {
        log.info("Calling user-service asynchronously to fetch user with id: {}", userId);
        return userServiceWebClient
            .get()
            .uri("/api/users/{id}", userId)
            .retrieve()
            .bodyToMono(User.class)
            .doOnError(e -> log.error("Error calling user-service for userId: {}", userId, e));
    }
}
