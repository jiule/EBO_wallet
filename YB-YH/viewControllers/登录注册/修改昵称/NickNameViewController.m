//
//  NickNameViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "NickNameViewController.h"
#import "RootViewController.h"

@interface NickNameViewController ()
{
    UITextField * _nameField;
}
@end

@implementation NickNameViewController

-(void)createNavView
{
    [super createNavView];
    [[self.navView returnBtn]removeFromSuperview];
}


-(void)createView
{
    [super createView];
    float y = JN_HH(30) + self.nav_h;  float j = 10;

    [self.view addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_xingming"))];

    _nameField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), y + JN_HH(2), SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"输入昵称" borderStyle:0];
    _nameField.backgroundColor = [UIColor clearColor];
    //    _iponeField.textColor = COLOR_WHITE;
    [self.view addSubview:_nameField];

    y += JN_HH(50);
    [self.view addUnderscoreWihtColor:DIVIDER_COLOR1 dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];
    y += JN_HH(20);

    UIButton * logBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, y, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(40)), @"确认昵称", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(nextClick), 0);
    JNViewStyle(logBtn, JN_HH(20), nil, 0);
    [self.view addSubview:logBtn];

    [self.view addSubview:JnButtonColorIndexSize(CGRectMake(SCREEN_WIDTH - JNVIEW_X(120), SCREEN_HEIGHT - self.tab_h - JN_HH(60), JN_HH(105), JN_HH(30)), @"跳过此步骤", JN_HH(14.5), COLOR_A1, [UIColor clearColor], 2, self, @selector(nextClick), 0)];
     [self.view addSubview:JnButtonImageTag(CGRectMake(SCREEN_WIDTH - JNVIEW_X(10), SCREEN_HEIGHT - self.tab_h - JN_HH(60) + JN_HH(7), JN_HH(10), JN_HH(16)), MYimageNamed(@"dl_tiaoguo"), self, @selector(nextClick), 0)];

}

-(void)nextClick
{
    [Listeningkeyboard endEditing];
    if (_nameField.text.length < 2) {
        [MYAlertController showTitltle:@"昵称太短"];
        return;
    }
    [self postdownDatas:@"user/Profile/userInfo" withdict:@{@"nickname":_nameField.text} index:1];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
             [[RootViewController sharedInstance]loginOK];
        //    [self popControllerwithstr:@"LoginValidationViewController" title:@"安全认证"];
    }
}

@end
