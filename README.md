# hexo-builder

自动化构建Hexo博客

# 原理
利用阿里云[容器镜像服务](https://help.aliyun.com/product/60716.html)的自动化构建服务，将hexo的安装、生成静态文件、部署集成到Dockerfile内，在容器构建完成时也就完成了静态博客的部署

# 目录结构说明
```
AppledeMBP:blog apple$ tree -L 1
.
├── CNAME
├── Dockerfile
├── README.md
├── _config.yml
├── about
├── draft
├── img
├── links
├── source # 映射到 /var/www/blog/source
└── themes # 遇到到 /var/www/blog/themes
```

# deploy注意点
需要设置Github Access Token，来安全访问github pages的仓库。

# 本地构建发布
```
docker build -t hexo .
```

# 本地预览
```
docker run -p 4000:4000 --rm -it hexo sh
```



