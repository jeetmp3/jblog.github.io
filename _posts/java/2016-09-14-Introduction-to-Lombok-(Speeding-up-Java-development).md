---
layout: post
title: Introduction to Lombok (Speeding-up Java development)
status: published
type: post
published: true
comments: true
category: java
tags: [JAVA, LOMBOK]
date: 2016-09-14T00:00:00-04:00
comments: true
share: true
---

Hi Guys, today I am going to talk about <a href="https://projectlombok.org/" target="_blank">Project Lombok</a>. This blog post is divided into 3 parts:

1. Introduction
2. Setup (Using IntelliJ idea)
3. Lombok Annotations

### 1. Introduction
Lombok is java library which helps in reducing boilerplate code. So that you are more focused on you actual code. e.g. A Simple POJO class consist of properties, getters/setter (, Constructors), so here lombok will help you in auto generation of Getter/Setters (and Constructors) by just adding an annotation.

### 2. Setup

1. Check your Idea build number. Go to __Help__ -> __About__

    ![About](/images/java/lombok/about.png){:class="img-responsive"}

2. Download Lombok plugin for Idea IntelliJ <a href="https://plugins.jetbrains.com/idea/plugin/6317-lombok-plugin" target="_blank">https://plugins.jetbrains.com/plugin/6317</a> as per your build number.

3. Goto __File__ -> __Settings__ -> Type Plugins in search text box at top left.

    ![Plugin Settings](/images/java/lombok/settings.png){:class="img-responsive"}

4. Now click __Install plugin from disk__. button and select the downloaded Lombok Plugin.
5. You are done now

>In case you are using eclipse please refer to <a href="https://standardofnorms.wordpress.com/2013/05/10/reducing-java-boilerplate-code-with-lombok-with-eclipse-installation/" target="_blank">This Blog Post</a>.

### 3. Lombok Annotations
Lombok has many different types of annotations for different tasks. You can view the <a href="https://projectlombok.org/features/index.html" target="_blank">full list of annontations here</a>. In this blog we will discuss following annotations.

1. @Getter/@Setter
2. @ToString and @EqualsAndHashCode
3. @NonNull
4. @NoArgsConstructor, @RequiredArgsConstructor and @AllArgsConstructor
5. @Data
6. @Value
7. @Builder
8. @Cleanup

At first you need to add lombok dependency in your classpath. If you are using maven then add bellow dependency in your pom.xml.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f maven_dependency.xml %}

Gradle user will add below dependency in build.gradle file.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f gradle_dependency.gradle %}

#### 1. @Getter/@Setter
Everyone is familier with Getters/Setters in normal pojo. Generating getter/setter is not a big task, these days IDE is smart enough and it can generate those for you, but it increases your LOC and managing them could be a bit cumbersome. Lombok helps you in generating getter/setter by just adding `@Getter` and `@Setter`. By default generated methods type is public but you can change the type by overriding value property of @Getter/@Setter which takes AccessLevel enum type. Available AccessLevel enum values are [PUBLIC, MODULE, PROTECTED, PACKAGE, PRIVATE, NONE]. If you set value to `AccessLevel.NONE` then no getter/setter will be generated.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f GetterAndSetterLombok.java %}

You can add these annotations on Class level too. It will generate getters for all fields and setters for all non-final and non-static fields.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f GetterAndSetterLombokClassLevel.java %} 