//
//  HMEmotion.m
//  黑马微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "EmotionName.h"
#import "NSString+ZYEmoji.h"

#import "emojiKeyboardTool.h"

@interface EmotionName ()

@end

@implementation EmotionName

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

-(void)setCode:(NSString *)code{
    _code = code;
    
    self.emoji = [NSString emojiWithStringCode:code];
}



@end










