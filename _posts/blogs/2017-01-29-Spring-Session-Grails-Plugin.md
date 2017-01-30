---
layout: post
title: Spring-Session Grails Plugin (Part 1)
status: unpublish
type: post
published: true
comments: true
category: blogs
tags: [GRAILS, JAVA, SPRING-SESSION]
date: 2017-01-29T00:00:00-04:00
comments: true
share: true
excerpt: Part 1 of "Spring Session Grails Plugin" series. This blog series will cover Introduction, Installation and Redis Data store.
---
<a href="https://github.com/jeetmp3/spring-session" target="_blank"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/e7bbb0521b397edbd5fe43e7f760759336b5e05f/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677265656e5f3030373230302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png"></a>

This tutorial will guide you how to configure and use <a href="https://grails.org/plugin/spring-session" target="_blank">spring-session grails plugin</a> 
    in grails 2x application. You can use JSON or JDK serializer to serialize/deserialize your session to/from store.

This blog will also cover various data store currently supported by this plugin.

**Note:** Actual spring-session project support various data store. Very soon those data store will be supported by this plugin. 
    If you wish to contribute in adding data store support just <a href="https://github.com/jeetmp3/spring-session" target="_blank">fork me on GitHub</a>.
{: .notice}

This blog is divided into below sections

1. Introduction
2. Installation
3. Redis Datastore

#### 1. Introduction
This grails plugin helps you to easily setup <a href="http://projects.spring.io/spring-session/" target="_blank">spring-session</a> project in your grails 
    application. 

##### What is Spring-session? 
Spring Session is project of Spring community which provides an API and implementations for managing a user’s session information. It allows
    you to store user's session in different supported data store such as __Redis__, __MongoDB__, __JDBC__, __Hazelcast__, __Gemfire__ etc. Changing from one data store to another
    is very easy. 
    
How it is better than traditional way of storing user's session? Well in spring-session you don't need to add any kind of jar inside the Servlet Container
    (tomcat, jetty etc), no container specific dependency. Session management related API (jar) will be inside your application itself. Which helps in
    migrating from one container to another or switch to another vendor (i.e. Tomcat to Jetty). One container can contain more than one applications
    which might be using different types of data store to store user's session.

Some other features of spring-session:

* Clustered Sessions - It trivial to support clustered sessions without being tied to an application container specific solution.
* Multiple Browser Sessions - Spring Session supports managing multiple users' sessions in a single browser instance (i.e. multiple authenticated accounts similar to Google).
* RESTful APIs - Spring Session allows providing session ids in headers to work with RESTful APIs.
* WebSocket Support - provides the ability to keep the HttpSession alive when receiving WebSocket messages.
    
#### 2. Install
Configuration the plugin is very easy. If you're using grails 2x then add following code in your `BuildConfig.groovy` inside the `plugins` block

```groovy
plugins {
    ...
    runtime "org.grails.plugins:spring-session:1.2.2-RC1"
}
```

**Note:** *By Default plugin will use Redis as it's default data store. Currently it supports Redis, Mongo and JDBC store to persist session. 
    Let's check different store.*
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
Now plugin will use Redis to persist the sessions. It'll use JDK Serialization to serialize session data, 
    __*so make sure every object you put in session must be marked Serializable*__. To configure redis connection below properties will be use

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