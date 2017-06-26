# 编译可以在 Android 上使用视频压缩的 FFmpeg

> 注意：demo 的 build 文件夹中有编译好的 so 库，可以直接用，跑 demo 的时候要注意更新 ffmpeg 和 libx264 的子模块，默认克隆下来里面应该是空的, 还有就是把 CMakeList.txt 内的地址环境变量改为自己的路径。demo 中压缩视频的命令需要自己修改，就一个 MainActivity，没几句话

本项目的[文章链接](https://voiddog.github.io/2017/06/18/%E5%9C%A8Android%E4%B8%8A%E4%BD%BF%E7%94%A8FFmpeg%E5%8E%8B%E7%BC%A9%E8%A7%86%E9%A2%91/)

## 2017-06-23 更新
* 添加 MediaCodec 硬解码支持（然而并没有块多少，只是cpu使用率下降了）
* 添加线程支持
> [文章链接](https://voiddog.github.io/2017/06/24/%E7%BB%99FFmpeg%E5%8A%A0%E4%B8%8AMediaCodec%E5%92%8C%E7%BA%BF%E7%A8%8B%E6%94%AF%E6%8C%81/)
