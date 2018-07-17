//
//  UIMoneyLabel.m
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "UIMoneyLabel.h"

@interface UIMoneyLabel()
{
    UILabel * _leftLabel;
    UILabel * _rightlabel;
}
@end


@implementation UIMoneyLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        [self crateLabel];
        return self;
    }
    return nil;
}

-(void)crateLabel
{
    _leftLabel = JnLabel(CGRectMake(0, 0, self.width - JN_HH(60), self.height), @"", JN_HH(40), COLOR_WHITE, 0);
    [self addSubview:_leftLabel];

    _rightlabel = JnLabel(CGRectMake(self.width - JN_HH(60), 0, JN_HH(60), self.height), @"", JN_HH(40), COLOR_WHITE, 0);
    [self addSubview:_rightlabel];
}


-(void)setText:(NSString *)text componentsSeparatedByString:(NSString *)string
{
    _leftLabel.text = @"";
    _rightlabel.text = @"";
//    NSLog(@"text======%@=====%@",text,[text class]);
    NSArray * textArray = [text componentsSeparatedByString:string];
    if (textArray.count == 2)
    {
        NSString * leftStr = textArray[0]; NSString * left = @"";
        NSArray * dianArrays = [leftStr componentsSeparatedByString:@"."];
        NSString * dianStr = @"";
        if (dianArrays.count >= 2) {
            NSString * dian = [NSString stringWithString:leftStr];
            leftStr = dianArrays[0];
            dianStr = [dian substringFromIndex:leftStr.length];
        }
        for (int  i = 0 ; i < leftStr.length; i++) {
            left = [NSString stringWithFormat:@"%@%@",[leftStr substringWithRange:NSMakeRange(leftStr.length - 1 -i, 1)],left];
            if (i % 3 ==  2 && i != leftStr.length - 1) {
                left = [NSString stringWithFormat:@",%@",left];
            }
        }
        if (dianArrays.count >= 2) {
            left = [NSString stringWithFormat:@"%@%@",left,dianStr];
        }
        _leftLabel.text = left;
        _rightlabel.text = [NSString stringWithFormat:@"%@%@",string,textArray[1]];
    }else {
        NSString * leftStr = text; NSString * left = @"";
        for (int  i = 0 ; i < leftStr.length; i++) {
            left = [NSString stringWithFormat:@"%@%@",[leftStr substringWithRange:NSMakeRange(leftStr.length - 1 -i, 1)],left];
            if (i % 3 ==  2) {
                left = [NSString stringWithFormat:@",%@",left];
            }
        }
        _leftLabel.text = leftStr;
    }
    [self loadView];
}

-(void)setLeftTextColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor
{
    _leftLabel.textColor = leftColor;
    _rightlabel.textColor = rightColor;
}

-(void)setLeftFont:(UIFont *)leftFont rightFont:(UIFont *)rightFont
{
    _leftLabel.font = leftFont;
    _rightlabel.font = rightFont;
    [self loadView];
}

-(void)rightLabelup:(BOOL)isup
{
//    if (isup) {
//        [_rightlabel setY:JN_HH(2)];
//    }else {
//        [_rightlabel setY:self.height * 0.5];
//    }
}
//重新计算label的位子
-(void)loadView
{
    float right_x = [_leftLabel.text widthOfFont:_leftLabel.font height:_leftLabel.height];
    if (right_x >= self.width - _rightlabel.width) {
        right_x = [_leftLabel.text widthOfFont:_leftLabel.font height:_leftLabel.height];
        [_leftLabel adjusts];
    }else {
        [_leftLabel setW:right_x];
    }
    [_rightlabel setX:right_x];

    [_rightlabel setW:[_rightlabel.text widthOfFont:_rightlabel.font height:_rightlabel.height]];

    if (self.textAlignment == NSTextAlignmentCenter) {
        float w = _leftLabel.width + _rightlabel.width;
        [_leftLabel setX:(self.width - w) *0.5 + JN_HH(30)];
        [_rightlabel setX:(self.width - w) *0.5 + _leftLabel.width + JN_HH(30)];
        [_leftLabel setTextAlignment:NSTextAlignmentRight];
    }else if(self.textAlignment == NSTextAlignmentRight){
        float w = _leftLabel.width + _rightlabel.width;
        [_leftLabel setX:w];
        [_rightlabel setX:self.width- _rightlabel.width];
        [_leftLabel setTextAlignment:NSTextAlignmentRight];
    }
     [_leftLabel setTextAlignment:NSTextAlignmentRight];

}
@end
