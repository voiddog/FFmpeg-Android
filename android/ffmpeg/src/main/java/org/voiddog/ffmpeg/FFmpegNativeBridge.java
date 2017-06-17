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

    /**
     * 执行指令
     * @param command
     * @return 命令返回结果
     */
    public static native int runCommand(String[] command);
}
