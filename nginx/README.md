# maclarensg/nginx

## Description 

A docker build source for nginx as front-end proxy


## Feature

- SSH server 
- Nginx 
- Volume mount for nginx's conf, logs and content

## How to Use

1. Build image

```
docker build .
```

2. Modify docker-compose.yaml

Change the source path in the file

```
...
    volumes:
      - <src path>:/var/nginx/www
      - <src path>:/var/nginx/log
      - <src path>:/var/nginx/config
...
```

3. Start Container
```
docker-compose up -d
``` 

4. Login
```
docker exec -it feproxy /bin/bash -l
```

