[![Project Icon](https://raw.githubusercontent.com/swiftdo/pics/main/soundlog.png)](OHeroJ/sound.git)

# 觅音

```shell
$ fvm use 3.16.7
$ fvm flutter packages upgrade
$ fvm flutter packages get 
$ fvm dart scripts/build_wechat.dart
```

build/wechat 目录下就是最终产物.

觅音已上线，欢迎下载体验!

<img src="https://raw.githubusercontent.com/swiftdo/pics/main/15121712050137_.pic.jpg" alt="Your Image" width="300" height="200">

## 调试

1. 编译出产物

    ```shell
    $ fvm dart scripts/build_wechat.dart --devmode
    ```

2. 将产物用 wechat Devtools 打开。
3. 在小程序后台配置域名白名单。
4. 运行项目为桌面项目。
5. 需要再小程序后台配置切板使用声明。

## 待实现

* [ ] 定时功能
* [ ] 编辑功能
* [ ] 跳转到客服
