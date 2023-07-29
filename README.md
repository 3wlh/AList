# AList
## AList_安装
#### Docker
###### 拉取
```sh
docker pull xhofe/alist
```
###### 稳定版
```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="xhofe/alist" xhofe/alist:latest
```
###### 测试版（不推荐）
```sh
docker run -d --restart=always -v /etc/alist:/opt/alist/data -p 5244:5244 -e PUID=0 -e PGID=0 -e UMASK=022 --name="xhofe/alist" xhofe/alist:main
```
###### 查看密码
```sh
docker exec -it alist ./alist admin
```
###### 验证码识别
```sh
docker run -d --restart=always -p 9898:9898 --name="ddddocr_server" xhofe/ddddocr_server:main
```
## AList_美化
##### 自定义头部
```txt
<link rel="stylesheet" type="text/css" href="http://127.0.0.1/alist_data/style.css">
<script src="http://127.0.0.1/alist_data/script.js"></script>
```
##### 自定义内容
```txt
<link rel="stylesheet" type="text/css" href="http://127.0.0.1/alist_data/style_diy.css">
<script src="http://127.0.0.1/alist_data/script_diy.js"></script>
```
##### 引入<img>图片
```txt
https://ghproxy.net/https://raw.githubusercontent.com/3wking/AList/main/IMG/img_11.jpg
```
#### data
```txt
https://ghproxy.net/https://raw.githubusercontent.com/3wking/AList/main/data/json/key_alist.json
```
好