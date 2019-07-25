---
layout: post
title: Getting started with GraphQL (Java)
status: published
type: post
published: true
comments: true
category: blogs
tags: [GRAPHQL, API]
date: 2019-07-23T00:00:00-04:00
comments: true
share: true
excerpt: This blog post will guide you through GraphQL Java development
logo: graphql/graphql.png
---

GraphQL is query language for your Rest APIs and gives client power to select exactly what they need. It also provides server side runtime to execute the queries.

GraphQL has 3 major parts
1. GraphQL server
2. GraphQL Schema
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

#### GraphQL Java in Action
Below code will demonstrate you how to integrate GraphQL in Spring application. So let's start with the GraphQL schema file. 

The code structure will look like

![GraphQL code structure](/images/graphql/graphql-code-structure.png)

##### users.graphql

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
Now well start configuring the GraphQL Java objects along with resolvers for the queries (hello & user).

##### Step 1: Read & parse schema file

Filename: GraphQLSchema.java
```java
    private TypeDefinitionRegistry readAndParseSchemaFile() throws Exception {
        String schemaString = ResourceUtils.readClasspathResourceContent("users.graphql");

        SchemaParser schemaParser = new SchemaParser();
        
        // parsing schema file and creating typeDefRegistery
        return schemaParser.parse(schemaString);
    }
```

##### Step 2: Configuring resolvers

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

##### Step 3: Prepare GraphQL object and execute query

```java
    private void setup() throws Exception {
        // We need to create GraphQLSchema Object but before that we need to configure resolvers 
        GraphQLSchema graphQLSchema = new SchemaGenerator().makeExecutableSchema(readAndParseSchemaFile(), buildRuntimeWiring());
        graphQL = GraphQL.newGraphQL(graphQLSchema).build();
    }
    
    public ExecutionResult executeQuery(String graphQLQuery) {
        return graphQL.execute(graphQLQuery);
    }
``` 

##### Step 4: Serve user queries on the endpoint (/graphql)


```java
    @RestController
    public class GraphQLController {
    
        private final GraphQLService graphQLService;
    
        @Autowired
        public GraphQLController(GraphQLService graphQLService) {
            this.graphQLService = graphQLService;
        }
    
        @PostMapping("/graphql")
        public Map<String, Object> executeQuery(@RequestBody GraphQLRequest request) {
            return graphQLService.executeQuery(request.getQuery()).toSpecification();
        }
    }
```

##### Step 5: User GraphiQL or Rest to execute graphql query 
GraphiQL resource links 
* [Download Link](https://github.com/graphql/graphiql)
* [Source Code](https://github.com/graphql/graphiql)

Add your /graphql controller's endpoint in GraphiQL and start executing query

![Query hello](/images/graphql/gqlq1.png)

We can ask the response fields and graphql will serve only selected fields.
1. Query users for name only

![Name only](/images/graphql/gqlq2.png)

2. Query users for all fields

![All fields](/images/graphql/gqlq3.png)

We can ask for multiple queries in single request

![Multiple queries](/images/graphql/gqlq4.png)

Even same query with multiple times with alias

![Duplicate queries](/images/graphql/gqlq5.png)

You can find complete code [here](https://github.com/jeetmp3/tutorials/tree/master/graphql-java-intro)

Happy Coding 😀😀😀 !!! If you have any feedback please comment down below.
