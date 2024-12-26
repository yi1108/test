package com.fairylands.test01.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
public class AppController {


    @GetMapping("/hello")
    public String hello(HttpServletRequest request) {
        String serverIp = getServerIp();
        int serverPort = request.getLocalPort();
        return "Server IP: " + serverIp + ", Server Port: " + serverPort;
    }

    private String getServerIp() {
        try {
            return InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            return "Unknown Host";
        }
    }

}
