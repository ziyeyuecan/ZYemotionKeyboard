//
//  emojiKeyboardPopView.m
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardPopView.h"

#import "UIView+ZYFrame.h"

@interface emojiKeyboardPopView ()

@property (weak, nonatomic) IBOutlet emojiKeyboardEmotionView *emotionBtn;

@end

@implementation emojiKeyboardPopView

+(instancetype)popView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)showWithEmotionView:(emojiKeyboardEmotionView *)emotionView{
    
    if(emotionView == nil) return;
    
    self.emotionBtn.emotion = emotionView.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGFloat centerX = emotionView.ZY_centerX;
    CGFloat centerY = emotionView.ZY_centerY - self.ZY_height/2;
    
    CGPoint center = CGPointMake(centerX, centerY);
    center = [window convertPoint:center fromView:emotionView.superview];
    self.center = center;
    
}

-(void)dismiss{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"ZYemojiImage.bundle/emoticon_keyboard_magnifier"] drawInRect:rect];
}


@end











