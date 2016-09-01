//
//  ZYemojiKeyboardConst.m
//  表情键盘
//
//  Created by saber on 16/8/27.
//  Copyright © 2016年 futaihua. All rights reserved.
//

//表情选中的通知

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//表情选中的通知
NSString * const emotionDidSelectedNotification = @"EmotionDidSelectedNotification";

//点击删除按钮的通知
NSString * const emotionDidDeletedNotification = @"EmotionDidDeletedNotification";

//通知里面取出表情用的key
NSString * const selectedEmotion = @"SelectedEmotion";

//---------------------------增删表情时修改----------------------------
// 存放 默认 表情的路径
NSString * const defaultEmotionPath = @"EmotionIcons/default";
// 存放 默认 表情info.plist的路径
NSString * const defaultEmotionPlistPath = @"EmotionIcons/default/info.plist";


// 存放 emoji 表情的路径
NSString * const emojiEmotionPath = @"EmotionIcons/emoji";
// 存放 emoji 表情info.plist的路径
NSString * const emojiEmotionPlistPath = @"EmotionIcons/emoji/info.plist";


// 存放 浪小花 表情的路径
NSString * const lxhEmotionPath = @"EmotionIcons/lxh";
// 存放 浪小花 表情info.plist的路径
NSString * const lxhEmotionPlistPath = @"EmotionIcons/lxh/info.plist";
















