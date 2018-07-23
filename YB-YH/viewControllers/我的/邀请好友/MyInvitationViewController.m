//
//  MyInvitationViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyInvitationViewController.h"

@interface MyInvitationViewController ()
{
    UILabel * _yaoqingmaLabel;
    UILabel * _haoyoushuLabel;
    UILabel * _jiangliLabel;

    NSArray * _titleArrays;  //保存奖励规则的数组
}



@end

@implementation MyInvitationViewController

-(void)Initialize
{
    [super Initialize];
    _titleArrays = @[@"      每邀请一个好友完成注册,且该好友完成实名认证,您就可以获得10EBO的奖励."];
}

-(void)createNavView
{
    [super createNavView];
    [self.navView addDividingLine];
}


-(void)createView
{
    [super createView];

    float h =  self.nav_h;  float x = JN_HH(20);

    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(80)), COLOR_WHITE)];
    [self.view addSubview:JnLabelType(CGRectMake(x, h + JN_HH(10), JN_HH(100), JN_HH(20)), UILABEL_2, @"我的邀请码", 0)];

    _yaoqingmaLabel = JnLabel(CGRectMake(x, self.nav_h + JN_HH(30), SCREEN_WIDTH, JN_HH(40)), @"AAAA", JN_HH(30), SXRGB16Color(0x4d4d4d), 0);
    [self.view addSubview:_yaoqingmaLabel];


    UIButton * fuzhiBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH  - JN_HH(115), JN_HH(25) + h, JN_HH(100), JN_HH(30)), @"复制", 0, self, @selector(fuzhiClick));
    [fuzhiBtn setBackgroundColor:COLOR_WHITE];
    [fuzhiBtn setTitleColor:COLOR_A1 forState:0];
    JNViewStyle(fuzhiBtn, JN_HH(15), COLOR_A1, 1);
    [self.view addSubview:fuzhiBtn];

    h += JN_HH(90);
    UIView * whiteView = JnUIView(CGRectMake(0, h , SCREEN_WIDTH , JN_HH(80)), COLOR_WHITE);
    JNViewStyle(whiteView, 5, nil, 0);
    [self.view addSubview:whiteView];

    [whiteView addSubview:JnLabelType(CGRectMake(JN_HH(20), JN_HH(10), JN_HH(120), JN_HHH(20)), 2, @"我邀请好友数", 0)];
    [whiteView addSubview:JnLabelType(CGRectMake([whiteView getW] * 0.5 +JN_HH(20), JN_HH(10), JN_HH(120), JN_HHH(20)), 2, [NSString stringWithFormat:@"累计%@奖励",BI_A0], 0)];

    _haoyoushuLabel = JnLabelType(CGRectMake(JN_HH(20), JN_HH(30), whiteView.width * 0.25 - JN_HH(2), JN_HH(40)), 0, @"0", 0);
     _haoyoushuLabel.textColor = COLOR_A1;
    _haoyoushuLabel.font = [UIFont systemFontOfSize:JN_HH(30)];
    [whiteView addSubview:_haoyoushuLabel];

    [whiteView addSubview:JnLabelType(CGRectMake(whiteView.width * 5 + JN_HH(20), JN_HH(30), whiteView.width * 0.25, JN_HH(20)), UILABEL_6, @"位", 0)];

    _jiangliLabel = JnLabelType(CGRectMake([whiteView getW] * 0.5 + JN_HH(20), JN_HH(30), whiteView.width * 5 , JN_HH(40)), 0, @"0", 0);
    _jiangliLabel.textColor = COLOR_A1;
    _jiangliLabel.font = [UIFont systemFontOfSize:JN_HH(30)];
    [whiteView addSubview:_jiangliLabel];

    h += JN_HH(90);

    UIButton * btn = JnButton_tag(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(44)), COLOR_WHITE, self, @selector(jizhangbenClick), 100);
    [btn addSubview:JnLabelType(CGRectMake(JN_HH(20), JN_HH(7), SCREEN_WIDTH, JN_HH(30)), UILABEL_2, @"记账本", 0)];
    [self.view addSubview:btn];

    [btn addSubview:JnImageView(CGRectMake(SCREEN_WIDTH - JN_HH(44) - JN_HH(0), JN_HH(44) * 0.5  - JN_HH(22), JN_HH(44), JN_HH(44)), MYimageNamed(@"jiantou_H1_88")) ];

     h += JN_HH(60);

    [self.view  addSubview:JnLabelType(CGRectMake(JN_HH(20), h , SCREEN_WIDTH - JNVIEW_W(0), JN_HH(25)), UILABEL_2,@"奖励规则", 0)];
    h += JN_HH(30);
    for (int i = 0 ; i < _titleArrays.count; i++) {
//        float label_h1 = [@"1" heightOfFont:[UIFont systemFontOfSize:JN_HH(13.5)] width:SCREEN_WIDTH - JNVIEW_W(15)];
//        [self.view addSubview:JnLabel(CGRectMake(JNVIEW_X0, h, JN_HH(20),label_h1 ), [NSString stringWithFormat:@"%d·",i + 1], JN_HH(13.5), COLOR_B2, 1)];
        float label_h = [_titleArrays[i] heightOfFont:[UIFont systemFontOfSize:UILABEL_BZ_3] width:SCREEN_WIDTH - JNVIEW_W(20)];
        UILabel * label = JnLabelType(CGRectMake(JN_HH(20), h, SCREEN_WIDTH - JN_HH(40),label_h ), UILABEL_3,_titleArrays[i],  0);
        label.numberOfLines = 0;
        [self.view addSubview:label];
//        h += label_h + JN_HH(10);
    }

    UIButton * yaoiqngBtn = JnButtonTextType(CGRectMake(JNVIEW_X0, self.view.height - JN_HH(90), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(40)), @"生成邀请卡", 2, self, @selector(yaoqingkaClick));
    JNViewStyle(yaoiqngBtn, JN_HH(20), nil, 0);
    [self.view addSubview:yaoiqngBtn];

    [self.view addSubview:JnLabelType(CGRectMake(0, self.view.height  - JN_HH(40), SCREEN_WIDTH, JN_HH(15)),UILABEL_4, @"复制发送好友提醒其注册时记得填写邀请码", 1)];

    _yaoqingmaLabel.text = self.model.invite_code;
//    NSLog(@"%@",self.model.invite_code);
}

-(void)downDatas
{
    [self postdownDatas:@"/share/Myshare/invitationCount" withdict:@{} index:1];
  //  [self postdownDatas:@"/user/Assets/getSuger" withdict:@{} index:2];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        NSLog(@"responseDict 1======%@",responseDict);
        _haoyoushuLabel.text = [NSString stringWithFormat:@"%@",responseDict[@"invite_cn"]];
        _jiangliLabel.text = [NSString stringWithFormat:@"%@",responseDict[@"profit"]];
    }
}

#pragma mark-----复制按钮点击
-(void)fuzhiClick
{
    [_yaoqingmaLabel.text pasteboard];
    if ([[NSString readpasteboard] isEqualToString:_yaoqingmaLabel.text]) {
        [MYAlertController showNavViewWith:@"复制成功"];
    }
}
#pragma mark----记账本点击
-(void)jizhangbenClick
{
    [self popControllerwithstr:@"MyInvitationlistViewController" title:@"记账本"];
}
#pragma mark-----邀请卡被点击
-(void)yaoqingkaClick
{
    
}
@end
