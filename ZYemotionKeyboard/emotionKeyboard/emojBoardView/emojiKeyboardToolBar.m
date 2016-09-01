//
//  emojiKeyboardToolBar.m
//  YCSideslip
//
//  Created by saber on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardToolBar.h"
#import "UIView+ZYFrame.h"

@interface emojiKeyboardToolBar ()

/** 记录当前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;

/** 默认选中的按钮 */
@property (nonatomic, strong) UIButton *defaultSelectedBtn;


@end


@implementation emojiKeyboardToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加3个按钮
        [self setupButton:@"默认" tag:EmotionTypeDefault];
        [self setupButton:@"Emoji" tag:EmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:EmotionTypeLxh];
    }
    return self;
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(EmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    
    [button setBackgroundColor:[UIColor colorWithRed:197/255.0 green:201/255.0 blue:207/255.0 alpha:1.0]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    if (tag == 0) {
        self.defaultSelectedBtn = button;
    }
    
    return button;
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    
    // 1.控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:(EmotionType)button.tag];
    }
}

- (void)setDelegate:(id<EmotionToolbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中“默认”按钮
    [self buttonClick:_defaultSelectedBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置工具条按钮的frame
    CGFloat buttonW = self.ZY_width / 3;
    CGFloat buttonH = self.ZY_height;
    for (int i = 0; i < 3; i++) {
        UIButton *button = self.subviews[i];
        button.ZY_width = buttonW;
        button.ZY_height = buttonH;
        button.ZY_x = i * buttonW;
    }
}

@end







