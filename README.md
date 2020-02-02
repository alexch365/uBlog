# uBlog

Создание поста
```
POST http://localhost:3000/posts
Content-Type: application/json

{
  "post": {
    "title": "title",
    "body": "body",
    "author_login": "login",
    "author_ip": "192.168.0.1"
  }
}
```
Добавление оценки посту
```
POST http://localhost:3000/ratings
Content-Type: application/json

{
  "rating": {
    "post_id": "1",
    "value": "5"
  }
}
```
Топ постов по среднему рейтингу
```
GET http://localhost:3000/posts/top?limit=100
```

Список авторов с одним ip
```
GET http://localhost:3000/co_authors
```
