//
//  BCTextView.h
//  BCDemo
//
//  Created by baochao on 15/7/27.
//  Copyright (c) 2015年 baochao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCTextView : UITextView
@property (nullable,nonatomic, retain) NSString *placeholder;
@property (nullable,nonatomic, retain) UIColor *placeholderColor;
@property(nullable,nonatomic,strong) UIFont *placeholderFont;
@end
