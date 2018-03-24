---
layout: post
title: Whats new in Java 10
status: published
type: post
published: true
comments: true
category: java
tags: [JAVA, JAVA10, OPTIONAL]
date: 2018-03-21T00:00:00-04:00
comments: true
share: true
excerpt: Finally Java10 is available for GA. This blog will cover some of the new features introduced in java 10. e.g. Local Variable Type Inference, UnmodifiableCollections in java streams etc
logo: java/java-10.png
---

So finally wait is over, Java 10 is in GA now. The cool feature of this build has already been in discussions. Yes, I'm talking about the `var`. In this blog I'll discuss some of the new features along with the almighty `var`.

### 1. Optional#orElseThrow()
Synonym for `Optional.get()` but more intuitive. It will throw `java.util.NoSuchElementException` same as `get()` but with clear understanding that if value isn't there the method may throw an Exception, so the developer will think to handle the exceptional case as well.

```java
class OptionalDemo {
    public void perform() {
        Optional<String> result = calculate();
        // It'll throw the exception 
        String result1 = result.get();
        
        // It'll also throw the exception but by it's name
        // developer might think of handling the exception
        String result1 = result.orElseThrow();
    }
    
    public Optional<String> calculate() {
        return Optional.empty();
    }
}
```

### 2. copyOf() in List, Set and Map
Added copyOf() in List, Set and Map to create unmodifiableCollections() from the given collection. This method checks if collection is already is type of `java.util.ImmutableCollections.AbstractImmutableMap` then simply return that otherwise create a new ImmutableCollection from the given.

```java
class UnmodifiableCollectionDemo {
    
    public void usingList() {
        List<Integer> list = List.of(1, 2, 3, 4, 5);
        
        // already ImmutableCollection so simply returns
        List<Integer> unmodifiable1 = List.copyOf(list); 
        
        List<Integer> list1 = new ArrayList();
        list1.add(1);
        list1.add(2);
        
        // Creates new ImmutableCollection and returns
        List<Integer> unmodifiable = List.copyOf(list1); 
    } 
}
```

### 3. New methods added in Collectors
To collect stream result as Unmodifiable collection, 3 new methods added in `java.util.stream.Collectors` class.
 
1. toUnmodifiableList
2. toUnmodifiableSet
3. toUnmodifiableMap

```java
class StreamsDemo {
    public void convertToUnmodifiableCollections(List<String> input) {
        
        // List demo
        List<String> list = input.stream()
                                .map(String::toUpperCase)
                                .collect(Collectors.toUnmodifiableList());
        
        // Set demo
        Set<String> set = input.stream()
                                .map(String::toUpperCase)
                                .collect(Collectors.toUnmodifiableSet());
        
        // Map demo
        Map<String, Integer> map = input.stream()
                                .map(String::toUpperCase)
                                .collect(Collectors.totoUnmodifiableMap(String::toString, String::length));
    }
}
```

### 4. var - Local Variable Type Inference
Type inference was introduced with lambdas. Now in java 10 a new keyword `var` introduced for local variable type inference. 
  This will remove the ceremony code to initialize local variables and maintain the java's static typing. Type will be 
  inferred by the compiler at compilation time.
  
```java
public void varDemo() {
    int i = 10;
    List<String> list = new ArrayList<>();
    Map<String, Integer> map = new HashMap<>();
    
    // With var above code can be written as
    
    var i = 10; 
    var list = new ArrayList<String>();
    var map = new HashMap<String, Integer>();
}
``` 

Type inference can only be used with local variables and once the type is inferred then cannot be changed.

```java
public void demo() {
    var name = "Jitendra";
    name = 3; // Not allowed
}
``` 
 
All the methods of the target type will be accessed with the declared variable.
```java
public void demo() {
    var list = new ArrayList<String>();
    list.add("Jitendra");
    list.add("Singh");
}
```

Happy Coding 😀😀😀 !!! If you have any feedback please comment down below.
