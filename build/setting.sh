# ndk 环境
NDK=$HOME/Library/Android/sdk/ndk-bundle
SYSROOT=$NDK/platforms/android-14/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
# cpu 架构平台，若要编译 x86 则指定 x86
CPU=armv7-a