//
//  PlaySoundAndMusicTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "PlaySoundAndMusicTest.h"

@interface PlaySoundAndMusicTest ()

@end

@implementation PlaySoundAndMusicTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"播放音乐" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [AudioTool playMusicWithFileName:@"music.mp3"];
    }];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 setTitle:@"暂停音乐" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(210, 100, 100, 30);
    [button2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [AudioTool pauseMusicWithFileName:@"music.mp3"];
    }];
    [self.view addSubview:button2];
    
    
    
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle:@"播放音效" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 160, 100, 30);
    [button1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [AudioTool playAudioWithFileName:@"sound.m4a"];
    }];
    [self.view addSubview:button1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
