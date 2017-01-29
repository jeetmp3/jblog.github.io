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
excerpt: This blog post will cover Project Lombok annotations.
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
 
Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f GetterAndSetterNormal.java %}

**Note:** `@Setter` will not work on final fields.
{: .notice}

#### 2. @ToString and @EqualsAndHashCode
__`@ToString`__ and __`@EqualsAndHashCode`__ generates `toString()`, `equals(Object object)` and `hashCode()` in our pojo. By default `@ToString` includes Classname and all non-static fields. You can specify fields in `of` property of `@ToString`. You can also exclude fields by `exclude` property.

By default `@EqualsAndHashCode` include non-static and non-transient fields. You can include or exclude fields by providing in `of` and `exclude` property (Same as `@ToString`). It has extra property called `callSuper` which invokes superclass's implementation of `hashCode()` and `equals()`. By default it doesn't invoke superclass methods. You can override it by setting its value to `true`.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f ToStringAndEqualsAndHashCode.java %}

#### 3. @NonNull
This annotation will generate null-check for any field. It can be used with Constructor args, fields or method args.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f NonNullCheck.java %}

Above code is equvalant to

{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f NonNullCheckNormal.java %}

#### 4. @NoArgsConstructor, @RequiredArgsConstructor and @AllArgsConstructor
__`@NoArgsConstructor`__ will generate default constructor. If your class contains final fields, then a compilation error will be generated. So if you want to generate default constructor with default values for final fields set __force=true__ `@NoArgsConstructor(force = true)`.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f NoArgsConstructor.java %}

Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f NoArgsConstructorNormal.java %}

__`@RequiredArgsConstructor`__ will generate constructor, if your class contains final fields or any field marked with `@lombok.NotNull` then it'll generate parameterized constructor and those fields will be added in constructor args and null check will be added in construtor.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f RequiredArgsConstructor.java  %}

Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f RequiredArgsConstructorNormal.java %}

__`@AllArgsConstructor`__ will generate parameterized constructor with all fields as constructor args.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f AllArgsConstructor.java %}

Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f AllArgsConstructorNormal.java %}

**Note:** If you want to generate static factory method with private constructor then set `staticName` property of @xxxConstructor.
 {: .notice}

{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f ConstructorWithFactoryMethod.java %}

Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f ConstructorWithFactoryMethodNormal.java %}

#### 5. @Data
__`@Data`__ annotation can only be used with Class and it covers below annotations:

* @Getter
* @Setter
* @RequiredArgsConstructor
* @ToString
* @EqualsAndHashCode
* @Value
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f DataLombok.java %}
Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f DataLombokNormal.java %}

#### 6. @Value
__`@Value`__ is used to create Immutable pojo. By default class and all fields made final and no setters will be generated. Just like `@Data` it also generates `toString()`, `hashCode()` and `equals()`. If you don't want to make a field final then mark it with `@NonFinal`.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f ValueLombok.java %}
Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f ValueLombokNormal.java %}

#### 7. @Builder
__`@Builder`__ is used to generate builder API pattern. It generates inner class called &lt;YourClassName&gt;Builder which expose builder pattern based setters. `@Singular` is used with `@Builder` and only valid with `java.util.List` types. This annotation will add to adder methods one for single elements and another for complete collection.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f BuilderLombok.java %}
Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f BuilderLombokNormal.java %}

#### 8. @Cleanup
__`@Cleanup`__ helps in automatically close the resource. This annotation takes one parameter as closing method name. By default its value is __close__.
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f CleanupLombok.java %}
Above code is equvalant to
{% gist jeetmp3/fa6d9327b670071f11b417ca9693029f CleanupLombokNormal.java %}

Happy Coding 😀😀😀 !!! If you have any feedback please comment down below.