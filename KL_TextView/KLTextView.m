//
//  KLTextView.m
//  KL_TextView
//
//  Created by 赵凯乐 on 2018/3/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLTextView.h"
#import <UIKit/NSTextContainer.h>
#import <UIKit/UILabel.h>
#import <UIKit/UINibLoading.h>
@interface KLTextView()
-(void)refreshPlaceholder;
@end
@implementation KLTextView
{
    UILabel *placeHolderLabel;
}
@synthesize placeholder = _placeholder;

-(void)initialize{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
}

-(instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initialize];
}

-(void)refreshPlaceholder{
    if ([[self text] length]) {
        [placeHolderLabel setAlpha:0];
    }else{
        [placeHolderLabel setAlpha:1];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self refreshPlaceholder];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    placeHolderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    [super setTextAlignment:textAlignment];
    placeHolderLabel.textAlignment = textAlignment;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat offsetLeft = self.textContainerInset.left+self.textContainer.lineFragmentPadding;
    CGFloat offsetRight = self.textContainerInset.right+self.textContainer.lineFragmentPadding;
    CGFloat offsetTop = self.textContainerInset.top;
    CGFloat offsetBottom = self.textContainerInset.bottom;
    
    CGSize expectedSize = [placeHolderLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-offsetLeft-offsetRight, CGRectGetHeight(self.frame)-offsetTop-offsetBottom)];
    placeHolderLabel.frame = CGRectMake(offsetLeft, offsetTop, expectedSize.width, expectedSize.height);
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    if (placeHolderLabel == nil) {
        placeHolderLabel = [[UILabel alloc]init];
        placeHolderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.font = self.font;
        placeHolderLabel.textAlignment = self.textAlignment;
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        placeHolderLabel.alpha = 0;
        [self addSubview:placeHolderLabel];
    }
    placeHolderLabel.text = self.placeholder;
    [self refreshPlaceholder];
}
-(id<UITextViewDelegate>)delegate{
    [self refreshPlaceholder];
    return [super delegate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
