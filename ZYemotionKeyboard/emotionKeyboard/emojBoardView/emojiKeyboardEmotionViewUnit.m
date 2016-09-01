//
//  emojiKeyboardEmotionViewUnit.m
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardEmotionViewUnit.h"

#import "emojiKeyboardEmotionView.h"
#import "emojiKeyboardPopView.h"
#import "EmotionName.h"

#import "emojiKeyboardTool.h"

#import "ZYemojiKeyboardConst.h"
#import "UIView+ZYFrame.h"

@interface emojiKeyboardEmotionViewUnit ()

@property (nonatomic, strong) NSMutableArray *emotionViews;

@property (nonatomic, weak) UIButton *deleteButton;

@property (nonatomic, strong) emojiKeyboardPopView *emotionPopView;

@end

@implementation emojiKeyboardEmotionViewUnit

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}


-(emojiKeyboardPopView *)emotionPopView{
    if (_emotionPopView == nil) {
        emojiKeyboardPopView *view = [emojiKeyboardPopView popView];
        self.emotionPopView = view;
    }
    return _emotionPopView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"ZYemojiImage.bundle/compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"ZYemojiImage.bundle/compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] init];
        [gesture addTarget:self action:@selector(longGestureAction:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}


-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    //创建或使用旧的emojiKeyboardEmotionView
    for (int i = 0 ; i < emotions.count; i ++) {
        
        emojiKeyboardEmotionView *emotionView = nil;
        //如果旧的emojiKeyboardEmotionView不够用
        if (i >= self.emotionViews.count) {
            emotionView = [[emojiKeyboardEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionViewClick:) forControlEvents:UIControlEventTouchUpInside];
            emotionView.emotion = emotions[i];
            
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        }else{//如果使用旧的emojiKeyboardEmotionView够用,直接赋值覆盖掉旧的数据
            emotionView = self.emotionViews[i];
        }
        
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    //将多余的emojiKeyboardEmotionView隐藏
    for (int i  = (int)emotions.count; i < self.emotionViews.count; i++) {
        emojiKeyboardEmotionView *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

#pragma mark - 单击每个表情
-(void)emotionViewClick:(emojiKeyboardEmotionView *)emotionView{
    [self.emotionPopView showWithEmotionView:emotionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emotionPopView dismiss];
    });
    
    [self selecteEmotion:emotionView.emotion];
}

#pragma mark - 长按手势动作
-(void)longGestureAction:(UILongPressGestureRecognizer *)gesture{
    
    //捕获手指当前停留的位置
    CGPoint point = [gesture locationInView:gesture.view];
    
    //根据手指停留位置获取对应的emotionView
    emojiKeyboardEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {//手指松开了
        [self.emotionPopView dismiss];
        
        [self selecteEmotion:emotionView.emotion];
    }else{
        
        [self.emotionPopView showWithEmotionView:emotionView];
    }
}


#pragma mark -  根据触摸点返回对应的表情控件
- (emojiKeyboardEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block emojiKeyboardEmotionView *selectEmotionView = nil;
    
    [self.emotionViews enumerateObjectsUsingBlock:^(emojiKeyboardEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emotionView.frame, point) && emotionView.hidden == NO) {
            selectEmotionView = emotionView;
            // 停止遍历
            *stop = YES;
        }
    }];
    return selectEmotionView;
}

#pragma mark -  发出选中emoji的通知
- (void)selecteEmotion:(EmotionName *)emotionModel
{
    if (emotionModel == nil) return;
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:emotionDidSelectedNotification object:nil userInfo:@{selectedEmotion : emotionModel}];
}

#pragma mark -  点击删除按钮
-(void)deleteBtnClick:(UIButton *)btn{
    if(btn == nil) return;
    
    // 发出一个删除表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:emotionDidDeletedNotification object:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    CGFloat emotionViewW = (self.ZY_width - 2 * leftInset) / EmotionMaxCols;
    CGFloat emotionViewH = (self.ZY_height - topInset) / EmotionMaxRows;
    CGFloat emotionViewX = 0;
    CGFloat emotionViewY = 0;
    
    for (int i = 0; i < self.emotions.count; i ++) {
        
        emotionViewX = leftInset + (i % EmotionMaxCols)*emotionViewW;
        emotionViewY = topInset + (i / EmotionMaxCols)*emotionViewH;
        
        emojiKeyboardEmotionView *emotionView = self.emotionViews[i];
        
        emotionView.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
    }
    
    // 删除按钮
    self.deleteButton.ZY_width = emotionViewW;
    self.deleteButton.ZY_height = emotionViewH;
    self.deleteButton.ZY_x = self.ZY_width - leftInset - self.deleteButton.ZY_width;
    self.deleteButton.ZY_y = topInset + 2 * emotionViewH;
}


@end














