#!/bin/bash

# 引入需要的环境变量
. setting.sh

# 输出下看看对不对，可以去掉，这里调试用
echo "use toolchain: $TOOLCHAIN"
echo "use system root: $SYSROOT"

# 输出文件的前缀，也就是指定最后静态库输出到那里
PREFIX=$(pwd)/lib/x264/$CPU
# 优化参数
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
ADDI_CFLAGS=""
ADDI_LDFLAGS=""

# 因为当前目录在 build 目录，需要切换到 x264 去执行 config
cd ../x264
function build_x264
{
./configure \
    --prefix=$PREFIX \
    --disable-shared \
    --disable-asm \
    --enable-static \
    --enable-pic \
    --enable-strip \
    --host=arm-linux-androideabi \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --sysroot=$SYSROOT
    --extra-cflags="-Os -fpic $ADDI_CFLAGS $OPTIMIZE_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS" \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make -j4
make install
}

# 执行编译指令
build_x264