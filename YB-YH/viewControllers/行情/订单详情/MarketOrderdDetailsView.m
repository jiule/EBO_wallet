//
//  MarketOrderdDetailsView.m
//  YB-YH
//
//  Created by Apple on 2018/6/15.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketOrderdDetailsView.h"

@interface MarketOrderdDetailsView()
{
    UILabel * _leftlabel1;
    UILabel * _leftlabel2;
    UILabel * _leftlabel3;
    UILabel * _leftlabel4;
    UILabel * _rightlabel1;
    UILabel * _rightlabel2;
    UILabel * _rightlabel3;
    UILabel * _rightlabel4;

    int  _style ;
}
@end


@implementation MarketOrderdDetailsView

-(void)show
{

    float h = self.height * 0.25;
    if (_style == 2) {
        h = self.height * 0.5;
    }
    float x = JN_HH(20);
    _leftlabel1 = JnLabelType(CGRectMake(x, 0, self.width * 0.5 - x, h), UILABEL_3, BI_A0STR1(@"买入", @""), 0);
    [self addSubview:_leftlabel1];

    _leftlabel2 = JnLabelType(CGRectMake(x, h , self.width * 0.5 - x, h), UILABEL_3, @"收入地址", 0);
    [self addSubview:_leftlabel2];

    _rightlabel1 = JnLabelType(CGRectMake(0, 0, self.width  - x, h), 0, @"+10000", 2);
    _rightlabel1.textColor = COLOR_A1;
    [self addSubview:_rightlabel1];

    _rightlabel2 = JnLabelType(CGRectMake(0, h, self.width  - x, h), UILABEL_6, @"aaadsafdsfsdafsdafsadf", 2);
    [self addSubview:_rightlabel2];

    if (_style != 2) {
        _leftlabel3 = JnLabelType(CGRectMake(x, h * 2, self.width * 0.5 - x, h), UILABEL_3, @"矿工费", 0);
        [self addSubview:_leftlabel3];

        _leftlabel4 = JnLabelType(CGRectMake(x, h * 3, self.width * 0.5 - x, h), UILABEL_3, @"确认数", 0);
        [self addSubview:_leftlabel4];

        _rightlabel3 = JnLabelType(CGRectMake(0, h * 2, self.width  - x, h), UILABEL_6, @"0.010", 2);
        [self addSubview:_rightlabel3];

        _rightlabel4 = JnLabelType(CGRectMake(0, h * 3, self.width  - x, h), UILABEL_6, @"0", 2);
        [self addSubview:_rightlabel4];

        if (_style == 1) {
            _leftlabel1.text = BI_A1STR1(@"卖出", @"");
            _leftlabel2.text = @"发送地址";
            _leftlabel3.text = @"矿工费";
            _leftlabel4.text = @"确认数";
        }
    }else {

        _leftlabel1.text =  @"交易时间";
        _leftlabel2.text =  @"订单号";
        _rightlabel1.text = @"1998-01-01 10:00:00";
        _rightlabel2.text = @"1234567789";

//        _rightlabel1.font = _rightlabel2.font;
//        _rightlabel1.textColor = _rightlabel2.textColor ;
    }

}

-(void)showWithStyle:(int)style
{
    _style =style;
    [self show];
}

@end
