//
//  emojiKeyboardScrollView.m
//  YCSideslip
//
//  Created by saber on 16/5/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardEmotionList.h"

#import "emojiKeyboardEmotionViewUnit.h"

#import "ZYemojiKeyboardConst.h"
#import "UIView+ZYFrame.h"


@interface emojiKeyboardEmotionList ()<UIScrollViewDelegate>


@property(nonatomic,weak)UIScrollView *emotionsScrollView;

@property(nonatomic,weak)UIPageControl *pageControl;

@property(nonatomic,strong)NSMutableArray *emotionViews;


@end

@implementation emojiKeyboardEmotionList


-(NSMutableArray *)emotionViews{
    if (_emotionViews == nil) {
        _emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //创建滚动视图 用来放一页页的表情
        UIScrollView *emotionsScrollView = [[UIScrollView alloc] init];
        emotionsScrollView.showsHorizontalScrollIndicator = NO;
        emotionsScrollView.showsVerticalScrollIndicator = NO;
        emotionsScrollView.backgroundColor = [UIColor whiteColor];
        emotionsScrollView.pagingEnabled = YES;
        emotionsScrollView.delegate = self;
        [self addSubview:emotionsScrollView];
        self.emotionsScrollView = emotionsScrollView;
        
        //创建分页控制器
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"ZYemojiImage.bundle/compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"ZYemojiImage.bundle/compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    // 设置总页数
    self.pageControl.numberOfPages = (emotions.count + EmotionMaxCountPerPage - 1) / EmotionMaxCountPerPage;
    self.emotionsScrollView.contentSize = CGSizeMake(ZYScreenWidth *self.pageControl.numberOfPages, 0);
    
    //创建或使用旧的emojiKeyboardEmotionView
    for (int i = 0; i < self.pageControl.numberOfPages; i ++) {
        emojiKeyboardEmotionViewUnit *emotionViewUnit = nil;
        
        //如果使用旧的emojiKeyboardEmotionViewUnit不够用 就创建新的
        if (i >= self.emotionViews.count) {
            emotionViewUnit = [[emojiKeyboardEmotionViewUnit alloc] init];
            emotionViewUnit.backgroundColor = [UIColor whiteColor];
            
            [self.emotionViews addObject:emotionViewUnit];
            [self.emotionsScrollView addSubview:emotionViewUnit];
            
        }else{//如果使用旧的emojiKeyboardEmotionViewUnit够用 直接使用旧的
            emotionViewUnit = self.emotionViews[i];
        }
        
        NSUInteger loc = i * EmotionMaxCountPerPage;
        NSUInteger len = EmotionMaxCountPerPage;
        if (loc + len > emotions.count) {
            len = emotions.count - loc;
        }
        
        emotionViewUnit.hidden = NO;
        NSRange range = NSMakeRange(loc, len);
        NSArray *currentEmotions = [emotions subarrayWithRange:range];
        emotionViewUnit.emotions = currentEmotions;
    }
    
    // 隐藏后面的不需要用到的emojiKeyboardEmotionViewUnit
    for (int i = (int)self.pageControl.numberOfPages; i < self.emotionViews.count; i++) {
        emojiKeyboardEmotionViewUnit *emotionViewUnit = self.emotionViews[i];
        emotionViewUnit.hidden = YES;
    }
    
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.emotionsScrollView.contentOffset = CGPointZero;
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.pageControl sizeToFit];
    self.pageControl.ZY_centerX = self.ZY_width / 2;
    self.pageControl.ZY_centerY = self.ZY_height - (self.pageControl.ZY_height/2);
    
    self.emotionsScrollView.ZY_size = CGSizeMake(ZYScreenWidth, self.ZY_height - self.pageControl.ZY_height);
    self.emotionsScrollView.ZY_x = 0;
    self.emotionsScrollView.ZY_y = 0;
    
    int count = (int)self.pageControl.numberOfPages;
    CGFloat emotionViewW = self.emotionsScrollView.ZY_width;
    CGFloat emotionViewH = self.emotionsScrollView.ZY_height;
    
    for (int i = 0; i < count; i++) {
        UIView *gridView = self.emotionViews[i];
        gridView.ZY_width = emotionViewW;
        gridView.ZY_height = emotionViewH;
        gridView.ZY_x = i * emotionViewW;
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.ZY_width + 0.5);
}

@end









