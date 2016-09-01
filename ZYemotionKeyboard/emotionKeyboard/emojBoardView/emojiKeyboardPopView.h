//
//  emojiKeyboardPopView.h
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "emojiKeyboardEmotionView.h"

@interface emojiKeyboardPopView : UIView

+ (instancetype)popView;

-(void)showWithEmotionView:(emojiKeyboardEmotionView *)emotionView;

- (void)dismiss;

@end
