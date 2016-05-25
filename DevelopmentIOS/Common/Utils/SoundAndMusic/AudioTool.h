//
//  AudioTool.h
//  本地百度音乐
//
//  Created by 刘硕 on 15/7/29.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  播放音效
 
 [AudioTool playAudioWithFileName:@"sound.m4a"];
 
 播放音乐
 [AudioTool pauseMusicWithFileName:@"music.mp3"];
 *
 *  @return <#return value description#>
 */

/**
 *  播放音效
 *
 *  @param filename <#filename description#>
 */


@interface AudioTool : NSObject
+(void)playAudioWithFileName:(NSString *)filename;
/**
 *  销毁音效
 *
 *  @param filename <#filename description#>
 */
+(void)disposeAudioWithFileName:(NSString *)filename;

/**
 *  播放音乐
 *
 *  @param filename <#filename description#>
 *
 *  @return <#return value description#>
 */
+(AVAudioPlayer *)playMusicWithFileName:(NSString *)filename;
/**
 *  暂停音乐播放
 *
 *  @param filename <#filename description#>
 */
+(void)pauseMusicWithFileName:(NSString *)filename;

/**
 *  停止音乐播放
 *
 *  @param filename <#filename description#>
 */
+(void)stopMusicWithFileName:(NSString *)filename;

@end
