//
//  MarketView.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketView.h"
#import "ProportionModel.h"

@interface MarketView() <UITextFieldDelegate>
{
    int _style;
    UITextField * _textField1;
    UILabel * _textLabel;

    UILabel * _biliLabel;
    UITextField * _textField2;

    int _text1;
    float _text2;

}
@end

@implementation MarketView

-(instancetype)initWithFrame:(CGRect)frame style:(int)style
{
    self = [super initWithFrame:frame];
    _bili = 2999;
    _rmbBili = 1;
    _style = style;
    if (self) {
        [self show];
        return self;
    }
    return nil;
}

-(void)show
{
    self.backgroundColor =  COLOR_WHITE;
    NSArray * titleArray = @[@"买入数量",@"卖出数量"];
    NSArray * prtitleArray = @[BI_A0STR1(@"输入买入的", @"币"),BI_A0STR1(@"输入卖出的", @"币")];
  //  NSArray * niceArray = @[BI_A0STR(@"最低购买数量:100"),BI_A0STR(@"最低卖出数量:100")];

    float h = JN_HH(10);
    [self addSubview:JnLabelType(CGRectMake(JNVIEW_X(5), h + JN_HH(10), JN_HH(100), JN_HH(30)), 2, titleArray[_style - 1], 0)];
    _textField1 = JnTextFiled(CGRectMake(JNVIEW_X(110), h + JN_HH(10), SCREEN_WIDTH - JNVIEW_W(160), JN_HH(30)), prtitleArray[_style - 1], 0);
    _textField1.delegate = self;
    _textField1.textAlignment = NSTextAlignmentRight;
    _textField1.clearButtonMode = UITextFieldViewModeNever;
    _textField1.textColor = COLOR_A1;
    _textField1.backgroundColor = [UIColor clearColor];
    _textField1.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_textField1];

    [self addSubview:JnLabelType(CGRectMake(0, h + JN_HH(10), SCREEN_WIDTH - JNVIEW_X(10), JN_HH(30)), 5, BI_A0, 2)];

    h += JN_HH(50);
    [self addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH , 1)];


     [self addSubview:JnLabelType(CGRectMake(JNVIEW_X(5), h + JN_HH(10), self.width * 0.5 - JNVIEW_X(10), JN_HH(30)), 2, @"估值", 0)];
    _biliLabel = JnLabelType(CGRectMake(self.width * 0.5, h + JN_HH(10), self.width * 0.5 - JNVIEW_X(10), JN_HH(30)), 2, @"￥0.0", 2);
    [self addSubview:_biliLabel];

    h += JN_HH(50);
    [self addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH , 1)];

    [self addSubview:JnLabelType(CGRectMake(JNVIEW_X(5), JN_HH(120), JN_HH(100), JN_HH(30)), 2, @"成交额数", 0)];

//    _textLabel = JnLabel(CGRectMake(JNVIEW_X(110), JN_HH(120), SCREEN_WIDTH - JNVIEW_W(160), JN_HH(30)), @"", JN_HH(13.5), COLOR_A2, 2);
//    [self addSubview:_textLabel];
    _textField2 = JnTextFiled(CGRectMake(JNVIEW_X(110), JN_HH(120), SCREEN_WIDTH - JNVIEW_W(160), JN_HH(30)), @"", 0);
    _textField2.delegate = self;
    _textField2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _textField2.textAlignment = NSTextAlignmentRight;
    _textField2.clearButtonMode = UITextFieldViewModeNever;
    _textField2.textColor = COLOR_A1;
    _textField2.backgroundColor = [UIColor clearColor];
    [self addSubview:_textField2];


    [self addSubview:JnLabelType(CGRectMake(0, JN_HH(120), SCREEN_WIDTH - JNVIEW_X(10), JN_HH(30)), 5, BI_A1, 2)];
    [self addUnderscoreWihtFrame:CGRectMake(0, JN_HH(160), SCREEN_WIDTH , self.height - JN_HH(150))];

    UIButton * btn = JnButtonTextType(CGRectMake(self.width * 0.5 - JN_HH(50), JN_HH(180), JN_HH(100), JN_HH(40)), @"买入", 0, self, @selector(btnClick));
    JNViewStyle(btn, JN_HH(20), nil, 0);
    [self addSubview:btn];
    if (_style == 1) {
    //    [btn setBackgroundColor:SXRGB16Color(0X8BBB51)];
        [btn setTitle:@"买入" forState:0];
    }else {
        [btn setBackgroundColor:SXRGB16Color(0XFC695F)];
     //   [btn setTitle:@"卖出" forState:0];
    }
    [btn setBackgroundColor:COLOR_A1];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"0"] && textField.text.length == 0) {
        return  NO;
    }
    NSString * str = @"0";
    if (textField == _textField1) {
        if (range.length == 1) {
            if (textField.text.length > 0) {
                str = [textField.text substringWithRange:NSMakeRange(0, textField.text.length -1)];
            }
            if (str.length == 0) {
                str = @"0";
            }
        }else {
                str  = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        _textField2.text = [NSString stringWithFormat:@"%f",[str intValue] / _bili];
        _biliLabel.text = [NSString stringWithFormat:@"￥%.2f",[str intValue] / _rmbBili];
    }else {

        if (range.length == 1) {
            if (textField.text.length > 0) {
                str = [textField.text substringWithRange:NSMakeRange(0, textField.text.length -1)];
            }
            if (str.length == 0) {
                str = @"0";
            }
        }else {
            NSArray * array = [textField.text componentsSeparatedByString:@"."];
            if (array.count > 1 ) {
                NSString * textStr = array[1];
                if (textStr.length >=6 || [string isEqual:@"."]) {
                    return  NO;
                }
            }
            if ([string isEqual:@"."] && textField.text.length == 0 ) {
                textField.text = @"0";
            }
            if ([textField.text isEqual:@"0"] && ![string isEqual:@"."]) {
                textField.text = nil;
            }
                 str  = [NSString stringWithFormat:@"%@%@",textField.text,string];

        }
        _textField1.text = [NSString stringWithFormat:@"%d",(int)([str floatValue] * _bili) ];
        str = _textField1.text ;
        _biliLabel.text = [NSString stringWithFormat:@"￥%.2f",[str intValue] / _rmbBili];
    }

    if ([str intValue] > self.max) {
        str = [NSString stringWithFormat:@"%d",self.max];
        _textField1.text = [NSString stringWithFormat:@"%d",_max];
        _textField2.text = [NSString stringWithFormat:@"%f",_max / _bili];
        _biliLabel.text = [NSString stringWithFormat:@"￥%.2f",[str intValue] / _rmbBili];
        if ([_delegate respondsToSelector:@selector(didView:text:)]) {
            [_delegate didView:self text:str];
        }
        return NO;
    }
    if ([_delegate respondsToSelector:@selector(didView:text:)]) {
        [_delegate didView:self text:str];
    }
    return YES;
}


-(void)setTextnum:(int)num
{
    _text1 = num;
    _textField1.text = [NSString stringWithFormat:@"%d",num];
    _textField2.text = [NSString stringWithFormat:@"%f",num / _bili];
}

-(NSString *)readNum
{
    return _textField1.text;
}
-(NSString *)readNumeth
{
    return _textField2.text;
}
-(int)readStyle
{
    return _style;
}

-(void)btnClick
{
    if ([_delegate respondsToSelector:@selector(didView:)]) {
        [_delegate didView:self];
    }
}

@end
