# Build

## PostgreSQL

```
docker build -t registry.paswolf.com/postgres:16-alpine-ssl .
docker push registry.paswolf.com/postgres:16-alpine-ssl
```

## MySQL

```
docker build -t registry.paswolf.com/mysql:8.0-ssl .
docker push registry.paswolf.com/mysql:8.0-ssl
```
