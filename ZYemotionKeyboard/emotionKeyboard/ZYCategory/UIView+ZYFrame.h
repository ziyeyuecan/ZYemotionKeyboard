//
//  UIView+Frame.h
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYFrame)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
@property (nonatomic, assign) CGFloat ZY_x;
@property (nonatomic, assign) CGFloat ZY_y;
@property (nonatomic, assign) CGFloat ZY_centerX;
@property (nonatomic, assign) CGFloat ZY_centerY;
@property (nonatomic, assign) CGFloat ZY_width;
@property (nonatomic, assign) CGFloat ZY_height;
@property (nonatomic, assign) CGSize ZY_size;


@end
