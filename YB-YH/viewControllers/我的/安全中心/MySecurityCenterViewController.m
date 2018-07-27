//
//  MySecurityCenterViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MySecurityCenterViewController.h"
#import "LAContextManger.h"

@interface MySecurityCenterViewController ()
XH_ATTRIBUTE(strong, LAContextManger, lamanager);
@end

@implementation MySecurityCenterViewController

//-(LAContextManger *)lamanager{
//    if (!_lamanager) {
//        _lamanager = [LAContextManger Initialize];
//    }
//    return _lamanager;
//}

-(void)createView{
    [super createView];
    
    float h =  self.nav_h + JN_HH(10); float jian = JN_HH(50);
    
    [self.view addSubview:JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(150)), COLOR_WHITE)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"手机号", 0)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(20), jian), 2, [NSString userIphoneHaoma:self.model.mobile], 2)];
    h += jian;
    [self.view addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH, 1)];
    
    
    UIButton * mimaBtn = JnButtonImageTag(CGRectMake(SCREEN_WIDTH * 0.5, h, SCREEN_WIDTH * 0.5, jian), MYimageNamed(@""), self, @selector(mimaBtnClick), 0);
    [self.view addSubview:mimaBtn];
    
    [mimaBtn addSubview:JnImageView(CGRectMake(SCREEN_WIDTH * 0.5 - JNVIEW_W(15),  JN_HH(3), JN_HH(44), JN_HH(44)), MYimageNamed(@"jiantou_H1_88"))];
    [mimaBtn addSubview:JnLabelType(CGRectMake(0, 0, SCREEN_WIDTH * 0.5 - JNVIEW_X(20), jian), 5, @"重置", 2)];
    
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"资金密码", 0)];
    h += jian;
    [self.view addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH , 1)];
    
    
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"指纹解锁", 0)];
    UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, h, SCREEN_WIDTH * 0.5, jian)];
    [sw setY: h + (jian - sw.height)/2];
    [sw setX: SCREEN_WIDTH - JNVIEW_X0 - sw.width];
    [self.view addSubview:sw];
    [sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
    h += jian;
    //    [self.view addUnderscoreWihtFrame:CGRectMake(, h - 1, SCREEN_WIDTH ), 1)];
}

#pragma mark----密码重置被点击
-(void)mimaBtnClick{
    [self popControllerwithstr:@"MoneyPasswordViewController" title:@"资金密码"];
}
-(void)swClick:(UISwitch *)sw{
    [LAContextManger sharedInstance].isopen = sw.on;
}
-(void)zhiwenBtnClick{
    
}

@end
