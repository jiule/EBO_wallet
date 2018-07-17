//
//  TranferDetailsView.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TranferDetailsView.h"
#import "TranferDetailsModel.h"

@interface TranferDetailsView ()
{
    UILabel * _jineLabel;
    UILabel * _typeLabel;
    UILabel * _kuanggongLaebl;
    UILabel * _querenLabel;
    UILabel * _gasLabel;
    UILabel * _mudiLabel;
    UILabel * _yuanLabel;
    UILabel * _timerLabel;
    UILabel * _dingdanLabel;
}

@end


@implementation TranferDetailsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        return self;
    }
    return nil;
}

-(void)createView
{
    self.backgroundColor = COLOR_WHITE;
    float h = JN_HH(10);
    float x = JN_HH(15);
    float jian = JN_HH(44);
    NSArray * titleArray = @[@"交易金额",@"交易类型",@"矿工费",@"确认数",@"Gas"];
    for (int i = 0 ; i < titleArray.count; i++) {
        [self addSubview:JnLabelType(CGRectMake(x, h + jian * i, self.width * 0.5, jian), UILABEL_2, titleArray[i], 0)];
    }

    _jineLabel = JnLabel(CGRectMake(self.width * 0.5, h, self.width * 0.5 - x, jian), @"10000", JN_HH(25.5), COLOR_A1, 2);
    [self addSubview:_jineLabel];

    h += jian;
    _typeLabel = JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"发送/支付", 2);
    [self addSubview:_typeLabel];

    h += jian;
    _kuanggongLaebl = JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"0.00000123", 2);
    [self addSubview:_kuanggongLaebl];

    h += jian;
    _querenLabel = JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"6", 2);
    [self addSubview:_querenLabel];

    h += jian;
    _gasLabel = JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"2100", 2);
    [self addSubview:_gasLabel];

    h += jian;

    [self addUnderscoreWihtFrame:CGRectMake(0, h, self.width, 1)];

    [self addSubview:JnLabelType(CGRectMake(x, h + JN_HH(5), SCREEN_WIDTH, JN_HH(25)), UILABEL_2, @"交易目的地址(他人地址)", 0)];
    _mudiLabel = JnLabelType(CGRectMake(x , h + JN_HH(30), self.width - 2 * x, JN_HH(50)), UILABEL_3, @"xxxaaadfklajsdklfjklsadjfklsadjfklsadjfkljsdklfjsdaklfjslkdajflks", 0);
    _mudiLabel.numberOfLines = 0;
    [self addSubview:_mudiLabel];

    h += JN_HH(80);

    [self addSubview:JnLabelType(CGRectMake(x, h + JN_HH(5), SCREEN_WIDTH, JN_HH(25)), UILABEL_2, @"交易原地址(自己地址)", 0)];
    _yuanLabel = JnLabelType(CGRectMake(x , h + JN_HH(30), self.width - 2 * x, JN_HH(50)), UILABEL_3, @"xxxaaadfklajsdklfjklsadjfklsadjfklsadjfkljsdklfjsdaklfjslkdajflks", 0);
    _yuanLabel.numberOfLines = 0;
    [self addSubview:_yuanLabel];

    h += JN_HH(80);
    [self addUnderscoreWihtFrame:CGRectMake(0, h, self.width, 1)];

    h += JN_HH(10);
    [self addSubview:JnLabelType(CGRectMake(x, h, SCREEN_WIDTH, JN_HH(30)), UILABEL_2, @"交易时间", 0)];
    _timerLabel = JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"1990-01-01 14:20", 2);
    [self addSubview:_timerLabel];
    h += jian;
    [self addSubview:JnLabelType(CGRectMake(x, h, SCREEN_WIDTH, JN_HH(30)), UILABEL_2, @"订单号", 0)];
    _dingdanLabel =  JnLabelType(CGRectMake(self.width *0.5, h, self.width * 0.5 - x, jian), UILABEL_3, @"100000100000001111", 2);
    [self addSubview:_dingdanLabel];

}

-(void)setTranferModel:(TranferDetailsModel *)tranferModel
{
    _tranferModel = tranferModel;
    _jineLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyinum];
    _typeLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyitype];
     _kuanggongLaebl.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyikuang];
     _querenLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyique];
     _gasLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyigas];
     _mudiLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyimuaddress];
     _yuanLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyiaddress];
     _timerLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyitimer];
     _dingdanLabel.text = [NSString stringWithFormat:@"%@",_tranferModel.jiaoyi_id];
}

@end
