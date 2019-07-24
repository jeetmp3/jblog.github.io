---
layout: post
title: Getting started with GraphQL (Java)
status: published
type: post
published: false
comments: true
category: blogs
tags: [GRAPHQL, API]
date: 2019-07-23T00:00:00-04:00
comments: true
share: true
excerpt: This blog post will guide you through GraphQL Java development
logo: graphql/graphql.png
---

THIS blog is in DRAFT STATE

GraphQL is query language for your Rest APIs and gives capability to the client to select exactly what they need. It also provides server side runtime to execute the queries.

GraphQL has 3 major parts
1. server
2. Schema
3. Client

### GraphQL Server
GraphQL server is responsible to validate & execute the queries and return the __needed response__ to the client. The client has free hand to select the fields as per it's need and server will return only those selected fields.  

### GraphQL Schema
GraphQL schema consist the queries and types. As a API owner we can decide what queries & types will be available to the consumer. The schema has default root object type called __Query__ which contains all the queries.
An example schema is

```graphql
type Query {
    hello: String
    greet(name: String): String
}
```
In above schema root object is Query and it has two field called *hello* and *greet* and both are String type. The *greet* has an input argument *name* which is a type of String. This means client can pass any string type argument while querying *greet*.
For every field or query in the Query Type will have corresponding resolver which will be running at GraphQL Server. [Click here](https://graphql.org/learn/schema/) to read more about graphql schema and types.
 
### Client
The clients are the consumer. Since GraphQL works over Rest so any rest client can query the graphql. There are few tools which are great for testing. These tools gives the auto-completion features and we can view all possible queries and types.
Some of the tools are __GraphiQL__, __insomnia__. 

#### Demo

GraphQL schema file

users.graphql

```graphql
type Query {
    hello: String
    users(name: String): User
}

type User {
    name: String
    age: Int
    address: String
}
```

Step 1: Read & parse schema file

```java
    private TypeDefinitionRegistry readAndParseSchemaFile() throws Exception {
        String schemaString = ResourceUtils.readClasspathResourceContent("users.graphql");

        SchemaParser schemaParser = new SchemaParser();
        
        // parsing schema file and creating typeDefRegistery
        return schemaParser.parse(schemaString);
    }
```

Step 2: Configuring resolvers

```java
    private RuntimeWiring buildRuntimeWiring() {
        return RuntimeWiring.newRuntimeWiring()
                .type("Query", builder -> builder.dataFetchers(buildDataFetchers()))
                .build();
    }

    private Map<String, DataFetcher> buildDataFetchers() {
        Map<String, DataFetcher> dataFetchers = new HashMap<>();
        dataFetchers.put("hello", new StaticDataFetcher("Welcome to GraphQL world."));
        dataFetchers.put("users", env -> User.of("John", 28, "India"));
        return dataFetchers;
    }
```

Step 3: Prepare GraphQL object

```java
    private void setup() throws Exception {
        // We need to create GraphQLSchema Object but before that we need to configure resolvers 
        GraphQLSchema graphQLSchema = new SchemaGenerator().makeExecutableSchema(readAndParseSchemaFile(), buildRuntimeWiring());
        graphQL = GraphQL.newGraphQL(graphQLSchema).build();
    }
``` 

Step 4: Serve user queries

```java
    public Object executeQuery(String graphQLQuery) {
        ExecutionResult result = graphQL.execute(graphQLQuery);
        return result.getData();
    }
```

Step 5: user can use different queries.




Happy Coding 😀😀😀 !!! If you have any feedback please comment down below.
