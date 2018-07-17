//
//  RetrievePasswordViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/6.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RetrievePasswordViewController.h"

@interface RetrievePasswordViewController ()
{
    UITextField * _iponeField;
    UITextField * _passWordField;

    UITextField * _yanzhengField;
    UIButton * _yuyinBtn;
}

@property(nonatomic,retain)UIView *upView;
@property(nonatomic,retain)UIView *downView;
@end



@implementation RetrievePasswordViewController

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [Listeningkeyboard endEditing];
//}

-(void)createNavView
{
    [super createNavView];
//    self.navView.backgroundColor = [UIColor clearColor];
}

-(void)createView
{
    _downView = JnUIView(CGRectMake(0, JN_HH(15) + self.nav_h, SCREEN_WIDTH, JN_HH(50) * 3), COLOR_WHITE);
    [self.view addSubview:_downView];

    [_downView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , JN_HH(6), JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_shouji"))];

    _iponeField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), 0, SCREEN_WIDTH - JNVIEW_W(44), JN_HH(50)) placeholder:@"输入手机号码" borderStyle:0 placeholderColor:COLOR_B3];
    _iponeField.keyboardType = UIKeyboardTypeNumberPad;
    _iponeField.backgroundColor = [UIColor clearColor];
    _iponeField.textColor = COLOR_B2;
    [_downView addSubview:_iponeField];

    [_downView addSubview:JnUIView(CGRectMake(0, JN_HH(50), SCREEN_WIDTH, 1), DIVIDER_COLOR1)];
    _yanzhengField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44),  JN_HH(56), SCREEN_WIDTH - JNVIEW_W(164), JN_HH(44)) placeholder:@"输入验证码" borderStyle:0 placeholderColor:COLOR_B3];
    _yanzhengField.keyboardType = UIKeyboardTypeNumberPad;
    _yanzhengField.backgroundColor = [UIColor clearColor];
      _yanzhengField.textColor = COLOR_B2;
    [_downView addSubview:_yanzhengField];

    _yuyinBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH - JNVIEW_X(120),  JN_HH(56) + JN_HH(3.5) , JN_HH(120), JN_HH(30)), @"获取验证码", 1, self, @selector(yuyinClick:));
    JNViewStyle(_yuyinBtn, JN_HH(15), Button_TEXT_TEXTCOLOR, 1);
    [_downView addSubview:_yuyinBtn];

    [_downView addSubview:JnUIView(CGRectMake(0, JN_HH(100), SCREEN_WIDTH , 1),DIVIDER_COLOR1 )];

    [_downView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , JN_HH(106), JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_suo"))];
    _passWordField = [UITextField TextFieldPassWordWithframe:CGRectMake(JNVIEW_X(44), JN_HH(106), SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"请输入密码不小于6位" borderStyle:0 placeholderColor:TEXTVIEW_PLICEHOLDER_COLOR];
    _passWordField.backgroundColor = [UIColor clearColor];
    _passWordField.textColor = COLOR_B2;
    [_downView addSubview:_passWordField];
 //   [_downView addSubview:JnUIView(CGRectMake(JNVIEW_X0, JN_HH(140), SCREEN_WIDTH - JNVIEW_W(0), 1), COLOR_T1)];

    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, JN_HH(180), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"找回密码", JN_HH(15.5), COLOR_WHITE,Button_NORMAL_BACKCOLOR, 1, self, @selector(loginClick), 2);
    JNViewStyle(loginBtn, JN_HH(17.5), nil, 0);
    [_downView addSubview:loginBtn];

}

//-(void)addListeningkeyboard
//{
//    JNWeakSelf(self);
//    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h)
//     {
//         weakself.upView.alpha = 0;
//         weakself.downView.frame = CGRectMake(0,SCREEN_HEIGHT * 0.48 + self.nav_h - h , SCREEN_WIDTH, self->_downView.height );
//     } keyboard:^(CGFloat h) {
//         weakself.upView.alpha = 1;
//         weakself.downView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.52 + self.nav_h, SCREEN_WIDTH, self->_downView.height);
//     }];
//}


#pragma mark----语音按钮被点击
-(void)yuyinClick:(UIButton *)btn
{
    [btn setTitle:@"验证码已发送" forState:0];
    [self postdownDatas:@"/user/VerificationCode" withdict:@{@"username":_iponeField.text} index:1];
}

-(void)loginClick
{
    [self postdownDatas:@"/user/Profile/changePassword" withdict:@{@"username":_iponeField.text,@"password":_passWordField.text,@"verification_code":_yanzhengField.text } index:501 type:0];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
    {
        if(index == 1){
            _iponeField.userInteractionEnabled = NO;
            [MYAlertController showNavViewWith:@"验证码已发送"];
        }else if(index == 501)
        {
            NSLog(@"222222------%@=====%@",responseDict,responseDict[@"msg"]);
            [MYAlertController showTitltle:@"设置成功" selButton:^(MYAlertController *AlertController, int index) {
                FANHUI_JIUSHITU ;
            }];


        }else if(index == 2)
        {
            [MYAlertController showTitltle:@"注册成功" selButton:^(MYAlertController *AlertController, int index) {
                FANHUI_JIUSHITU ;
            }];
        }
    }

@end
