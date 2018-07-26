//
//  MoneySignViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MoneySignViewController.h"

@interface MoneySignViewController ()

@property(nonatomic,copy)NSString * species;

@property(nonatomic,copy)NSString * passWord;

@property(nonatomic,copy)NSString * passWordSign;

@property(nonatomic,copy)NSString * sign;

@end

@implementation MoneySignViewController

-(instancetype)initWithNavTitle:(NSString *)str species:(NSString *)species passWord:(NSString *)passWord sign:(NSString *)sign
{
    self = [super initWithNavTitle:str];
    if (self) {
        self.species = species;
        self.passWord = passWord;
        self.sign = sign;
        return self;
    }

    return nil;
}


-(void)createView
{
    float h = self.nav_h;
    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(70)), COLOR_A1)];
    [self.view addSubview:JnLabel(CGRectMake(JN_HH(15), h + JN_HH(10), SCREEN_WIDTH, JN_HH(25)), @"1.以下系统生成的加密字符串,用户生成私钥匙.", JN_HH(13), COLOR_WHITE, 0)];
    [self.view addSubview:JnLabel(CGRectMake(JN_HH(15), h + JN_HH(35), SCREEN_WIDTH, JN_HH(25)), @"2.加密字符串只保存本地手机,请务必妥善保管!", JN_HH(13), COLOR_WHITE, 0)];
    h += JN_HH(80);

    [self.view addSubview:JnUIView(CGRectMake(JN_HH(15), h , SCREEN_WIDTH - JN_HH(30), CGSCREEN_HEIGHT() - h - JN_HH(170) ), COLOR_WHITE)];

    UILabel * titleLabel = JnLabelType(CGRectMake(JN_HH(30), h + JN_HH(10), SCREEN_WIDTH - JN_HH(60), CGSCREEN_HEIGHT() - h - JN_HH(190)), UILABEL_2, self.passWord, 0);
    [self.view addSubview:titleLabel];
    titleLabel.numberOfLines = 0 ;

    h = CGSCREEN_HEIGHT()  - JN_HH(160);

    UIButton * loginBtn1 = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"复制", JN_HH(15.5), COLOR_A1, COLOR_WHITE, 1, self, @selector(fuzhiClick:), 2);
    [loginBtn1 setTitle:@"已复制" forState:UIControlStateSelected];
    JNViewStyle(loginBtn1, JN_HH(17.5), COLOR_A1, 1);

    [self.view addSubview:loginBtn1];

//    h += JN_HH(50);
//
//    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"查看私钥", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(loginClick:), 2);
//    JNViewStyle(loginBtn, JN_HH(17.5), nil, 1);
//    [self.view addSubview:loginBtn];

    h += JN_HH(50);

    UIButton * loginBtn2 = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"添加钱包", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(tianjiaClick:), 2);
    JNViewStyle(loginBtn2, JN_HH(17.5), nil, 1);
    [self.view addSubview:loginBtn2];

    [ETHManager createKeyWithPassword:self.sign account:self.passWord responseCallback:^(id responseData)
     {
         titleLabel.text = responseData;
     }];

}

//-(void)loginClick:(UIButton *)btn
//{
//
//}

-(void)fuzhiClick:(UIButton *)btn
{
    if (btn.selected) {
        return ;
    }
    btn.selected = YES;
    [_passWord pasteboard];
    [MYAlertController showNavViewWith:@"复制成功"];

}


-(void)tianjiaClick:(UIButton *)btn
{
//    [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"生成私钥中" Style:0 withBlock:^{
//        NSLog(@"adsfasdfsdafsdaf");
//       // [MYAlertController  showTitltle:@"密码输入有误"];
//    }];


    [ETHManager createKeyWithPassword:self.sign account:self.passWord responseCallback:^(id responseData)
     {
         NSLog(@"------%@-------",responseData);
         self.passWordSign = responseData;

         NSDictionary * dict = [self.passWord dictionaryWithJson];
           [self postdownDatas:@"/transfer/wallet/bindAddress" withdict:@{@"address":dict[@"address"],@"coin_species":self.species} index:1];
         [MyActivityIndicatorViewManager remove];
     }];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        [[CurrencyManager sharedInstance]Initialize];
        [MyUserDefaultsManager setJNObject:self.passWordSign forkey:[MyUserDefaultsManager readAddressSign]];  // 保存私钥

        [MyUserDefaultsManager saveKeychainValue:self.passWordSign key:[MyUserDefaultsManager readAddressSign]];

        [MyUserDefaultsManager setJNObject:self.passWord forkey:[MyUserDefaultsManager readAddressBi]]; //保存加密文件
          [MyUserDefaultsManager saveKeychainValue:self.passWord key:[MyUserDefaultsManager readAddressBi]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
