# GraphQL
> GraphQL is a query language for APIs - not databases.

> A more efficient Alternative to REST

> GraphQL describes in detail the behaviour of a GraphQL server.

## Mutation | Update|Delete|Insert into the table
```
mutation _ {
  createCompany(
    name: "XYZ COMPANY"
    email: "admin@xyz.com"
    create_date: "2023-03-15 23:54:00"
    status: 1
  ) {
    id
    name
    status
  }
}

mutation _ {
  createStudent(
    name: "mostain"
    email: "mostain@yahoo.com"
    phone: "01672710028"
    status: 1
  ) {
    id
    name
  }
}
```

## Query | Retrieve/Select from the table
```
query _ {
  student(id: "cg9edotjdmi32f25i9v0") {
    id
    name
    email
    phone
  }
}
```


## Graphql ও MySQL স্কিমা
![graphql_sql](../../img/graphql_sql.png)

## Learning Resource
* [Custom-scalar-type](https://github.com/graphql-go/graphql/blob/master/examples/custom-scalar-type/main.go)