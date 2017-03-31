---
layout: post
title: Spring-Session Grails Plugin (Part 3)
status: unpublish
type: post
published: true
comments: true
category: blogs
tags: [GRAILS, JAVA, SPRING-SESSION]
date: 2017-03-30T00:00:00-04:00
comments: true
share: true
excerpt: Part 3 of "Spring Session Grails Plugin" series. This blog series will cover JDBC Data store.
---
<a href="https://github.com/jeetmp3/spring-session" target="_blank"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/e7bbb0521b397edbd5fe43e7f760759336b5e05f/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677265656e5f3030373230302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png"></a>

Hi Folks hope you're doing well!

I was quit busy since my last blog post. So this post is part of <a href="{{ site.baseurl }}/search/Spring-Session" target="_blank">__Spring-Session Grails Plugin__</a> blog series which will cover JDBC as your datastore. 

In this blog post I'll explain how you can use JDBC as your session store. To use JDBC as your datastore you need to create two tables in your database. Spring Session doesn't use any type of ORM tool. You'll need to create two table one is for session and other for session attributes and the format will be like __&lt;SESSION TABLE&gt;__ and __&lt;SESSION TABLE&gt;_ATTRIBUTES__".

```sql
CREATE TABLE SPRING_SESSION (
  SESSION_ID CHAR(36),
  CREATION_TIME BIGINT NOT NULL,
  LAST_ACCESS_TIME BIGINT NOT NULL,
  MAX_INACTIVE_INTERVAL INT NOT NULL,
  PRINCIPAL_NAME VARCHAR(100),
  CONSTRAINT SPRING_SESSION_PK PRIMARY KEY (SESSION_ID)
);

CREATE INDEX SPRING_SESSION_IX1 ON SPRING_SESSION (LAST_ACCESS_TIME);

CREATE TABLE SPRING_SESSION_ATTRIBUTES (
 SESSION_ID CHAR(36),
 ATTRIBUTE_NAME VARCHAR(200),
 ATTRIBUTE_BYTES BYTEA,
 CONSTRAINT SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_ID, ATTRIBUTE_NAME),
 CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_ID) REFERENCES SPRING_SESSION(SESSION_ID) ON DELETE CASCADE
);

CREATE INDEX SPRING_SESSION_ATTRIBUTES_IX1 ON SPRING_SESSION_ATTRIBUTES (SESSION_ID);
```
To change datastore you need to add property in your `Config.groovy`.

```groovy
springsession.sessionStore=SessionStore.JDBC
```

This will set JDBC as your datastore. By default it'll try to connect __H2 Database__. Let's checkout the some config properties with their default values.

***Note:*** *Some of the common properties explained in part 1. Those will work same for jdbc datastore*.
{: .notice}

```groovy
springsession.jdbc.driverClassName="org.h2.Driver" // Driver class default is H2 driver
springsession.jdbc.url="jdbc:h2:~/test" // JDBC Connection string
springsession.jdbc.username="" // JDBC username. Default is "".
springsession.jdbc.password="" // JDBC password. Default is "".
springsession.jdbc.tableName="SessionData" // table name to store sessions

springsession.jdbc.pool.maxActive=10 // Connection pool max active
springsession.jdbc.pool.maxTotal=20 // Connection pool max total
springsession.jdbc.pool.minIdle=3 // Connection pool min idle
springsession.jdbc.pool.maxWaitMillis=10000 // Connection wait time
springsession.jdbc.pool.defaultAutoCommit=true // autocommit true by default
springsession.jdbc.pool.defaultReadOnly=false // read only sessions
springsession.jdbc.pool.defaultTransactionIsolation=Connection.TRANSACTION_READ_COMMITTED // transaction isolation  
springsession.jdbc.pool.validationQuery="SELECT 1" // Validate connection query  
```

By default it uses Java serialization. To use Json Serialization please visit to [__first blog__]({{ site.baseurl }}{% link _posts/blogs/2016-12-15-Spring-Session-Grails-Plugin.md %}) of this series. First 2 steps will be same but in 3<sup>rd</sup> step __*Register my module class with spring-session plugin*__ you will have to use jdbc specific `jackson.modules` property.

```groovy
springsession.jdbc.jackson.modules = ['demo.SimpleModule']
```