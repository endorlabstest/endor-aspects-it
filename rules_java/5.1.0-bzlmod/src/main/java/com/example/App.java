package com.example;

import com.google.common.collect.ImmutableList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.apache.commons.io.IOUtils;
import org.joda.time.DateTime;
import com.google.gson.Gson;
import org.json.JSONObject;

import java.io.IOException;

public class App {
    private static final Logger logger = LoggerFactory.getLogger(App.class);

    public static void main(String[] args) {
        System.out.println("Hello from Bazel!");

        // 1. Guava
        ImmutableList<String> list = ImmutableList.of("a", "b", "c");
        System.out.println("Guava list: " + list);

        // 2. Commons Lang
        System.out.println("Commons Lang check: " + StringUtils.isEmpty(""));

        // 3. SLF4J
        logger.info("SLF4J Logger is working!");

        // 4. Jackson
        ObjectMapper mapper = new ObjectMapper();
        try {
            String json = mapper.writeValueAsString(new Person("John", 30));
            System.out.println("Jackson JSON: " + json);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 5. OkHttp
        OkHttpClient client = new OkHttpClient();
        System.out.println("OkHttp client created: " + client);

        // 6. Commons IO
        try {
            String content = IOUtils.toString(IOUtils.toInputStream("Commons IO Test", "UTF-8"), "UTF-8");
            System.out.println("Commons IO content: " + content);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 7. Joda-Time
        DateTime now = new DateTime();
        System.out.println("Joda Time now: " + now);

        // 8. Gson
        Gson gson = new Gson();
        String gsonJson = gson.toJson(new Person("Jane", 25));
        System.out.println("Gson JSON: " + gsonJson);

        // 9. Org.Json
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("name", "Alice");
        jsonObject.put("age", 28);
        System.out.println("Org.Json object: " + jsonObject.toString());
    }

    static class Person {
        public String name;
        public int age;

        public Person(String name, int age) {
            this.name = name;
            this.age = age;
        }
    }
}
