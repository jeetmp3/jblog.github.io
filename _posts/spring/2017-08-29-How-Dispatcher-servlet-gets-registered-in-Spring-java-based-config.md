---
layout: post
title: How Dispatcher servlet gets registered in Spring java based config
status: published
type: post
published: true
comments: true
category: java
tags: [JAVA, SPRING, SPRING_FRAMEWORK, SERVLET]
date: 2017-08-28T00:00:00-04:00
comments: true
share: true
excerpt: This blog post will explain how Spring Web context gets registered in servlet context.
logo: spring/spring.png
---

Few days ago my colleague ask me about how Spring Dispatcher servlet gets registered in Java based config, as there is no XML
  used in configuration. One thing I was (actually we both were) sure about that the class `AbstractAnnotationConfigDispatcherServletInitializer`
  registers those servlet and all the configuration. But the question was How ?
  
In order to understand that we will be going back to the servlet world. According to 
<a href='https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContainerInitializer.html?is-external=true' target='_blank'>
Servlet Java Doc</a>, `ServletContainerInitializer` is the interface which is used to register servlets, filters and other related stuff. 

So any implementation of `ServletContainerInitializer` will be notified of web application's startup phase using a callback method 

```java
public void onStartup(Set<Class<?>> c, ServletContext ctx) throws ServletException {
    
} 
```

In above method, you'll notice there is a parameter __c__  of type Set<Class<?> >. You probably thinking why it's there.
So here is the another part of the magic, there is an annotation called `@HandlesTypes` used alongside with `ServletContainerInitializer`.
 The annotation accepts array of Class as input argument.

```java
public @interface HandlesTypes {
    
    Class<?>[] value();
}
```

So any class (and its subclasses), which is passed as an argument to that annotation (`HandlesTypes`) will be scanned by the container and finally the collection of those class will be passed to `ServletContainerInitializer#onStartup()` during the startup time.

Now you might be thinking, how the implementation of `ServletContainerInitializer` gets picked by the container? So the answer to that question is:

According to the <a href='https://docs.oracle.com/javaee/7/api/javax/servlet/ServletContainerInitializer.html?is-external=true' target='_blank'>Java Docs</a>

>Implementations of this interface must be declared by a JAR file resource located inside the META-INF/services directory and named for the fully qualified class name of this interface, and will be discovered using the runtime's service provider lookup mechanism or a container specific mechanism that is semantically equivalent to it. In either case, ServletContainerInitializer services from web fragment JAR files excluded from an absolute ordering must be ignored, and the order in which these services are discovered must follow the application's classloading delegation model.

Now come back to the Spring Era and check the spring-web*.jar (just extract the jar) and look for the file __javax.servlet.ServletContainerInitializer__. Inside that file you'll find a fully qualified class name as __org.springframework.web.SpringServletContainerInitializer__.

That's it, you've solved the mystery!!
 
 Now check the source code of that class (go to the <a href='https://github.com/spring-projects/spring-framework/blob/master/spring-web/src/main/java/org/springframework/web/SpringServletContainerInitializer.java' target='_blank'>GitHub</a>), you'll notice 
 a class `WebApplicationInitializer` inside `@HandlesTypes` which is the parent class of most of the Spring's initializers (`AbstractAnnotationConfigDispatcherServletInitializer`, `AbstractSecurityWebApplicationInitializer`).
  
Now you know how to create your own initializer. 

Cheers!!! Happy coding.

Please share your thoughts, I've already have comment plugin for that ☺ ☺

