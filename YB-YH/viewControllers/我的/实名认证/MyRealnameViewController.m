//
//  MyRealnameViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyRealnameViewController.h"
#import "RealnameButton.h"

@interface MyRealnameViewController ()
{
    NSArray * _imageArrays;
    NSArray * _selImageArrays;
    NSArray * _titleArrays;
    NSArray * _describeArrays;
}
@end

@implementation MyRealnameViewController

-(void)Initialize
{
    [super Initialize];
    _imageArrays = @[@"wd_rzsmrzh",@"wd_rzgjrzh",@"wd_rzrlsbh"];
    _selImageArrays = @[@"wd_rzsmrzl",@"wd_rzgjrzl",@"wd_rzrlsbl"];
    _titleArrays = @[@"实名认证",@"高级认证",@"人脸识别"];
    _describeArrays = @[@"31******00",@"可进行单笔超过2k或累计金额大于5w的交易",@"可进行单笔超过2k的共享或借币交易"];

}


-(void)createView
{
    [super createView];
    [self.navView addDividingLine];
    float h = self.nav_h;
    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(80)), COLOR_WHITE)];


    [self.view addSubview:JnLabel(CGRectMake(0, h + JN_HH(20), SCREEN_WIDTH, JN_HH(25)), @"为了您的资金安全,需要验证您的身份证才可以进行",JN_HH(13.5),COLOR_BL_2, 1)];
    [self.view addSubview:JnLabel(CGRectMake(0, h + JN_HH(45), SCREEN_WIDTH, JN_HH(25)),  @"其它操作,认证信息一经验证不能修改,请务必如实填写" ,JN_HH(13.5),COLOR_BL_2,1)];

    h += JN_HH(115);

    for (int i = 0;  i < _imageArrays.count; i++) {
        if ( i >= 2) {
            return ;
        }
        RealnameButton * btn = [[RealnameButton alloc]initWithFrame:CGRectMake(JN_HH(15), h - JN_HH(20), SCREEN_WIDTH - JN_HH(30), JN_HH(80)) image:_imageArrays[i] selImage:_selImageArrays[i] title:_titleArrays[i] describe:_describeArrays[i]];
        if (i == 0 ) {
            [btn setH:120];
            [btn setStyle:1];
            [btn setText:@"某某"];
            if ([self.model.user_status integerValue]  == 1){
                btn.selected = YES;
            }
        }
        btn.tag = 200 +i ;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        h += btn.height + JN_HH(10);
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 200) {
        if (!btn.selected) {
            [self popControllerwithstr:@"RealNameViewController" title:@"实名认证"];
            return ;
        }
    }
    btn.selected = !btn.selected;
}

@end
