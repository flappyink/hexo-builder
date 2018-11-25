FROM node:8.12.0-alpine

RUN npm --registry https://registry.npm.taobao.org install hexo-cli -g

RUN apk add git

# 初始化项目，并删除默认的hello-world页面
RUN mkdir -p /var/www && cd /var/www && hexo init blog && rm -rf /var/www/blog/source/_posts/hello-world.md

# 设置WORKDIR以下的RUN/CMD/ENTRYPOINT都将在指定的目录执行命令
WORKDIR /var/www/blog/

# 安装hexo deploy依赖库
RUN npm install && npm install hexo-deployer-git --save

#-----------------------以上部分可以单独做个镜像，然后引入加快构建速度----------------------------

# 复制markdown文档、主题、自定义配置进容器
ADD source /var/www/blog/source
ADD themes /var/www/blog/themes
ADD _config.yml /var/www/blog

# 生成静态文件
RUN hexo generate

# 配置deploy需要的组件
RUN git config --global user.email "your name@example.com" && git config --global user.name "your name"
# RUN hexo deploy