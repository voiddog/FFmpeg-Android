# 编译可以在 Android 上使用视频压缩的 FFmpeg

本项目的[文章链接](https://voiddog.github.io/2017/06/18/%E5%9C%A8Android%E4%B8%8A%E4%BD%BF%E7%94%A8FFmpeg%E5%8E%8B%E7%BC%A9%E8%A7%86%E9%A2%91/)

## 2017-06-23 更新
* 添加 MediaCodec 硬解码支持（然而并没有块多少，只是cpu使用率下降了）
* 添加线程支持
> [文章链接](https://voiddog.github.io/2017/06/24/%E7%BB%99FFmpeg%E5%8A%A0%E4%B8%8AMediaCodec%E5%92%8C%E7%BA%BF%E7%A8%8B%E6%94%AF%E6%8C%81/)

## 2017-06-24 添加线程支持，添加硬解码支持
* 修改原先 `exit_program` 的 `return` 方式为 `pthread_exit`，妈妈再也不用担心异常了
* 添加调试开关，添加日志输出
* 添加 h264 的硬解码支持

## 快速启动 demo

介于许多同学都向我反馈 demo 编译过不了，这里介绍怎么编译启动 demo

### 一、克隆代码

首先克隆项目到本地
```bash
git clone https://github.com/voiddog/FFmpeg-Android.git
```

项目中的 ffmpeg 和 x264 目录默认克隆下来是 **空** 的
> 了解 git 子模块的可以在 clone 的时候带上 --recurse-submodules 参数，或者之后自己初始化子模块，如果只是想跑 demo，不自己编译 ffmpeg 的可以忽略

### 二、修改 CMakeLists.txt

克隆下来后用 `Android Studio` 打开 `android` 目录，然后需要修改下 `CMakeLists.txt` 文件
> 许多同学这一步都没做，因为 `CMakeLists.txt` 文件中的有的地址是我本机的地址，不改的话肯定会报 not found

之前项目的 demo 在编译的时候，需要用到 ffmpeg 文件夹中的一些头文件，尤其是 `config.h`，这个文件是运行了 `config` 之后生成的，不是包含在原先源码里面的，因为编译只需要头文件，所以我写了个脚本，把 ffmpeg 源码内的头文件过滤出来放到 demo 中了（瞬间大了 10MB...）

头文件拷过去后，就可以切断 demo 与 ffmpeg 源码之间的依赖了，所以 `CMakeLists.txt` 只需要改一个地方

···
set(FFMPEG_LIB_DIR /Users/qigengxin/Documents/Github/FFmpegAndroid/android/ffmpeg/src/main/jniLibs/armeabi-v7a)
···

这个地址是 ffmpeg 动态库的地址，改成自己对应的地址就行了（本来想试相对路径的，可惜这里不能用相对路径）

至此，demo 就可以编译过了

## 修改 demo

demo 中的测试代码很简单，路径我直接代码写死了，具体看看 `MainActivity` 就知道了。所以跑 demo 的时候，把 `MainActivity` 中的视频地址改为自己的地址，日志信息看 `logcat`

## 想要编译 ffmpeg 和 x264 的

### 一、克隆代码
```bash
git clone https://github.com/voiddog/FFmpeg-Android.git --recurse-submodules
```
或者
```bash
git clone https://github.com/voiddog/FFmpeg-Android.git
git submodule init
git submodule update
```

### 二、修改环境变量
打开 `build/setting.sh` 文件
修改内部的路径为自己的路径
> 目前开启了硬编码，所以只支持 armv7a

### 三、编译
x264
```bash
cd build
./build_x264.sh
```
ffmpeg
```bash
./build_ffmpeg.sh
```