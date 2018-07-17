//
//  MarketOrderdDetailsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketOrderdDetailsViewController.h"
#import "MarketOrderdDetailsView.h"

@interface MarketOrderdDetailsViewController ()
{
    NSString * _detailesId;
    UIView * _bgDownView;
    MarketOrderdDetailsView * _upView;
    MarketOrderdDetailsView * _downView;
     MarketOrderdDetailsView * _timerView;
}
@end

@implementation MarketOrderdDetailsViewController

-(instancetype)initWithNavTitle:(NSString *)str detailesId:(NSString *)detailesId
{
    self = [super initWithNavTitle:str];
    _detailesId = detailesId;
    if (self) {
        return self;
    }
    return nil;
}

-(void)createView
{
    [super createView];
    [self.navView addDividingLine];
    float h = self.nav_h;
    _bgDownView = JnUIView(CGRectMake(0, h + JN_HH(15), SCREEN_WIDTH , JN_HH(380)), COLOR_WHITE);
//    JNViewStyle(_bgDownView, 10, nil, 0);
    [self.view addSubview:_bgDownView];

    _upView  = [[MarketOrderdDetailsView alloc]initWithFrame:CGRectMake(0, JN_HH(20), _bgDownView.width, JN_HH(120))];
    [_upView showWithStyle:0];
    [_bgDownView addSubview:_upView];

    _downView = [[MarketOrderdDetailsView alloc]initWithFrame:CGRectMake(0, JN_HH(160), _bgDownView.width, JN_HH(120))];
    [_downView showWithStyle:1];
    [_bgDownView addSubview:_downView];

    [_bgDownView addUnderscoreWihtFrame:CGRectMake(JN_HH(15), JN_HH(284), _bgDownView.width - JN_HH(30), 1)];

    _timerView = [[MarketOrderdDetailsView alloc]initWithFrame:CGRectMake(0, JN_HH(300), _bgDownView.width, JN_HH(60))];
    [_timerView showWithStyle:2];
    [_bgDownView addSubview:_timerView];

    [self.view addSubview:JnUIView(CGRectMake(0, JN_HH(430) + self.nav_h, SCREEN_WIDTH, JN_HH(40)), COLOR_WHITE)];
    [self.view addSubview:JnButtonTextType(CGRectMake(JN_HH(15), JN_HH(435) + self.nav_h, SCREEN_WIDTH  - JN_HH(30), JN_HH(30)), @"订单异常? 客服申诉", Button_3, self, @selector(kefuClick))];

}

-(void)kefuClick
{
    [self popControllerwithstr:@"KeFuViewController" title:@"联系客服"];
}



@end
