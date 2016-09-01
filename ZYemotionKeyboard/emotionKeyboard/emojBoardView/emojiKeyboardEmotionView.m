//
//  emojiKeyboardEmotionView.m
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardEmotionView.h"

@interface emojiKeyboardEmotionView ()

@end

@implementation emojiKeyboardEmotionView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

-(void)setEmotion:(EmotionName *)emotion{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        // emotion.code == 0x1f603 --> \u54367
        // emoji的大小取决于字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }else{
        NSString *iconPath = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        [self setImage:[UIImage imageNamed:iconPath] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
