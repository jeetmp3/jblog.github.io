---
layout: post
title: Spring-Session Grails Plugin
status: unpublish
type: post
published: true
comments: true
category: blogs
tags: [GRAILS, JAVA, SPRING-SESSION]
date: 2017-01-29T00:00:00-04:00
comments: true
share: true
excerpt: This tutorial will guide you how to configure and use spring-session grails plugin in grails 2x application.
---

This tutorial will guide you how to configure and use <a href="https://grails.org/plugin/spring-session" target="_blank">spring-session grails plugin</a> in grails 2x application. To read more about spring-session <a href="http://projects.spring.io/spring-session/" target="_blank">click here</a>.

Below points will be cover in this tutorial

1. Introduction
2. Installation
3. Using different Store
4. Change Serialization machanism

#### 2. Install
Configuration the plugin is very easy. If you're using grails 2x then add following code in your `BuildConfig.groovy` inside the `plugins` block

```groovy
plugins {
    ...
    runtime "org.grails.plugins:spring-session:1.2.2-RC1"
}
```

**Note:** *By Default plugin will use Redis as it's default data store. Currently it supports Redis, Mongo and JDBC store to persist session. Let's check different store.*
{: .notice}

#### 3. Using Different Store
Currently, this plugin supports 3 data store.

1. Redis
2. Mongo
3. JDBC

Let's explore these data store one by one.

##### 1. Redis
To change data store you need to set below property in your `Config.groovy` file

```groovy
springsession.sessionStore=SessionStore.REDIS
```
Now plugin will use Redis to persist the sessions. It'll use JDK Serialization to serialize session data, __*so make sure every object you put in session must be marked Serializable*__. To configure redis connection below properties will be use

```java
package samples.lombok;

import lombok.NonNull;

/**
 * @author Jitendra Singh.
 */
@lombok.AllArgsConstructor
public class AllArgsConstructor {

    private final String name;
    @NonNull
    private String city;
    private int age;
}
```
To verify plugin is working, just create a dummy controller and run the app. Let's say you've created controller called HomeController.

```java
package samples.lombok;

import lombok.NonNull;

/**
 * @author Jitendra Singh.
 */
@lombok.AllArgsConstructor
public class AllArgsConstructor {

    private final String name;
    @NonNull
    private String city;
    private int age;
}
```
Now run below command on terminal.

```bash
curl -c - localhost:8080/g2ss/home/index
```

You'll see the session cookie like

`#HttpOnly_localhost    FALSE    /g2ss/    FALSE    0    SESSION    9c3796b4-90d1-4f51-b340-4dc857f6cdd2`