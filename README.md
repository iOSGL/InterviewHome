# InterviewHome 

一款用`Weex`开发的多页面`App`

# 附小程序
![](https://ws2.sinaimg.cn/large/006tNc79gy1g22jdvqpc6j30ec0emdh7.jpg)

## Install

依赖环境

``` node
$  npm -v
// 6.4.1
$ node -v
// v10.15.3
```
建议使用 [n](https://github.com/tj/n)管理工具管理`node`

### 安装 Weex-Tookit

[Weex-Toolkit 1.x](https://github.com/weexteam/weex-toolkit/blob/v1.0/README-zh.md)

[Weex-Toolkit 2.x](https://weex.apache.org/zh/tools/toolkit.html#%E7%B3%BB%E7%BB%9F%E7%BB%84%E4%BB%B6)

我本地配置环境
![](https://ws4.sinaimg.cn/large/006tNc79gy1g22jngb8hpj30xk0f23z9.jpg)

安装`Weex-Tookit`2.x命令

``` bash
$ sudo npm i weex-toolkit@beta -g

$ weex repair
报错的话执行
 
$ weex doctor
```

安装`Weex-Tookit`1.x命令

``` bash 
$ sudo npm i weex-toolkit@latest -g
```

卸载命令

``` bash
$ sudo npm uninstall -g weex-toolkit && rm -rf ~/.wx && rm -rf ~/.weex_tmp
```

**注** 我本地使用`Weex-Toolki` 2.x, `weexSDK`版本`1.8.0`


## Quickstart

``` bash
$ git clone https://github.com/iOSGL/InterviewHome.git

cd 到 文件夹下

$ npm install
```

本项目在platforms下已经有`iOS`项目，无须执行 `weex add iOS`

编译某个文件

`weex compile src/xxxx.vue dest -m`

预览某个文件

`weex preview src/xxx.vue`




