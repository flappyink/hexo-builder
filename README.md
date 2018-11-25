# blog

## 目录简介

- themes目录，可以把自己喜欢的主题放在这个themes目录下，然后在_config.yml配置使用的主题

- sources目录，主要存储markdown文档、以及一些静态文件

## 使用方法
### 新建git仓库
clone本项目代码，并push到你的私有git仓库，当然你也可以图省事直接fork。一般博客markdown文件，建议还是私有库好点，毕竟还有一些草稿之类的目录。

最终拿到仓库地址如下所示：
```
https://github.com/hexo-builder
```

### 阿里云镜像容器

创建hexo-builder的镜像仓库
![创建镜像仓库](https://raw.githubusercontent.com/h1ac0k/hexo-builder/master/doc/1.png)
![绑定GIT仓库](https://raw.githubusercontent.com/h1ac0k/hexo-builder/master/doc/2.png)
![设置触发规则](https://raw.githubusercontent.com/h1ac0k/hexo-builder/master/doc/3.png)

## 设定Github Access Token

使用[Github Access Token](https://github.com/settings/tokens)来访问github pages所在的仓库，token生成后按下面的结构修改_config.yml文件上部署部分的代码。

注意token的作用范围设定为最小的(只要可以访问github pages对应的仓库权限即可)，网络上有的做法是直接将SSH Key丢到自动化构建里头，这是非常不安全的。

```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://[这里填写你的github access token]@github.com/[github 用户名]/[[github 用户名]].github.io.git
  branch: master
  message: "{{ now('YYYY-MM-DD HH:mm:ss') }}"
```

## 总体的效果
以上步骤设定好后，就可以实现在source/_posts目录添加文章，一推送到git仓库就能自动化构建hexo博客的功能了。

## 本地预览
```
# 构建本地镜像
docker build -t hexo .

# 生成静态文件
docker run -p 4000:4000 -v /Users/apple/Documents/dev/hexo-builder/source:/var/www/hexo-builder/source/ -v /Users/apple/Documents/dev/hexo-builder/themes:/var/www/hexo-builder/themes/ --rm -it hexo hexo generate

# 开启预览服务
docker run -p 4000:4000 -v /Users/apple/Documents/dev/hexo-builder/source:/var/www/hexo-builder/source/ -v /Users/apple/Documents/dev/hexo-builder/themes:/var/www/hexo-builder/themes/ --rm -it hexo hexo server
```