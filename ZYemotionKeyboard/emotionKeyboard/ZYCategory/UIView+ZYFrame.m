//
//  UIView+Frame.m
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+ZYFrame.h"

@implementation UIView (ZYFrame)

- (void)setZY_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ZY_x
{
    return self.frame.origin.x;
}

- (void)setZY_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)ZY_y
{
    return self.frame.origin.y;
}

- (void)setZY_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


- (CGFloat)ZY_centerX
{
    return self.center.x;
}

- (void)setZY_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)ZY_centerY
{
    return self.center.y;
}

- (void)setZY_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ZY_width
{
    return self.frame.size.width;
}

- (void)setZY_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ZY_height
{
    return self.frame.size.height;
}

- (void)setZY_size:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)ZY_size
{
    return self.frame.size;
}

@end
