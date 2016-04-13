//
//  AudioTool.m
//  本地百度音乐
//
//  Created by 刘硕 on 15/7/29.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import "AudioTool.h"

@implementation AudioTool

static NSMutableDictionary *_soundIDs;
static NSMutableDictionary *_players;


+(void)initialize
{
    AVAudioSession *session = [[AVAudioSession alloc] init];
    //设置回话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //激活会话
    [session setActive:YES error:nil];
}

+(NSMutableDictionary *)players
{
    if (!_players) {
        _players = [NSMutableDictionary dictionary];
    }
    return _players;
}
+(NSMutableDictionary*)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
+(void)playAudioWithFileName:(NSString *)filename{
    // 判断文件名是否为空
    if (filename == nil) {
        return;
    }
    SystemSoundID soundID = [[self soundIDs][filename] unsignedIntValue];
    
    if(!soundID){
        NSURL *u = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if ( !u ) {
            return ;
        }
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(u), &soundID);
        
        [self soundIDs][filename] = @(soundID);
    }
    
    //播放
    AudioServicesPlaySystemSound(soundID);
}

+(void)disposeAudioWithFileName:(NSString *)filename{
    //判断文件名存在
    if(filename == nil){
        return ;
    }
    //从字典中取出音效ID
    SystemSoundID sound = [[self soundIDs][filename] unsignedIntValue];
    if (sound) {
        //销毁音效ID
        AudioServicesDisposeSystemSoundID(sound);
        // 移除销毁的音效ID
        [[self soundIDs] removeObjectForKey:filename];
    }
}



+(AVAudioPlayer *)playMusicWithFileName:(NSString *)filename{
    
    //判断文件名是否存在
    if(filename == nil){
        return nil ;
    }
    //从字典中取出
    AVAudioPlayer *player = [self players][filename];
    //判断播放器是否空
    if (!player) {
        //根据文件名加载音效的URL
        NSURL *u = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        // 判断url是否
        if (u == nil) {
            return nil;
        }
        // 创建播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:u error:nil];
        
        // 准备播放
        if ([player prepareToPlay] == NO) {
            return nil;
        }
        // 将播放器加入到字典
        [self players][filename] = player;
    }
    //播放音乐
    if ( !player.playing) {
        [player play];
    }
    
    return player;
    
    
    
}

+(void)pauseMusicWithFileName:(NSString *)filename{
    
    if (filename == nil ){
        return;
    }
    AVAudioPlayer *player = [self players][filename];
    
    if (player) {
        
        if (player.isPlaying) {
            [player pause];
        }
    }
}

+(void)stopMusicWithFileName:(NSString *)filename{
    
    if ( filename == nil ) {
        return;
    }
    AVAudioPlayer *player = [self players][filename];
    
    if (player) {
        [player stop];
        [[self players] removeObjectForKey:filename];
    }
}


@end
