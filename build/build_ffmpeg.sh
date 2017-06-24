#!/bin/bash

# 导入环境变量
. setting.sh

# 输出，调试用
echo "use toolchain: $TOOLCHAIN"
echo "use system root: $SYSROOT"

# x264库所在的位置，ffmpeg 需要链接 x264
LIB_DIR=$(pwd)/lib;

# ffmpeg编译输出前缀
PREFIX=$LIB_DIR/ffmpeg/$CPU
echo "out dir: $PREFIX"
# x264的头文件地址
INC="$LIB_DIR/x264/$CPU/include"
# x264的静态库地址
LIB="$LIB_DIR/x264/$CPU/lib"
# 输出调试
echo "include dir: $INC"
echo "lib dir: $LIB"
# 编译优化参数
FF_EXTRA_CFLAGS="-march=$CPU -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb" 
# 编译优化参数，-I$INC 指定 x264 头文件路径
FF_CFLAGS="-O3 -Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID  \
-I$INC"

cd ../ffmpeg
function build_arm
{
./configure \
    --enable-shared \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-ffserver \
    --disable-symver \
    --disable-encoders \
    --enable-jni \
    --enable-mediacodec \
    --enable-libx264 \
    --enable-encoder=libx264 \
    --enable-encoder=aac \
    --enable-encoder=mjpeg \
    --enable-encoder=png \
    --disable-decoders \
    --enable-decoder=aac \
    --enable-decoder=aac_latm \
    --enable-decoder=mjpeg \
    --enable-decoder=png \
    --enable-decoder=h264_mediacodec \
    --enable-decoder=mpeg4_mediacodec \
    --disable-demuxers \
    --enable-demuxer=image2 \
    --enable-demuxer=h264 \
    --enable-demuxer=aac \
    --enable-demuxer=avi \
    --enable-demuxer=mpc \
    --enable-demuxer=mov \
    --disable-parsers \
    --enable-parser=aac \
    --enable-parser=ac3 \
    --enable-parser=h264 \
    --disable-muxers \
    --enable-muxer=h264 \
    --enable-muxer=aac \
    --enable-muxer=avi \
    --enable-muxer=mov \
    --enable-muxer=mp3 \
    --enable-muxer=mp4 \
    --enable-avresample \
    --enable-small \
    --enable-avfilter \
    --enable-gpl \
    --enable-yasm \
    --prefix=$PREFIX \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --target-os=android \
    --arch=arm \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --extra-cflags="$FF_CFLAGS $FF_EXTRA_CFLAGS" \
    --extra-ldflags="-Wl,-L$LIB"
make clean
make -j16
make install
}

build_arm