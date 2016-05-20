//
//  BCTextView.m
//  BCDemo
//
//  Created by baochao on 15/7/27.
//  Copyright (c) 2015年 baochao. All rights reserved.
//

#import "BCTextView.h"

@interface BCTextView ()

@end

@implementation BCTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
        
        self.autoresizesSubviews = NO;
        //默认字和颜色
        self.placeholder = @"";
        self.placeholderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:17];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    //内容为空时才绘制placeholder
    if ([self.text isEqualToString:@""]) {
        CGRect placeholderRect;
        placeholderRect.origin.y = 10;
        placeholderRect.size.height = CGRectGetHeight(self.frame) - 10;

        placeholderRect.origin.x = 5;
        placeholderRect.size.width = CGRectGetWidth(self.frame) - 5;

        [self.placeholderColor set];
        self.textAlignment = NSTextAlignmentLeft;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.placeholder drawInRect:placeholderRect withAttributes:@{NSParagraphStyleAttributeName:style,NSFontAttributeName:!self.placeholderFont ? self.font : self.placeholderFont,NSForegroundColorAttributeName:self.placeholderColor}];
        
    }
}
- (void)textChanged:(NSNotification *)not
{
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
@end
