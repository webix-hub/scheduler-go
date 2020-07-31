Backend for Webix Scheduler
===========================

### How to start

- create db
- create config.yml with DB access config

```yaml
db:
  host: localhost
  port: 3306
  user: root
  password: 1
  database: calendar
```

- start the backend

```shell script
go build
./wsh
```
