![](https://raw.githubusercontent.com/swiftdo/pics/main/soundlogo2.png)

# 觅音

项目由 [mpflutter2](https://github.com/mpflutter/mpflutter) 构建。

```shell
$ fvm use 3.16.7
$ fvm flutter packages upgrade
$ fvm flutter packages get 
$ fvm dart scripts/build_wechat.dart
```

build/wechat 目录下就是最终产物.

觅音已上线，欢迎下载体验!

<img src="https://raw.githubusercontent.com/swiftdo/pics/main/15121712050137_.pic.jpg" alt="Your Image" width="300" >

## 调试

1. 编译出产物

    ```shell
    $ fvm dart scripts/build_wechat.dart --devmode
    ```

2. 将产物用 wechat Devtools 打开。
3. 在小程序后台配置域名白名单。
4. 运行项目为桌面项目。
5. 需要在小程序后台配置剪切板使用声明。

## 待实现

* [ ] 定时功能
* [ ] 编辑功能
* [x] 问题反馈
* [x] 播放时保持屏幕常亮，否者息屏会自动暂停播放
* [ ] 自定义的混音分享功能
* [ ] 素材方面
  * [ ] 搜集更多的免费音频
  * [ ] 是否要增加封面功能？待考虑
  * [ ] svg 风格不一，需要对一些图片进行替换


## Stargazers over time
[![Stargazers over time](https://starchart.cc/swiftdo/sound.svg?variant=adaptive)](https://starchart.cc/swiftdo/sound)
