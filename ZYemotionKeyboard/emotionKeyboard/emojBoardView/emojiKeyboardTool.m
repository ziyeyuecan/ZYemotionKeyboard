//
//  emojiKeyboardTool.m
//  YCSideslip
//
//  Created by saber on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiKeyboardTool.h"
#import "MJExtension.h"
#import "ZYemojiKeyboardConst.h"

@interface emojiKeyboardTool ()

@end

@implementation emojiKeyboardTool

/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;

+(NSString *)getDocumentsPathWithName:(NSString *)fileName{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    
    return [path stringByAppendingPathComponent:fileName];
}

+(NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:defaultEmotionPlistPath ofType:nil];
        _defaultEmotions = [EmotionName objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:defaultEmotionPath];
    }
    
    return _defaultEmotions;
    
}

+(NSArray *)emojiEmotions{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:emojiEmotionPlistPath ofType:nil];
        
        _emojiEmotions = [EmotionName objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:emojiEmotionPath];
    }
    return _emojiEmotions;
}

+(NSArray *)lxhEmotions{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:lxhEmotionPlistPath ofType:nil];
        _lxhEmotions = [EmotionName objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:lxhEmotionPath];
    }
    return _lxhEmotions;
}

+(UIImage *)emotionWithString:(NSString *)string{
    
    __block UIImage *emotion = nil;
    
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(EmotionName * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([string isEqualToString:obj.chs]) {
            
            emotion = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",obj.directory,obj.png]];
            
            *stop = YES;
        }
    }];
    
    if(emotion) return emotion;
    
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(EmotionName * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([string isEqualToString:obj.chs]) {
            emotion = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",obj.directory,obj.png]];
            *stop = YES;
        }
    }];
    
    return emotion;
}

@end










