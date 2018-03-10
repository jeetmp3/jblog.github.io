---
layout: post
title: Optional to stream in java 9
status: published
type: post
published: true
comments: true
category: java
tags: [JAVA, JAVA9, COLLECTIONS, OPTIONAL]
date: 2018-03-08T00:00:00-04:00
comments: true
share: true
excerpt: How to do optional as stream in java9
logo: java/java-9.png
---

Last year Java 9 launched with tons of new features. In this blog post I'm going to explain streams in `Optional` (introduced in Java8).
 Now you can get streams form `Optional` which I think is good feature.
 
Below example shows how get stream from Optional in Java 8 & Java 9.

```java
package com.jbisht.blogs.java9.usingoptional;

import java.util.Optional;
import java.util.stream.Stream;

public class OptionalDemo {

    public static void main(String[] args) {
        // Java 9 style
        getPerson().stream()
                .map(Person::getName)
                .map("Java 9 "::concat)
                .forEach(System.out::println);

        getEmptyPerson().stream()
                .map(Person::getName)
                .map("Java 9 "::concat)
                .forEach(System.out::println);

        // Java 8 Style
        getPerson()
                .map(Stream::of).orElseGet(Stream::empty)
                .map(Person::getName)
                .map("Java 8 - "::concat)
                .forEach(System.out::println);
    }

    private static Optional<Person> getEmptyPerson() {
        return Optional.empty();
    }

    private static Optional<Person> getPerson() {
        return Optional.of(new Person("JITENDRA SINGH"));
    }

    static class Person {

        private String name;

        public Person(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}

```

Happy Coding 😀😀😀 !!! If you have any feedback please comment down below.