# InterviewHome  ![](https://img.shields.io/badge/Weex--Toolkit-2.0.0-orange.svg)![](https://img.shields.io/badge/WeexSDK-1.8.0-blue.svg)![](https://img.shields.io/badge/node-v10.15.3-yellowgreen.svg)![](https://img.shields.io/badge/npm-6.4.1-green.svg)![](https://img.shields.io/badge/license-MIT-yellow.svg)

面试之家是一款用`Weex`开发的多页面`App`，题库等内容仅限于交流学习使用，不可用于商业项目。

## 延伸
* [Weex重写WXNavigatorHandle](https://www.jianshu.com/p/ba8494d15dba)
* [Weex自定义Module](https://www.jianshu.com/p/37b884515125)
* [Weex邂逅FMDB](https://www.jianshu.com/p/11be9b4d27f0)
* [Weex采坑心得](https://www.jianshu.com/p/7ee2c7c599f8)


## 附小程序
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

本项目在platforms下已经有`iOS`项目，无须执行 `weex add iOS`，在`iOS`下如果编译报错修改

``` bash
File -> Workspace Settings -> Build System 为 Legacy Build Sysyem
```

### 常用命令

编译文件

`weex compile src/xxxx.vue dest -m`

预览文件

`weex preview src/xxx.vue`







