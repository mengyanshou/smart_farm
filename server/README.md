# server

## 接口验证
所有的接口访问都需要添加header
API-Key=Y29tLm5pZ2h0bWFyZQ==
## 注册
/register
只有username和password是必须

## 登录/login
采用OAuth2.0验证标准，需要交换token
首先规定body

**Content-Type=application/x-www-form-urlencoded**

需要参数：

```shell
username
password
grant_type=password
```

第三个参数固定

添加header

```shell
Authorization=Basic Y29tLm5pZ2h0bWFyZS50ZXJtYXJlOmNvbS5uaWdodG1hcmU=
```

## 用户数据库访问
登录接口会返回一个token字段到用户对象中，将这个token保留
添加header
Authorization=Bearer $token