---
layout: post
title: JSON deserialize generic types using Gson and Jackson
status: published
type: post
published: true
comments: true
category: blogs
tags: [GSON, JACKSON, JAVA, JSON]
date: 2016-09-07T14:17:25-04:00
comments: true
share: true
excerpt: In this blog post we are going to learn how to deserialize json into java generic types.
---

This blog will guide you how to deserialize json into java generic types. Suppose we have 2 json as given below.

###### SocialAccountResponse.json
{% gist jeetmp3/d55647fc8a5805a70b3aafbde9bd349f SocialAccountsResponse.json %}

###### UserResponse.json
{% gist jeetmp3/d55647fc8a5805a70b3aafbde9bd349f UserResponse.json %}

Both json have common keys, only data object is being change. To deserialize these jsons without generic types we would have to create 2 wrappers with 2 actual data class. But with generic types we only need to create generic class for root keys and actual data class for every object in data key.

###### GenericResponse.java
{% gist jeetmp3/312858a4702ec8f7a875d26f04515e26 GenericResponse.java %}

###### SocialAccountsResponse.java
{% gist jeetmp3/312858a4702ec8f7a875d26f04515e26 SocialAccountsResponse.java %}

###### UserResponse.java
{% gist jeetmp3/312858a4702ec8f7a875d26f04515e26 UserResponse.java %}

Now We'll deserialize above JSON in Generic class using below libraries

1. <a href="https://github.com/google/gson" target="_blank">Google Gson</a>
2. <a href="https://github.com/FasterXML/jackson-databind" target="_blank">Jackson</a>

#### 1. Deserialize using Google Gson
{% gist jeetmp3/6879107bd56ee9ede8cfdcfc8bdd1f5f GsonDeserializer.java %}

#### 2. Deserialize using Jackson
{% gist jeetmp3/e6650ba72955eb82095d0ead3029df4f JacksonDeserializer.java %}
