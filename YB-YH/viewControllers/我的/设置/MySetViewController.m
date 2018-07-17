//
//  MySetViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController ()

@property(nonatomic,retain)UISwitch * sw;

@end

@implementation MySetViewController

-(void)createView
{
    float h =  self.nav_h + JN_HH(10); float jian = JN_HH(50);
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 5, @"推送消息", 0)];

    _sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, 0, 0)];
    _sw.onTintColor  = COLOR_A1;
    [ _sw setY:jian / 2 + h - [_sw getH]/2];
    [ _sw setX:SCREEN_WIDTH - JNVIEW_X0 - [_sw getW]];
    [_sw addTarget:self action:@selector(SwClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sw];

    h += jian;
    [self.view addUnderscoreWihtFrame:CGRectMake(JNVIEW_X0, h - 1, SCREEN_WIDTH - JNVIEW_W(0), 1)];
}

-(void)SwClick:(UISwitch *)sw
{
    if (sw.isOn) {

    }else {
        
    }
}
@end
