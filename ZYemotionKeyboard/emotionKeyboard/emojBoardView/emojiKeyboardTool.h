//
//  emojiKeyboardTool.h
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EmotionName.h"

@interface emojiKeyboardTool : NSObject

/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;

/**
 *  根据string返回一个image表情
 */
+(UIImage *)emotionWithString:(NSString *)string;


@end













