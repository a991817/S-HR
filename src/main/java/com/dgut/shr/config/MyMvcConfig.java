package com.dgut.shr.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class MyMvcConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("page/main.html").setViewName("page/main");
        registry.addViewController("/index.html").setViewName("index");
        registry.addViewController("/").setViewName("index");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        InterceptorRegistration interceptorRegistration = registry.addInterceptor(new LoginInterceptor());
        interceptorRegistration.excludePathPatterns("/login","/doLogin");
        interceptorRegistration.excludePathPatterns(
                "/css/**",
                "/js/**",
                "/layui/**",
                "/json/**",
                "/images/**",
                "/favicon.ico");
        interceptorRegistration.addPathPatterns("/**");
    }
}
