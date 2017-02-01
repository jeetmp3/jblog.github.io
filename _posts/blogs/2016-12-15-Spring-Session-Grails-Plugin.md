---
layout: post
title: Spring-Session Grails Plugin (Part 1)
status: unpublish
type: post
published: true
comments: true
category: blogs
tags: [GRAILS, JAVA, SPRING-SESSION, JSON, JACKSON]
date: 2016-12-15T00:00:00-04:00
comments: true
share: true
excerpt: Part 1 of "Spring Session Grails Plugin" series. This blog series will cover Introduction, Installation and Redis Datastore.
---
<a href="https://github.com/jeetmp3/spring-session" target="_blank"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/e7bbb0521b397edbd5fe43e7f760759336b5e05f/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677265656e5f3030373230302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png"></a>

This tutorial will guide you how to configure and use <a href="https://grails.org/plugin/spring-session" target="_blank">__spring-session grails plugin__</a>
    in grails 2x application. This blog will also cover various datastore currently supported by this plugin along with
    serializers to serialize/deserialize your session to/from the store.

This blog is divided into 3 sections

1. Introduction
2. Installation
3. Redis Datastore

#### 1. Introduction
This __grails plugin__ helps you to easily setup <a href="http://projects.spring.io/spring-session/" target="_blank">__Spring Session__</a> project in your grails application.

##### What is Spring Session?
__Spring Session__ is project of Spring community which provides an API and implementations for managing a user’s session information. It allows you to store user's session in datastore such as __Redis__, __MongoDB__, __JDBC__, __Hazelcast__, __Gemfire__ etc. You can easily change from one datastore to another.

How it is better than traditional way of storing user's session? Well in Spring session you don't need to add any kind of jar inside the Servlet Container (tomcat, jetty etc), which means, no container specific dependency. Session management related API (jar) will be inside your application itself. So one container can contain more than one applications which might be using different types of datastore to store user's session. Which also helps in migrating from one container to another or switch to another vendor (i.e. Tomcat to Jetty).

Other features offered by spring-session:

* __Clustered Sessions__ - It trivial to support clustered sessions without being tied to an application container specific solution.
* __Multiple Browser Sessions__ - Spring Session supports managing multiple users' sessions in a single browser instance (i.e. multiple authenticated accounts similar to Google).
* __RESTful APIs__ - Spring Session allows providing session ids in headers to work with RESTful APIs.
* __WebSocket Support__ - provides the ability to keep the HttpSession alive when receiving WebSocket messages.

By using this plugin you can achieve above features in your grails application.

**Note:** Spring Session project supports various datastore, which are not configured in this plugin yet. Those datastores are under development. If you wish to contribute in adding datastore support just <a href="https://github.com/jeetmp3/spring-session" target="_blank">fork me on GitHub</a>.
{: .notice}

#### 2. Installation
Plugin configuration is very easy. If you're using grails 2x then add following code in your `BuildConfig.groovy` inside the `plugins` block

```groovy
plugins {
    ...
    runtime "org.grails.plugins:spring-session:1.2.2-RC1"
}
```

**Note:** *By Default plugin will use Redis as it's default datastore. Currently it supports Redis, Mongo and JDBC store to persist session.*
{: .notice}

Currently, this plugin supports 3 datastore.

1. Redis
2. Mongo
3. JDBC

This blog will cover __Redis__ datastore. Other datastores will be covered in next blog.

##### 1. Redis
Initially spring-session project supported only redis datastore. So the Redis is the default datasotre for this plugin.
 To change datastore you need to set below property in your `Config.groovy` file.

```groovy
springsession.sessionStore=SessionStore.REDIS
```

Make sure redis server is running on your system. To verify plugin is working, just create a dummy controller in your app.
 Let's say you've created controller called HomeController.

```groovy
package demo

class HomeController {

    def index() {
        render "Hello from home controller"
    }
}
```

Now run your grails application and once your app is up then run the below command on terminal.

```bash
curl -c - localhost:8080/g2ss/home/index

#Output
#HttpOnly_localhost    FALSE    /g2ss/    FALSE    0    SESSION    9c3796b4-90d1-4f51-b340-4dc857f6cdd2
```

You will notice the response with session cookie name `SESSION` with it's value `9c3796b4-90d1-4f51-b340-4dc857f6cdd2`.
    Cheers!!! Your plugin is configured successfully.

If you wish to override plugin's default configuration, well that is very easy. You need to change the property related to
 that functionality. e.g. Default cookie name is `SESSION`. To change cookie name you need to change following property in your `Config.groovy`.
```groovy
springsession.strategy.cookie.name="SPRING_SESSION"
```

Let's checkout some properties with their impact on plugin.

###### Common properties
```groovy
springsession.maxInactiveIntervalInSeconds=1800 // Session timeout. default is 1800 seconds
springsession.sessionStore=SessionStore.REDIS // Select session store. Default is REDIS
springsession.defaultSerializer=Serializer.JDK // Serialization mechanism, currently supports JDK & JSON Based. Default is JDK
springsession.strategy.defaultStrategy=SessionStrategy.COOKIE // session tracking mechanism. Default is COOKIE also suports HEADER
springsession.strategy.cookie.name="SESSION" // session cookie name. Default is SESSION
springsession.strategy.httpHeader.headerName="x-auth-token" // session header token name. Default is x-auth-token
springsession.allow.persist.mutable=false // check https://github.com/jeetmp3/spring-session/issues/5 for more detail. Default value is false.
```

###### Redis store specific properties
```groovy
springsession.redis.connectionFactory.hostName="localhost" // Redis server hostname. default is localhost
springsession.redis.connectionFactory.port=6397 // Redis server port. default is 6397
springsession.redis.connectionFactory.timeout=2000 // Redis server connection timeout. default is 2000
springsession.redis.connectionFactory.usePool=true // To use connection pool. default is true
springsession.redis.connectionFactory.dbIndex=0 // Database number. Default is 0
springsession.redis.connectionFactory.password=null // Redis server password. Default is null
springsession.redis.connectionFactory.convertPipelineAndTxResults=true // Specifies if pipelined results should be converted to the expected data type. Default is true

springsession.redis.poolConfig.maxTotal=8 // Pool config maximum active connections. Default is 8
springsession.redis.poolConfig.maxIdle=8 // Pool config maximum idle connections. Default is 8
springsession.redis.poolConfig.minIdle=0 // Pool config minimum active connections. Default is 0

springsession.redis.sentinel.master=null // Redis sentinal master node name. Default is null
springsession.redis.sentinel.nodes=[] // List of Map sentinal nodes. e.g. [ [host: 'localhost', port: 6379], [host: '', port: 0] ]. Default is blank
springsession.redis.sentinel.password=null // Redis sentinal password. Default is null
springsession.redis.sentinel.timeout=2000 // Redis sentinal timeout. Default is 2000
```

###### JSON serialization specific properties
```groovy
springsession.redis.jackson.modules = [] // List of Applicaiton Jackson modules. This plugin use Jackson library to Json serialization.
```

##### Json Serialization
By default this plugin use Java serialization. There is a big limitation with this type of serialization, __you need to mark every class @Serializable__.
    Now think of some library classes i.e. any class which comes with library and you don't have source code for that. What happens when you try
    to serialize that class?

__`java.io.NotSerializableException`__ Yes you're right!!!!

In real world applications, you'd like to use libs as much you can because you don't want to write classes/routines which are already written,
 why not reuse those.

Here comes the Json serialization. In Json serialization you don't need to put @Serializable on classes. To use Json Serialization in plugin you need to
  change below property

```groovy
springsession.defaultSerializer = Serializer.JSON
```

That's it!!!

Json serialization will work perfectly until your class has default constructor. But if any class doesn't have default constructor then you'll need
  to add mixin classes or serializer/deserializer for that class and a Jackson module class. This is the blog which will guide you to [Deserialize
  json with Java parameterized constructor]({{ site.baseurl }}{% link _posts/blogs/2016-09-12-Deserialize-json-with-Java-parameterized-constructor.md %}).

Let's take an example. I've my User class as mentioned below

```java
package demo;

import java.io.Serializable;

/**
 * @author Jitendra Singh.
 */
public class User {

    private String name;

    public User(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                '}';
    }
}
```

As you can see there is one parameterized constructor. And I want to put this class in session. So what I've to do now.

###### 1. Create Mixin for User

```java
package demo;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @author Jitendra Singh.
 */
public class UserMixin {
    private String name;

    @JsonCreator
    public UserMixin(@JsonProperty("name") String name) {

    }
}
```

###### 2. Create module class to register mixin

```java
package demo;

import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.Module;

/**
 * @author Jitendra Singh.
 */
public class SimpleModule extends Module {
    @Override
    public String getModuleName() {
        return "Simple";
    }

    @Override
    public Version version() {
        return Version.unknownVersion();
    }

    @Override
    public void setupModule(SetupContext setupContext) {
        setupContext.setMixInAnnotations(User.class, UserMixin.class);
    }
}
```

###### 3. Register my module class with spring-session plugin

```groovy
springsession.redis.jackson.modules = ['demo.SimpleModule']
```

That's it. You're done.

In [next post]({{ site.baseurl }}{% link _posts/blogs/2017-01-28-Spring-Session-Grails-Plugin-part-2.md %})
    I'll explain Mongo datastore. Happy coding, Cheers !!!
