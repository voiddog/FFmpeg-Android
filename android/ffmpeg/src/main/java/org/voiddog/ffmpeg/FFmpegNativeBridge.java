package org.voiddog.ffmpeg;

/**
 * FFmpeg native 层的 bridge
 *
 * @author qigengxin
 * @since 2017-06-17 14:45
 */


public class FFmpegNativeBridge {

    static {
        System.loadLibrary("ffmpeg-lib");
    }

    public static int runCommand(String[] command){
        int ret;
        synchronized (FFmpegNativeBridge.class){
            // 不允许多线程访问
            ret = innerRunCommand(command);
        }
        return ret;
    }


    /**
     * 设置是否处于调试状态
     * @param debug
     */
    public static native void setDebug(boolean debug);

    /**
     * 执行指令
     * @param command
     * @return 命令返回结果
     */
    private static native int innerRunCommand(String[] command);
}
