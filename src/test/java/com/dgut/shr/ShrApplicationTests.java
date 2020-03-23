package com.dgut.shr;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
class ShrApplicationTests {
    @Autowired
    RedisTemplate redisTemplate;
    @Test
    void contextLoads() {
    }

    @Test
    public void testRedis(){
        redisTemplate.opsForValue().append("key","你好");
    }

}
