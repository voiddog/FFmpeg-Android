//
// Created by 戚耿鑫 on 2017/6/17.
//

#include <jni.h>
#include "ffmpeg.h"

JNIEXPORT jint JNICALL
Java_org_voiddog_ffmpeg_FFmpegNativeBridge_runCommand(JNIEnv *env, jclass type,
                                                      jobjectArray command) {
    int argc = (*env)->GetArrayLength(env, command);
    char *argv[argc];
    jstring jsArray[argc];
    int i;
    for (i = 0; i < argc; i++) {
        jsArray[i] = (jstring) (*env)->GetObjectArrayElement(env, command, i);
        argv[i] = (char *) (*env)->GetStringUTFChars(env, jsArray[i], 0);
    }
    int ret = run_ffmpeg_command(argc,argv);
    for (i = 0; i < argc; ++i) {
        (*env)->ReleaseStringUTFChars(env, jsArray[i], argv[i]);
    }
    return ret;
}