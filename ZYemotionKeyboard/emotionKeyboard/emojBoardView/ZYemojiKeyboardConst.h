//
//  ZYemojiKeyboardConst.h
//  表情键盘
//
//  Created by saber on 16/8/27.
//  Copyright © 2016年 futaihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//获取设备的物理高度
#define ZYScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ZYScreenWidth [UIScreen mainScreen].bounds.size.width

// 表情的最大行数
#define EmotionMaxRows 3
// 表情的最大列数
#define EmotionMaxCols 7
// 每页最多显示多少个表情
#define EmotionMaxCountPerPage (EmotionMaxRows * EmotionMaxCols - 1)


//表情选中的通知
UIKIT_EXTERN NSString * const emotionDidSelectedNotification;

// 点击删除按钮的通知
UIKIT_EXTERN NSString * const emotionDidDeletedNotification;

// 通知里面取出表情用的key
UIKIT_EXTERN NSString * const selectedEmotion;

//---------------------------增删表情时修改----------------------------
// 存放 默认 表情的路径
UIKIT_EXTERN NSString * const defaultEmotionPath;
// 存放 默认 表情info.plist的路径
UIKIT_EXTERN NSString * const defaultEmotionPlistPath;


// 存放 emoji 表情的路径
UIKIT_EXTERN NSString * const emojiEmotionPath;
// 存放 emoji 表情info.plist的路径
UIKIT_EXTERN NSString * const emojiEmotionPlistPath;


// 存放 浪小花 表情的路径
UIKIT_EXTERN NSString * const lxhEmotionPath;
// 存放 浪小花 表情info.plist的路径
UIKIT_EXTERN NSString * const lxhEmotionPlistPath;








