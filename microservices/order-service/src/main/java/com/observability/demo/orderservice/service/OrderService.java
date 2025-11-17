package com.observability.demo.orderservice.service;

import com.observability.demo.orderservice.model.Order;
import com.observability.demo.orderservice.model.User;
import com.observability.demo.orderservice.repository.OrderRepository;
import io.micrometer.observation.annotation.Observed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
@Observed(name = "order.service")
public class OrderService {

    private final OrderRepository orderRepository;
    private final UserServiceClient userServiceClient;

    @Transactional(readOnly = true)
    public List<Order> getAllOrders() {
        log.info("Fetching all orders");
        return orderRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrderById(Long id) {
        log.info("Fetching order by id: {}", id);
        return orderRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByUserId(Long userId) {
        log.info("Fetching orders for user id: {}", userId);
        // This demonstrates distributed tracing - calling user-service
        User user = userServiceClient.getUserById(userId);
        if (user == null) {
            log.warn("User not found with id: {}", userId);
            return List.of();
        }
        log.info("Found user: {} - fetching their orders", user.getUsername());
        return orderRepository.findByUserId(userId);
    }

    @Transactional
    public Order createOrder(Order order) {
        log.info("Creating new order for user id: {}", order.getUserId());

        // Verify user exists by calling user-service (demonstrates distributed tracing)
        User user = userServiceClient.getUserById(order.getUserId());
        if (user == null) {
            log.error("Cannot create order - user not found with id: {}", order.getUserId());
            throw new IllegalArgumentException("User not found with id: " + order.getUserId());
        }

        if (!user.isActive()) {
            log.error("Cannot create order - user is not active: {}", user.getUsername());
            throw new IllegalArgumentException("User is not active: " + user.getUsername());
        }

        log.info("Creating order for active user: {}", user.getUsername());
        Order savedOrder = orderRepository.save(order);
        log.info("Order created successfully with id: {}", savedOrder.getId());
        return savedOrder;
    }

    @Transactional
    public Optional<Order> updateOrderStatus(Long id, Order.OrderStatus status) {
        log.info("Updating order {} status to {}", id, status);
        return orderRepository.findById(id)
            .map(order -> {
                order.setStatus(status);
                return orderRepository.save(order);
            });
    }

    @Transactional
    public boolean deleteOrder(Long id) {
        log.info("Deleting order with id: {}", id);
        return orderRepository.findById(id)
            .map(order -> {
                orderRepository.delete(order);
                return true;
            })
            .orElse(false);
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByStatus(Order.OrderStatus status) {
        log.info("Fetching orders with status: {}", status);
        return orderRepository.findByStatus(status);
    }
}
