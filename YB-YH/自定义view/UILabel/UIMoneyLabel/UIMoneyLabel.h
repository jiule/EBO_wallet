//
//  UIMoneyLabel.h
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMoneyLabel : UIView

-(void)setText:(NSString *)text componentsSeparatedByString:(NSString *)string;

-(void)setLeftTextColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

-(void)setLeftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont;

-(void)rightLabelup:(BOOL)isup;

@property(nonatomic)NSTextAlignment  textAlignment;

@end
