# pbloggg

Trying to build a node backend

## Endpoint

### Auth

`POST` {{base_api_url}}/user/register <br/>
`POST` {{base_api_url}}/user/login <br/>

### Storage

`POST` {{base_api_url}}/storage/cover <br/>

### Blog

`GET` {{base_api_url}}/blog?page=1 <br/>
`GET` {{base_api_url}}/blog/{blogID} <br/>
`POST` {{base_api_url}}/blog/create-blog <br/>
`PUT` {{base_api_url}}/blog/update/{blogID} <br/>
`DELETE` {{base_api_url}}/blog/delete/{blogID} <br/>

## TODO:

[x] Storage
[x] Blog
[x] Blog CRUD
[x] Register
[x] Redesign auth token db
[x] Login
[x] Pagination
[ ] Logout (remove token)
[ ] Latest, Trending, Popular..
[ ] Read count of blog
[ ] Bookmark (Save, Remove)
[ ] Semi auth for showing bookmark of user
