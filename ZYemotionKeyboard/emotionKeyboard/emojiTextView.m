//
//  sendWeiboTextView.m
//  YCSideslip
//
//  Created by saber on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "emojiTextView.h"
#import "emotionTextAttachment.h"

@interface emojiTextView ()

@property(nonatomic,weak)UILabel *placeholderLabel;

@end

@implementation emojiTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpOrigin];
    }
    return self;
}

-(void)awakeFromNib{
    [self setUpOrigin];
}

-(void)setUpOrigin{
    self.font = [UIFont systemFontOfSize:16];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(my_textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - 监听文字改变
- (void)my_textViewDidChange:(NSNotification *)note
{
    self.placeholderLabel.hidden = self.hasText;
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 创建一个placeholder Label
-(UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor grayColor];
        [self addSubview:lab];
        
        _placeholderLabel = lab;
    }
    return _placeholderLabel;
}

#pragma mark - 为placeholderLabel赋值
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 是否显示placeholderLabel
-(void)setHidePlaceholder:(BOOL)hidePlaceholder{
    _hidePlaceholder = hidePlaceholder;
    
    self.placeholderLabel.hidden = _hidePlaceholder;
}

#pragma mark - 重写该方法 以保证通过代码改变attributedText时 会隐藏placeholderLabel
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - 为自己插入emotion
-(void)appendWithEmotion:(EmotionName *)emotion{
    
    //如果表情是emoji 直接插入就可以了
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else{//如果是图片表情 就要复杂点
        
        //记录插入前文本框的内容
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        //创建一个包含NSTextAttachment的富文本，而NSTextAttachment里面包含图片
        emotionTextAttachment *attachment = [[emotionTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
        attachment.emotionModel = emotion;
        attachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        //记录光标的位置
        int selectLocation = (int)self.selectedRange.location;
        
        //将包含NSTextAttachment的富文本，插入进去
        [string insertAttributedString:attachString atIndex:selectLocation];
        [string addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, string.length)];
        
        self.attributedText = string;
        
        //恢复光标位置
        self.selectedRange = NSMakeRange(selectLocation+1, 0);
    }
}

#pragma mark - 将带有表情的一段文字 变为 纯文本文字
-(NSString *)sendHttpString{
    
    NSMutableString *totalString = [[NSMutableString alloc] init];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        emotionTextAttachment *attachment = attrs[@"NSAttachment"];
        
        if (attachment) {
            [totalString appendString:attachment.emotionModel.chs];
        }else{
            NSString *subString = [self.attributedText attributedSubstringFromRange:range].string;
            [totalString appendString:subString];
        }
    }];
    
    return totalString;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.x = 5;
    frame.origin.y = 8;
    
    self.placeholderLabel.frame = frame;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



















