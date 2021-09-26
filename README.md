# Image Repository 
Backend application for an image repository. (WIP) Basic implementation: @see [GraphQl](doc:image-repository#readme#GraphQl)
 - Create user
 - Search for user
 - update image
 - search for image with filters 

# Requirements

Elixir Language
https://elixir-lang.org/install.html

PostgreSQL
https://www.postgresql.org/download/

Create a super user with name `postgres`. If you installed postgres from brew, run this command:

`/usr/local/opt/postgres/bin/createuser -s postgres`

# Installation

If not using docker edit the file `config/dev.exs` line 4 to 10 with:
```
config :imagerepository, Imagerepository.Repo,
username: "postgres",
password: "postgres",
database: "imagerepository_dev",
hostname: "localhost",
show_sensitive_data_on_connection_error: true,
pool_size: 10
```
Run `make install` or

To start your Phoenix server:
  * Install local hex with `mix local.hex`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.

# Using Docker

Run make install-with-docker

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

### The above query won't work because we need to send the file. An example using curl:
```
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
