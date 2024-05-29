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

[x] Storage <br/>
[x] Blog <br/>
[x] Blog CRUD <br/>
[x] Register <br/>
[x] Redesign auth token db <br/>
[x] Login <br/>
[x] Pagination <br/>
[ ] Latest, Trending, Popular.. <br/>
[ ] Reading/view count of blog <br/>
[ ] Bookmark (Save, Remove) <br/>
[ ] Semi auth for showing bookmark of user <br/>
[ ] Logout (remove token) <br/>
