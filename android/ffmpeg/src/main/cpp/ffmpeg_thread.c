//
// Created by 戚耿鑫 on 2017/6/24.
//

#include "ffmpeg_thread.h"

int ffmpeg_argc;
int ffmpeg_exec_ret;
char **ffmpeg_argv;

void *run_thread(void *arg){
    ffmpeg_exec_ret = run_ffmpeg_command(ffmpeg_argc, ffmpeg_argv);
}

int ffmpeg_thread_run_command(int argc, char **argv){
    ffmpeg_argc = argc;
    ffmpeg_argv = argv;
    ffmpeg_exec_ret = -1;

    pthread_t thread_id;
    int thread_ret = pthread_create(&thread_id, NULL, run_thread, NULL);
    if (thread_ret){
        av_log(NULL, AV_LOG_ERROR, "can not create thread");
        return 1;
    }

    thread_ret = pthread_join(thread_id, NULL);
    if (thread_ret){
        av_log(NULL, AV_LOG_ERROR, "thread join error");
        return 1;
    }

    return ffmpeg_exec_ret;
}

void ffmpeg_thread_exit(int ret){
    ffmpeg_exec_ret = ret;
    pthread_exit(NULL);
}
