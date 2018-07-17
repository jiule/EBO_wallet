//
//  MoneyViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MoneyViewController.h"
#import "MoneySignViewController.h"

@interface MoneyViewController ()

@property(nonatomic,retain)UITextField * textFiled;

@property(nonatomic,copy)NSString * name;

@end

@implementation MoneyViewController

-(instancetype)initWithNavTitle:(NSString *)str name:(NSString *)name
{
    self = [super initWithNavTitle:str];
    if (self) {
        _name = name;
        return self;
    }
    return nil;
}


-(void)createView
{
    float h = self.nav_h;
    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(70)), COLOR_A1)];
    [self.view addSubview:JnLabel(CGRectMake(JN_HH(15), h + JN_HH(10), SCREEN_WIDTH, JN_HH(25)), @"1.密码用于生成私钥,强度非常重要", JN_HH(14), COLOR_WHITE, 0)];
    [self.view addSubview:JnLabel(CGRectMake(JN_HH(15), h + JN_HH(35), SCREEN_WIDTH, JN_HH(25)), @"2.我们不存储密码,也无法帮您找回,请妥善保管", JN_HH(14), COLOR_WHITE, 0)];
    h += JN_HH(90);
    [self.view addSubview:JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(100)), COLOR_WHITE)];
    [self.view addSubview:JnImageView(CGRectMake(JN_HH(15), h + JN_HH(3), JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_dl"))];
    [self.view addSubview:JnLabelType(CGRectMake(JN_HH(70) + JN_HH(0), h, SCREEN_WIDTH - JN_HH(100), JN_HH(50)), UILABEL_1, _name, 0)];
    h += JN_HH(50);
    [self.view addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH, 1)];
    [self.view addSubview:JnImageView(CGRectMake(JN_HH(15), h + JN_HH(3), JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_suo"))];
    _textFiled = [UITextField TextFieldPassWordWithframe:CGRectMake(JN_HH(70), h + JN_HH(10), SCREEN_WIDTH - JN_HH(120), JN_HH(30)) placeholder:@"钱包密码 6-16位数字与字母组合" borderStyle:0];
    [self.view addSubview:_textFiled];

    h += JN_HH(80);
    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"创建钱包", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(loginClick:), 2);
    JNViewStyle(loginBtn, JN_HH(17.5), nil, 1);

    [self.view addSubview:loginBtn];
}

-(void)loginClick:(UIButton *)btn
{
    if (_textFiled.text.length < 6 || _textFiled.text.length >16) {
        [MYAlertController showTitltle:@"请输入6016位数字与字母组合的密码"];
        return ;
    }

    if (btn.selected) {
        return ;
    }
     btn.selected = YES;
    [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"创建账户中" Style:0];

    [ETHManager createAccountPassword:_textFiled.text responseCallback:^(id responseData) {
        [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"创建账户中" Style:5];
        MoneySignViewController * vc = [[MoneySignViewController alloc]initWithNavTitle:_name species:[CurrencyManager readspeciesWithName:BI_A1] passWord:[NSString stringWithFormat:@"%@",responseData] sign:self.textFiled.text];
        [self.navigationController pushViewController:vc animated:YES];
        btn.selected = NO;
    }];

}


@end
