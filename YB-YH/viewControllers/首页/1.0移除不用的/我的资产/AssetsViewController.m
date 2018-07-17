//
//  AssetsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/19.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "AssetsViewController.h"
#import "AssetsQianView.h"

@interface AssetsViewController ()
{
    UILabel * _shouyiLabel;
    UILabel * _leijiLabel;
    UILabel * _ethLabel;

    UIView *  _jiluView ;    //最近记录
    UIView  * _qianbaoView;  //我的钱包

}
@end

@implementation AssetsViewController

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:2];
    [self.navView.rightButton setBackgroundImage:MYimageNamed(@"sy_zichanzzjl") forState:0];
}


-(void)createView
{
    [super createView];
    float h = self.nav_h;
    float x = JN_HH(20);
    h += JN_HH(10);
    self.baseScollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tab_h);
    [self.bgImageView addSubview:JnLabel(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(20)), @"昨日收益(CCS)", JN_HH(13.5), COLOR_A3, 1)];
    self.bgImageView.userInteractionEnabled = YES ;
    h += JN_HH(20);
    _shouyiLabel = JnLabel(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(50)), @"暂无收益", JN_HH(30), COLOR_WHITE, 1);
    [self.bgImageView addSubview:_shouyiLabel];

    h += JN_HH(60);
    [self.bgImageView addSubview:JnLabel(CGRectMake(x, h, SCREEN_WIDTH *0.5 - x, JN_HH(20)), @"累计收益(CCS)", JN_HH(13.5), COLOR_A3, 1)];
    [self.bgImageView addSubview:JnLabel(CGRectMake(SCREEN_WIDTH *0.5, h, SCREEN_WIDTH *0.5 - x, JN_HH(20)), @"ETH总量", JN_HH(13.5), COLOR_A3, 1)];
    h += JN_HH(25);
    _leijiLabel = JnLabel(CGRectMake(x, h - JN_HH(10), SCREEN_WIDTH *0.5 - x, JN_HH(45)), @"0", JN_HH(16.5), COLOR_WHITE, 1);
    [self.bgImageView addSubview:_leijiLabel];
    JNWeakSelf(self);
    [_leijiLabel addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        [weakself leijishouyi];
    }];

    _ethLabel = JnLabel(CGRectMake(SCREEN_WIDTH *0.5, h, SCREEN_WIDTH *0.5 - x, JN_HH(25)), @"0", JN_HH(15.5), COLOR_WHITE, 1);
    [self.bgImageView addSubview:_ethLabel];

    h += JN_HH(35);

    UIButton * queBtn = JnButtonTextType(CGRectMake(JN_HH(45), h, SCREEN_WIDTH  * 0.5 - JN_HH(65), JN_HH(35)), @"转入", 0, self, @selector(zhuanruBtnClick));
    JNViewStyle(queBtn, JN_HH(17.5), nil, 0);
    [[queBtn titleLabel] setFont:[UIFont systemFontOfSize:15.5]];
    [self.bgImageView addSubview:queBtn];

    UIButton * queBtn1 = JnButtonTextType(CGRectMake(JN_HH(20) + SCREEN_WIDTH * 0.5, h, SCREEN_WIDTH  * 0.5 - JN_HH(65), JN_HH(35)), @"转出", 0, self, @selector(zhuanchuBtnClick));
    [[queBtn1 titleLabel] setFont:[UIFont systemFontOfSize:15.5]];
    JNViewStyle(queBtn1, JN_HH(17.5), nil, 0);
    [self.bgImageView addSubview:queBtn1];

    h += JN_HH(60);
    [self addBgDownViewWithy:h bgColor:COLOR_B6];
    h += JN_HH(10);
//最近记录

    [self.bgDownView addSubview:JnLabel(CGRectMake(JN_HH(25), JN_HH(10), JN_HH(100), JN_HH(20)), @"最近记录", JN_HH(15.5), COLOR_H1, 0)];
    _jiluView = JnUIView(CGRectMake(JN_HH(15), JN_HH(35), SCREEN_WIDTH - JN_HH(30), JN_HH(110)), COLOR_WHITE);
    JNViewStyle(_jiluView, 5, nil, 0);

    NSArray * textArray = @[@"单次转出",@"理财收益"];
    NSArray * timerArray = @[@"2018-01-01",@"2018-01-01"];
    NSArray * titleArray = @[@"+0.50",@"-0.55"];
    for (int i = 0 ; i < textArray.count; i++) {
        AssetsjiluView * qianView = [[AssetsjiluView alloc]initWithFrame:CGRectMake(0, JN_HH(55)* i, _jiluView.width, JN_HH(55))];
        [_jiluView addSubview:qianView];
        [qianView showWithText:textArray[i] timer:timerArray[i] title:titleArray[i]];
    }


    [self.bgDownView addSubview:_jiluView];

    //我的钱包
    _qianbaoView = JnUIView(CGRectMake(0, JN_HH(155), SCREEN_WIDTH , JN_HH(100)), self.bgDownView.backgroundColor);
    [self.bgDownView addSubview:_qianbaoView];

   [_qianbaoView  addSubview:JnLabel(CGRectMake(JN_HH(25), JN_HH(0), JN_HH(100), JN_HH(20)), @"我的钱包", JN_HH(15.5), COLOR_H1, 0)];
    NSArray * titleArrays = @[@"CCS",@"ETH"];
    NSArray * imageArrays = @[@"sy_zichanCCS",@"sy_zichanETH"];
    for (int i = 0 ; i < titleArrays.count; i++) {
        AssetsQianView * qianView = [[AssetsQianView alloc]initWithFrame:CGRectMake(JN_HH(20), JN_HH(25) + JN_HH(80) * i, SCREEN_WIDTH - JN_HH(40), JN_HH(70)) text:titleArrays[i] imageName:imageArrays[i]];
        qianView.tag = 1000 +i ;
        [_qianbaoView addSubview:qianView];
    }


}

-(void)zhuanruBtnClick
{
    [self popControllerwithstr:@"RollIntoViewController" title:@"转入"];
}

-(void)zhuanchuBtnClick{
    [self popControllerwithstr:@"RollOutViewController" title:@"转出"];
}

-(void)leijishouyi
{
   [self popControllerwithstr:@"AccumulatedEarningsViewController" title:@"累计收益"];
}

-(void)clickRightButton:(UIButton *)rightBtn
{
    [self popControllerwithstr:@"TransferRecordViewController" title:@"转账记录"];
}


@end
