//
//  EmojiKeyboard.m
//  YCSideslip
//
//  Created by saber on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EmojiKeyboard.h"

#import "emojiKeyboardToolBar.h"
#import "emojiKeyboardEmotionList.h"

#import "EmotionName.h"
#import "emojiKeyboardTool.h"

#import "ZYemojiKeyboardConst.h"
#import "UIView+ZYFrame.h"

@interface emojiKeyboard ()<EmotionToolbarDelegate>

//底部的切换表情的toolBar
@property(nonatomic,weak)emojiKeyboardToolBar *toolBar;

//存放表情的View
@property(nonatomic,weak)emojiKeyboardEmotionList *emotionList;

@end


@implementation emojiKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        emojiKeyboardEmotionList *emotionList  = [[emojiKeyboardEmotionList alloc] init];
        [self addSubview:emotionList];
        self.emotionList = emotionList;
        
        emojiKeyboardToolBar *toolBar = [[emojiKeyboardToolBar alloc] init];
        toolBar.delegate = self;
        [self addSubview:toolBar];
        self.toolBar = toolBar;
        
    }
    return self;
}

-(void)emotionToolbar:(emojiKeyboardToolBar *)toolbar didSelectedButton:(EmotionType)emotionType{
    switch (emotionType) {
        case EmotionTypeDefault:// 默认
            self.emotionList.emotions = [emojiKeyboardTool defaultEmotions];
            break;
            
        case EmotionTypeEmoji: // Emoji
            self.emotionList.emotions = [emojiKeyboardTool emojiEmotions];
            break;
            
        case EmotionTypeLxh: // 浪小花
            self.emotionList.emotions = [emojiKeyboardTool lxhEmotions];
            break;
        default:
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.toolBar.ZY_size = CGSizeMake(ZYScreenWidth, 35);
    self.toolBar.ZY_x = 0;
    self.toolBar.ZY_y = self.ZY_height - self.toolBar.ZY_height;
    
    self.emotionList.ZY_size = CGSizeMake(ZYScreenWidth, self.ZY_height - self.toolBar.ZY_height);
    self.ZY_x = 0;
    self.ZY_y = 0;
    
}
@end









