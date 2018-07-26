//
//  LoginViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/6.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "LoginViewController.h"
#import "ETHManager.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    UITextField * _iponeField;
    UITextField * _passWordField;
}

@property(nonatomic,retain)UIView *upView;
@property(nonatomic,retain)UIView *downView;

@end

@implementation LoginViewController

-(void)createNavView
{}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  //  [[Listeningkeyboard sharedInstance] removelisteningblockcompletion];
}



-(void)createView
{
    [super createView];
    self.view.backgroundColor = COLOR_WHITE;
   // [self.view addSubview:JnImageView(self.view.bounds, MYimageNamed(@"bg_login"))];

    _upView = JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH,SCREEN_HEIGHT * 0.52 - self.nav_h ), [[UIColor clearColor] colorWithAlphaComponent:0]);
    [self.view addSubview:_upView];
    [_upView addSubview:JnImageView(CGRectMake(SCREEN_WIDTH * 0.5 - JN_HH(115), 0, JN_HH(230), JN_HH(230)), MYimageNamed(@"dl_EBOlogo"))];

    _downView = JnUIView(CGRectMake(0, SCREEN_HEIGHT * 0.52 , SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - SCREEN_HEIGHT * 0.4), _upView.backgroundColor);
    [self.view addSubview:_downView];

    [_downView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , 0, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_shouji"))];

    _iponeField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), 0, SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"输入手机号码" borderStyle:0 placeholderColor:COLOR_B3];
    _iponeField.keyboardType = UIKeyboardTypeNumberPad;
    _iponeField.backgroundColor = [UIColor clearColor];
    _iponeField.textColor = COLOR_B2;
    [_downView addSubview:_iponeField];

    [_downView addSubview:JnUIView(CGRectMake(JNVIEW_X0, JN_HH(40), SCREEN_WIDTH - JNVIEW_W(0), 1), DIVIDER_COLOR1)];

    [_downView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , JN_HH(50), JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_suo"))];
    _passWordField = [UITextField TextFieldPassWordWithframe:CGRectMake(JNVIEW_X(44), JN_HH(50), SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"请输入密码不小于6位" borderStyle:0 placeholderColor:COLOR_B3];
    _passWordField.backgroundColor = [UIColor clearColor];
    _passWordField.textColor = COLOR_B2;
    _passWordField.delegate = self;
    [_downView addSubview:_passWordField];

    [_downView addSubview:JnUIView(CGRectMake(JNVIEW_X0, JN_HH(90), SCREEN_WIDTH - JNVIEW_W(0), 1), DIVIDER_COLOR1)];

    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, JN_HH(130), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"登录", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(loginClick), 2);
    JNViewStyle(loginBtn, JN_HH(17.5), nil, 1);
    [_downView addSubview:loginBtn];

    [_downView addSubview:JnButtonColorIndexSize(CGRectMake(JN_HH(65), JN_HH(200), JN_HH(100), JN_HH(20)), @"忘记密码?", JN_HH(15.5), COLOR_T1, _downView.backgroundColor, 0, self, @selector(retrievePasswordClick), 2)];

    [_downView addSubview:JnButtonColorIndexSize(CGRectMake(SCREEN_WIDTH - JN_HH(110), JN_HH(200), JN_HH(45), JN_HH(20)), @"注册", JN_HH(15.5), COLOR_T1, _downView.backgroundColor, 2, self, @selector(retrieveClick), 2)];

    _iponeField.text = @"15399999998";
    _passWordField.text = @"qqqqqq";
}

-(void)addListeningkeyboard
{
    JNWeakSelf(self);
    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h)
     {
         weakself.upView.alpha = 0;
         weakself.downView.frame = CGRectMake(0,SCREEN_HEIGHT * 0.48 + weakself.nav_h - h , SCREEN_WIDTH, weakself.downView.height );
     } keyboard:^(CGFloat h) {
         weakself.upView.alpha = 1;
         weakself.downView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.5, SCREEN_WIDTH, weakself.downView.height);
     }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@",[NSThread currentThread]);
//    [ETHManager sharedInstance];
//
//    [ETHManager createAccountPassword:@"123456" responseCallback:^(id responseData) {
//        NSLog(@"%@",responseData);
//    }];
    [Listeningkeyboard     endEditing];
    return  ;

}
#pragma mark------登录
-(void)loginClick
{
    if (_iponeField.text.length != 11) {
        [MYAlertController showTitltle:@"账号输入错误"];
        return ;
    }
    if (_passWordField.text.length  < 6 || _passWordField.text.length > 12) {
        [MYAlertController showTitltle:@"密码输入错误"];
        return ;
    }
    [self postdownDatas:@"/user/login/login" withdict:@{@"username":_iponeField.text,@"password":_passWordField.text,@"device_type":@"iphone",@"jpush_id":@"1234"} index:1 type:0];
 //   [self delegateLoginOk];
}
#pragma mark------注册
-(void)retrieveClick
{
    [self popControllerwithstr:@"RegisteredViewController" title:@"注册"];
}
#pragma mark------找回密码
-(void)retrievePasswordClick
{
    [self popControllerwithstr:@"RetrievePasswordViewController" title:@"忘记密码"];
}

#pragma MARK----通知代理登录成功
-(void)delegateLoginOk
{
    if ([_delegate respondsToSelector:@selector(loginOK)]) {
        [_delegate loginOK] ;
    }else
    {
        FANHUI_JIUSHITU ;
    }
}

#pragma mark----注册按钮点击
-(void)registeredClick
{
    [self popControllerwithstr:@"RegisteredViewController" title:@"注册"];
}

#pragma mark-----找回密码
-(void)RetrievePasswordViewClick
{
    [self popControllerwithstr:@"RetrievePasswordViewController" title:@"找回密码"];
}

#pragma mark----输入框的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loginClick];
    return YES ;
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if  (index == 1){
        NSLog(@"%@",responseDict);
        self.model = [[PersonalModel alloc]initWithDict:responseDict[@"user"]];
        [MyNetworkingModel sharedInstance].token = responseDict[@"token"];
        if ([self.model.user_status integerValue]  == 1) {
              [self delegateLoginOk];
        }else {
            [self popControllerwithstr:@"RealNameViewController" title:@"实名认证"];
        }
    }
}

@end
