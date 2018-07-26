//
//  MyAboutViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyAboutViewController.h"
#import "BaseView.h"

@interface MyAboutViewController ()

@end

@implementation MyAboutViewController

-(void)createNavView
{
    [super createNavView];
}

-(void)createView
{
    [super createView];
    [self.view addSubview:JnImageView(CGRectMake(SCREEN_WIDTH * 0.5 - JN_HH(40), self.nav_h + JN_HH(30),JN_HH(80) , JN_HH(80)), MYimageNamed(@"sy_ebog"))];

    float h =  JN_HH(205) + JN_HH(10); float jian = JN_HH(50);

    NSArray * array = @[@"产品反馈",@"币币交易",@"版本介绍"];
    for (int  i = 0;  i < array.count;  i++ ) {
        BaseView * baview = [[BaseView alloc]initWithFrame:CGRectMake(0, h + jian * i, SCREEN_WIDTH, jian) leftName:nil title:array[i] rightImageName:YES];
        baview.backgroundColor = COLOR_WHITE ;
        [baview.titleLabel setX:JNVIEW_X0];
        [baview.rightBtn setX:SCREEN_WIDTH - JN_HH(59)];
        baview.tag = 100 + i;
        [baview addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            [self didView:(BaseView *)view];
        }];
        [baview addUnderscoreWihtFrame:CGRectMake(0, jian - 1, SCREEN_WIDTH, 1)];
        [self.view addSubview:baview];
        if (i == 2) {
            [baview addSubview:JnLabelType(CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5 - JN_HH(59), jian), 2, @"1.01", 2)];
        }
    }
}

-(void)didView:(BaseView *)view{

}

@end
