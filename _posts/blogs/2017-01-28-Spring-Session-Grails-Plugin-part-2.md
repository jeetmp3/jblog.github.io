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

In my [__previous post__]({{ site.baseurl }}{% link _posts/blogs/2016-12-15-Spring-Session-Grails-Plugin.md %}) I've explained What is this plugin all about along with Redis datastore. In this blog post I'll explain how you can use MongoDB as your session store.

To change datastore you need to add property in your `Config.groovy`.

```groovy
springsession.sessionStore=SessionStore.MONGO
```
This will set MongoDB as your datastore. By default it'll try to connect mongo running on __localhost__ port __27017__. Let's checkout the some config properties with their default values.

***Note:*** *Some of the common properties explained in previous block will work same for mongo datastore*.
{: .notice}

```groovy
springsession.mongo.hostName="localhost" // MongoDB host server. Default is localhost
```
