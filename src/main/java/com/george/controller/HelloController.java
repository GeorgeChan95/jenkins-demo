package com.george.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p></p>
 *
 * @author George
 * @date 2023.05.22 19:34
 */
@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "hello jenkins";
    }
}
