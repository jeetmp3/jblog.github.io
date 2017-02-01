---
layout: post
title: Spring-Session Grails Plugin (Part 2)
status: unpublish
type: post
published: true
comments: true
category: blogs
tags: [GRAILS, JAVA, SPRING-SESSION]
date: 2017-01-28T00:00:00-04:00
comments: true
share: true
excerpt: Part 2 of "Spring Session Grails Plugin" series. This blog series will cover Mongo Data store.
---
<a href="https://github.com/jeetmp3/spring-session" target="_blank"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/e7bbb0521b397edbd5fe43e7f760759336b5e05f/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677265656e5f3030373230302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png"></a>

In my [__previous blog__]({{ site.baseurl }}{% link _posts/blogs/2016-12-15-Spring-Session-Grails-Plugin.md %}) I've explained  <a href='https://grails.org/plugin/spring-session' target='_blank'>__spring-session grails plugin__</a> along with Redis datastore. We've also covered Json serialization that will be almost same when you use mongo datastore. In this blog post I'll explain how you can use MongoDB as your session store.

To change datastore you need to add property in your `Config.groovy`.

```groovy
springsession.sessionStore=SessionStore.MONGO
```
This will set MongoDB as your datastore. By default it'll try to connect mongo running on __localhost__ port __27017__. Let's checkout the some config properties with their default values.

***Note:*** *Some of the common properties explained in previous block. Those will work same for mongo datastore*.
{: .notice}

```groovy
springsession.mongo.hostName="localhost" // MongoDB host server. Default is localhost.
springsession.mongo.port=27017 // MongoDB port. Default is 27017.
springsession.mongo.database="spring-session" // MongoDB database to store sessions. Default is spring-session.
springsession.mongo.username="" // MongoDB username. Default is "".
springsession.mongo.password="" // MongoDB password. Default is "".
springsession.mongo.collectionName="sessions" // Mongo collection name to store session data. Default is "sessions".
springsession.mongo.replicaSet=[ [:] ] // MongoDB replica set if any. It includes list of maps [ [hostName: 'localhost', port: 27017] ]  Default is [[:]].
springsession.mongo.jackson.modules=[] // Jackson module class if any. Default is empty list
```

***Note:*** *MongoDB is a NoSQL and schemaless database. So you don't need to create database and collections for the session. It'll auto created when session will created.*
{: .notice}

By default it uses Java serialization. To use Json Serialization please visit to [__first blog__]({{ site.baseurl }}{% link _posts/blogs/2016-12-15-Spring-Session-Grails-Plugin.md %}) of this series. First 2 steps will be same but in 3<sup>rd</sup> step __*Register my module class with spring-session plugin*__ you will have to use mongo specific `jackson.modules` property.

```groovy
springsession.mongo.jackson.modules = ['demo.SimpleModule']
```

That's it in this post guys. In my next blog I'll explain how to use JDBC datastore with spring-session grails plugin.
