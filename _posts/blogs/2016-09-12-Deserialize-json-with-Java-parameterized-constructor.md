---
layout: post
title: Deserialize json with Java parameterized constructor
status: published
type: post
published: true
comments: true
category: blogs
tags: [JACKSON, JAVA, JSON]
date: 2016-09-12T14:17:25-04:00
comments: true
share: true
---

Hi Guys in my previous blog [JSON deserialize generic types using Gson and Jackson]({{ site.baseurl }}{% link _posts/blogs/2016-09-07-JSON-deserialize-generic-types-using-Gson-and-Jackson.md %}) I talked about how you can deserialize json in Java Generics. Now in this blog post we are going to learn how to deserialize json into Java class which doesn't have default constructor. For this blog I am using Jackson library.

Almost all frameworks requires default/no-argument constructor in your class. Because these frameworks use <a href='https://docs.oracle.com/javase/tutorial/reflect/' target='_blank'>reflection</a> to create objects by invoking default constructor. But if there is no default constructor present in class then its hard to instantiate using reflection. Let's assume we have a class with no-args constructor (only a parameterized constructor present) and we want to deserialize it.
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfile.java %}

And a json file 
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfile.json %}

There are two ways in Jackson to deserialize this type of classes.

1. Custom deserializer
2. Mixin Annotations

### 1. Custom Deserializer
In Custom Deserializer you will create a class and extend it with `com.fasterxml.jackson.databind.JsonDeserializer` and override its abstract method `deserialize()`. This class gives you full control, you'll get json in `com.fasterxml.jackson.core.JsonParser`. Now you can map json properties with class properties. In my case I am creating `UserProfileDeserializer`.
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfileDeserializer.java %}

Now we need to register above deserializer in `com.fasterxml.jackson.databind.ObjectMapper`. So that, while deserializing UserProfile class it use `UserProfileDeserializer`.
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfileDeserializerDemo.java %}

>In above code we are adding our Deserializer in `com.fasterxml.jackson.databind.module.SimpleModule` and that module is registered in `com.fasterxml.jackson.databind.ObjectMapper`. Similarly, you can register deserializers for other classes too.

### 2. Mixin Annotations
Jackson provides another way of doing this by using *__Mixin Annotations__*. You can read about Jackson Mixin <a href="https://github.com/FasterXML/jackson-docs/wiki/JacksonMixInAnnotations" target="_blank">here</a>. In our class `UserProfile` there is no default constructor, it has a parameterized constructor. Let's checkout how to create mixin for our class.
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfileMixin.java %}

That's it !! 

>We have created a constructor same as in `UserProfile` class and marked it with `com.fasterxml.jackson.annotation.JsonCreator` annotation. This will tell `com.fasterxml.jackson.databind.ObjectMapper` this is how target class (`UserProfile`) constructor looks and constructor parameters are marked with `com.fasterxml.jackson.annotation.JsonProperty` annotation.

Now checkout how to register this mixin class in `com.fasterxml.jackson.databind.ObjectMapper`
{% gist jeetmp3/7eff6ff303b58894715878833c381f24 UserProfileMixinDemo.java %}

Enjoy !!!! ☺☺