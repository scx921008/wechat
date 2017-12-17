//
//  UITextView+Placeholder.h
//  New_APP
//
//  Created by 桑赐相 on 2017/11/22.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)
@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;
@end
