# Image Repository 

# Requirements

Elixir Language
https://elixir-lang.org/install.html

PostgreSQL
https://www.postgresql.org/download/

# Installation
Run `make install` or

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.

# Tests
Run `mix test`
```
├── imagerepository
│   └── account_test.exs
├── imagerepository_web
│   └── schema
│       └── mutation
│           ├── create_user_test.exs
│           └── upload_image_test.exs
├── support
│   ├── channel_case.ex
│   ├── conn_case.ex
│   └── data_case.ex
└── test_helper.exs
```

# GraphQl

## Mutations
```javascript
mutation{
  createUser(email: "test@email.com", username: "testusername"){
    id
    email
    username
  }
}

mutation{ 
  uploadImage(caption:"image caption",tag:"photo,car,speed", fileData: "upload/image.png" userId: "1"){ 
   id 
   url
   caption
   tag
   user{
     username
    }
  }
} 
```
```curl
The bove query won't work because we need to send the file. An example using curl:
curl -X POST -F query="mutation{ uploadImage(caption:\"some caption\", tag:\"some, captions\", fileData:\"photo_png\" userId: \"1\"){ id url}}" -F photo_png=@path/to/photo.png localhost:4000/graphiql
```
## Queries

```javascript
query {
  user(id:1){
    id
    username
    email
  }
}

query {
  images(
    filter:{
      caption: "some caption",
      tag: "some tag",
      url: "some url"
    }, 
  limit: 3, 
  order: DESC){
    id
    url
    caption
    tag
  }
}
```
