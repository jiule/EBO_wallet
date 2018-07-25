//
//  ScreeningTransferView.m
//  YB-YH
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ScreeningTransferView.h"
#import "ScreeningBtn.h"

@interface ScreeningTransferView()
{
    UIView * _bgView;
    NSMutableDictionary * _dict;
    ScreeningBtn * _timerBtn;
    ScreeningBtn * _zengBtn;
    ScreeningBtn * _biBtn;
    ScreeningBtn * _leiBtn;

     NSArray * _tiemrArray;
     NSArray * _zengArray;
     NSArray * _biArray;
     NSArray * _leiArray;
}

@end


@implementation ScreeningTransferView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        [self show];
        return self;
    }
    return nil;
}

-(void)show
{
    _bgView = JnUIView(CGRectMake(0, 0, self.width, JN_HH(80) * 4 + JN_HH(50)), COLOR_B5);
    [self addSubview:_bgView];


    float x = JN_HH(15); float h = JN_HH(80);
    NSArray * tiemrArray = @[@"近一周",@"近一月",@"近一年"];
    NSArray * zengArray = @[@"转入",@"转出"];
    NSArray * biArray = @[@"EBO",@"ETH"];
    NSArray * leiArray = @[@"收益",@"交易",@"游戏"];
    NSArray * titleArray = @[@"时间",@"增减",@"币种",@"类型"];

    for (int i = 0 ; i < titleArray.count; i++) {
        [_bgView addSubview:JnLabelType(CGRectMake(x, h * i + JN_HH(7), JN_HH(100), JN_HH(20)), UILABEL_3, titleArray[i], 0)];
        [_bgView addSubview:JnUIView(CGRectMake(0, h * (i + 1), self.width, 1), DIVIDER_COLOR1)];
    }
    float b_w = (self.width - 4 * x) / 3;
    for (int i = 0 ; i < tiemrArray.count; i++) {
        ScreeningBtn * btn = [[ScreeningBtn alloc]initWithFrame:CGRectMake(x + (b_w + x) * i , JN_HH(35), b_w, JN_HH(40))];
        [btn setTitle:tiemrArray[i] forState:0];
        [_bgView addSubview:btn];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    for (int i = 0 ; i < zengArray.count; i++) {
        ScreeningBtn * btn = [[ScreeningBtn alloc]initWithFrame:CGRectMake(x + (b_w + x) * i , JN_HH(35) + h , b_w, JN_HH(40))];
        [btn setTitle:zengArray[i] forState:0];
        [_bgView addSubview:btn];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    for (int i = 0 ; i < biArray.count; i++) {
        ScreeningBtn * btn = [[ScreeningBtn alloc]initWithFrame:CGRectMake(x + (b_w + x) * i , JN_HH(35) + 2 * h , b_w, JN_HH(40))];
        [btn setTitle:biArray[i] forState:0];
        [_bgView addSubview:btn];
        btn.tag = 300 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    for (int i = 0 ; i < leiArray.count; i++) {
        ScreeningBtn * btn = [[ScreeningBtn alloc]initWithFrame:CGRectMake(x + (b_w + x) * i , JN_HH(35) + 3 * h , b_w, JN_HH(40))];
        [btn setTitle:leiArray[i] forState:0];
        [_bgView addSubview:btn];
        btn.tag = 400 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    b_w = (self.width - 3 * x) / 2;
    NSArray * btnArray = @[@"清空条件",@"确定"];
    for (int i = 0 ; i < btnArray.count; i++) {
        ScreeningBtn * btn = [[ScreeningBtn alloc]initWithFrame:CGRectMake(x + (b_w + x) * i , JN_HH(5) + 4 * h , b_w, JN_HH(40))];
        [btn setTitle:btnArray[i] forState:0];
        [_bgView addSubview:btn];
        btn.tag = 50 + i;
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if ( i == 1) {
            btn.selected = YES;
        }
    }
}
-(void)showWithDict:(NSDictionary *)dict
{
    _dict = [[NSMutableDictionary alloc]initWithDictionary:dict];


}

-(void)titleBtnClick:(ScreeningBtn *)btn
{
    if (btn.tag == 50) {
        [self removeBtn];
    }else {
        NSArray * array = @[@"week",@"month",@"year"];
        NSArray * zengarray = @[@"transIn",@"transOut"];
        NSArray * biarray = @[BI_A0,BI_A1];
        NSArray * leiarray = @[@"Profit",@"Trans",@"Game"];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        if (_timerBtn) {
            [dict setObject:array[_timerBtn.tag - 100] forKey:@"cycle"];
        }
        if (_zengBtn) {
            [dict setObject:zengarray[_zengBtn.tag - 200] forKey:@"inout"];
        }
        if (_biBtn) {
          //  [dict setObject:[CurrencyManager readAddressWithSpecies:biarray[_biBtn.tag - 300]] forKey:@"coin_species"];
            [dict setObject:[CurrencyManager readspeciesWithName:biarray[_biBtn.tag - 300]] forKey:@"coin_species"];
        }
        if (_leiBtn) {
            [dict setObject:leiarray[_leiBtn.tag - 400] forKey:@"trans_type"];
        }

        if ([_delegate respondsToSelector:@selector(didScreeningTransferView:dict:)]) {
            [_delegate didScreeningTransferView:self dict:dict];
        }
        [self removeFromSuperview];
    }
}

-(void)btnClick:(ScreeningBtn *)btn
{
    if (btn.tag < 200) {
        if (_timerBtn == nil) {
            _timerBtn = btn;
            _timerBtn.selected = YES;
        }else if(_timerBtn == btn)
        {
            _timerBtn.selected  = !btn.selected;
            if (_timerBtn.selected == NO) {
                _timerBtn = nil;
            }
        }else {
            _timerBtn.selected = NO;
            _timerBtn = btn;
            _timerBtn.selected = YES ;
        }

    }else if(btn.tag < 300){
        if (_zengBtn == nil) {
            _zengBtn = btn;
            _zengBtn.selected = YES;
        }else if(_zengBtn == btn)
        {
            _zengBtn.selected  = !btn.selected;
            if (_zengBtn.selected == NO) {
                _zengBtn = nil;
            }
        }else {
            _zengBtn.selected = NO;
            _zengBtn = btn;
            _zengBtn.selected = YES ;
        }
    }else if(btn.tag < 400)
    {
        if (_biBtn == nil) {
            _biBtn = btn;
            _biBtn.selected = YES;
        }else if(_biBtn == btn)
        {
            _biBtn.selected  = !btn.selected;
            if (_biBtn.selected == NO) {
                _biBtn = nil;
            }
        }else {
            _biBtn.selected = NO;
            _biBtn = btn;
            _biBtn.selected = YES ;
        }
    }  else if(btn.tag < 500)
    {
        if (_leiBtn == nil) {
            _leiBtn = btn;
            _leiBtn.selected = YES;
        }else if(_leiBtn == btn)
        {
            _leiBtn.selected  = !btn.selected;
            if (_leiBtn.selected == NO) {
                _leiBtn = nil;
            }
        }else {
            _leiBtn.selected = NO;
            _leiBtn = btn;
            _leiBtn.selected = YES ;
        }
    }
}

-(void)removeBtn
{
    for (UIView * view in _bgView.subviews) {
        if ([view class] == [ScreeningBtn class]) {
            ScreeningBtn * btn = (ScreeningBtn *)view;
            if (btn.tag >= 100) {
                 btn.selected = NO;
            }
        }
    }
}

@end
