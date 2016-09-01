//
//  emojiKeyboardToolBar.h
//  YCSideslip
//
//  Created by saber on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class emojiKeyboardToolBar;

typedef enum {
    EmotionTypeDefault, // 默认
    EmotionTypeEmoji, // Emoji
    EmotionTypeLxh // 浪小花
} EmotionType;

@protocol EmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(emojiKeyboardToolBar *)toolbar didSelectedButton:(EmotionType)emotionType;

@end

@interface emojiKeyboardToolBar : UIView

@property (nonatomic, weak) id<EmotionToolbarDelegate> delegate;

@end
