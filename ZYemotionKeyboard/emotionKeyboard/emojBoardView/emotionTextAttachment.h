//
//  emotionTextAttachment.h
//  YCSideslip
//
//  Created by saber on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionName.h"

@interface emotionTextAttachment : NSTextAttachment

@property(nonatomic,strong)EmotionName *emotionModel;

@end
