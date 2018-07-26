//
//  RegisteredViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/6.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RegisteredViewController.h"
#import "RegisteredObj.h"

@interface RegisteredViewController ()
{
    UITextField * _iponeField;
    UITextField * _yanzhengField;
    UITextField * _passWordField;
    UITextField * _passWordQueField;
    UITextField * _yaoField;
    UIButton * _yuyinBtn;
    int  _timerIndex;
}

@property(nonatomic,assign)NSTimer * timer;

@end

@implementation RegisteredViewController

-(void)createView
{
    self.view.backgroundColor = COLOR_WHITE;
    float y = JN_HH(40);  float j = 10;
    [self.view addSubview:JnLabel(CGRectMake(0, self.nav_h + y, SCREEN_WIDTH, JN_HH(40)), BI_A0STR1(@"欢迎使用", @" 钱包"), JN_HH(17.5), COLOR_A1, 1)];
    [super createView];


    [self.baseScollView setY:self.nav_h + JN_HH(80)];

    self.baseScollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    [self.baseScollView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_shouji"))];
    [self.baseScollView addSubview:JnLabel(CGRectMake(JNVIEW_X(40), y, JN_HH(40), JN_HH(44)), @"+86 ", JN_HH(16.5), COLOR_A1, 1)];
    _iponeField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(84), y, SCREEN_WIDTH - JNVIEW_W(84), JN_HH(44)) placeholder:@"输入手机号码" borderStyle:0];
    _iponeField.keyboardType = UIKeyboardTypeNumberPad;
    _iponeField.backgroundColor = [UIColor clearColor];
    [self.baseScollView addSubview:_iponeField];

    y += JN_HH(50);
    //分割线
    [self.baseScollView addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];

    _yanzhengField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), y, SCREEN_WIDTH - JNVIEW_W(164), JN_HH(44)) placeholder:@"输入验证码" borderStyle:0];
    _yanzhengField.keyboardType = UIKeyboardTypeNumberPad;
    _yanzhengField.backgroundColor = [UIColor clearColor];
    _yanzhengField.clearButtonMode = UITextFieldViewModeNever;
    [self.baseScollView addSubview:_yanzhengField];

    _yuyinBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH - JNVIEW_X(120), y + JN_HH(7.5) - j * 0.5, JN_HH(120), JN_HH(30)), @"短信验证码", 0, self, @selector(yuyinClick:));
    [_yuyinBtn titleLabel].font = [UIFont systemFontOfSize:JN_HH(13.5)];
    JNViewStyle(_yuyinBtn, JN_HH(15), nil, 0);
    [self.baseScollView addSubview:_yuyinBtn];

    y += JN_HH(50);
    //分割线
    [self.baseScollView addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(130), 1)];

   //添加密码图标
    [self.baseScollView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_suo"))];
    _passWordField = [UITextField TextFieldPassWordWithframe:CGRectMake(JNVIEW_X(44), y, SCREEN_WIDTH - JNVIEW_W(84), JN_HH(44)) placeholder:@"设置密码6-12位数字与字母组合" borderStyle:0];
    _passWordField.backgroundColor = [UIColor clearColor];
  //  _passWordField.textColor = COLOR_WHITE;
    [self.baseScollView addSubview:_passWordField];

    y += JN_HH(50);
    //分割线
    [self.baseScollView addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];

    _passWordQueField = [UITextField TextFieldPassWordWithframe:CGRectMake(JNVIEW_X(44), y, SCREEN_WIDTH - JNVIEW_W(84), JN_HH(44)) placeholder:@"再次输入登录密码" borderStyle:0];
    _passWordQueField.backgroundColor = [UIColor clearColor];
   // _passWordQueField.textColor = COLOR_WHITE;
    [self.baseScollView addSubview:_passWordQueField];
    y += JN_HH(50);
    //分割线
    [self.baseScollView addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];
    [self.baseScollView addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_yaoqing"))];
    _yaoField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), y, SCREEN_WIDTH - JNVIEW_W(84), JN_HH(44)) placeholder:@"输入邀请码(选填)" borderStyle:0];
    _yaoField.backgroundColor = [UIColor clearColor];
 //   _yaoField.keyboardType = UIKeyboardTypeNumberPad;
 //   _yaoField.textColor = COLOR_WHITE;
    [self.baseScollView addSubview:_yaoField];
    y += JN_HH(50);
    //分割线
    [self.baseScollView addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];

    y += JN_HH(25);
    UIButton * registeredBtn = JnButtonTextType(CGRectMake(JNVIEW_X0, y, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"注册", 0, self, @selector(registeredClick));
    JNViewStyle(registeredBtn, JN_HH(17.5), nil, 0);
    [self.baseScollView addSubview:registeredBtn];

    y += JN_HH(35) + JN_HH(23);
    [self.baseScollView addSubview:JnButtonImageTag(CGRectMake(SCREEN_WIDTH * 0.5 - JN_HH(81), y, JN_HH(163), JN_HH(13)), MYimageNamed(@"dl_xieyi"), self, @selector(xieyiClick), 1)];
}


#pragma mark----语音按钮被点击
-(void)yuyinClick:(UIButton *)btn
{
    if (self->_iponeField.text.length != 11) {
        [MYAlertController showTitltle:@"手机号输入错误" selButton:^(MYAlertController *AlertController, int index) {
            [self->_iponeField becomeFirstResponder];
        }];
        return ;
    }

//    [btn setTitle:@"验证码已发送" forState:0];
    [self postdownDatas:@"user/VerificationCode" withdict:@{@"username":_iponeField.text} index:1];
}

-(void)updateTimer
{
    if (_timerIndex > 0) {
        _timerIndex--;
        [_yuyinBtn setTitle:[NSString stringWithFormat:@"%02ds",_timerIndex] forState:0];
    }else
    {
        [_timer setFireDate:[NSDate distantFuture]];
        [_yuyinBtn setTitle:@"重试" forState:0];
        _yuyinBtn.enabled = YES ;
    }
}



-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if(index == 1){
        _iponeField.userInteractionEnabled = NO;
        [MYAlertController showNavViewWith:@"验证码已发送"];

        _yuyinBtn.enabled = NO;
        _timerIndex = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [_yuyinBtn setTitle:[NSString stringWithFormat:@"%02ds",_timerIndex] forState:0];
        [_timer setFireDate:[NSDate distantPast]];
    }else if(index == 501)
    {
        NSLog(@"222222------%@=====%@",responseDict,responseDict[@"msg"]);


    }else if(index == 2)
    {
        [MYAlertController showTitltle:@"注册成功" selButton:^(MYAlertController *AlertController, int index) {
//            [ RegisteredObj sharedInstance].iphone = self->_iponeField.text;
//            [ RegisteredObj sharedInstance].password = self->_passWordField.text;

            [self postdownDatas:@"/user/login/login" withdict:@{@"username":self->_iponeField.text,@"password":self->_passWordField.text,@"device_type":@"iphone",@"jpush_id":@"1234"} index:3 type:0];
        }];
    }else if(index == 3)
    {
        self.model = [[PersonalModel alloc]initWithDict:responseDict[@"user"]];
        [MyNetworkingModel sharedInstance].token = responseDict[@"token"];
        [self  RealNameView];
    }
}


-(void)duxucuowu:(NSError *)error index:(int)index
{
    
}


-(void)registeredClick
{
//    [self RealNameView];
//    return ;
    if (self->_iponeField.text.length != 11) {
        [MYAlertController showTitltle:@"手机号输入错误" selButton:^(MYAlertController *AlertController, int index) {
            [self->_iponeField becomeFirstResponder];
        }];
        return ;
    }
    if (self->_yanzhengField.text.length < 4) {
        [MYAlertController showTitltle:@"验证码输入错误" selButton:^(MYAlertController *AlertController, int index) {
            [self->_yanzhengField becomeFirstResponder];
        }];
        return ;
    }
    if ( ![NSString justPassword:_passWordField.text] ) {
        [MYAlertController showTitltle:@"请输入长度6-12位的密码" selButton:^(MYAlertController *AlertController, int index) {
            [self->_passWordField becomeFirstResponder];
        } ];
        return ;
    }
    if ([self justPasswordaz:_passWordField.text]  ) {
        [MYAlertController showTitltle:@"请输入字母数字组合的密码" selButton:^(MYAlertController *AlertController, int index) {
            [self->_passWordField becomeFirstResponder];
        } ];
        return ;
    }
    if ([self justPasswordnum:_passWordField.text]  ) {
        [MYAlertController showTitltle:@"请输入字母数字组合的密码" selButton:^(MYAlertController *AlertController, int index) {
            [self->_passWordField becomeFirstResponder];
        } ];
        return ;
    }
    if (![_passWordField.text isEqual:_passWordQueField.text]) {
        [MYAlertController showTitltle:@"两次输入的密码不一致" selButton:^(MYAlertController *AlertController, int index) {
            [self->_passWordQueField becomeFirstResponder];
        }];
        return ;
    }
    [Listeningkeyboard endEditing];
    if (_yaoField.text.length > 0) {

        if (_yanzhengField.text.length != 4 ) {
            [MYAlertController showTitltle:@"邀请码输入格式错误"];
                    return ;
        }
        [self postdownDatas:@"user/login/regist" withdict:@{@"username":_iponeField.text,@"password":_passWordField.text,@"verification_code":_yanzhengField.text,@"invite_code":_yaoField.text } index:2 type:0];
    }else {
        [self postdownDatas:@"user/login/regist" withdict:@{@"username":_iponeField.text,@"password":_passWordField.text,@"verification_code":_yanzhengField.text } index:2 type:0];
    }
  //  [self popControllerwithstr:@"LoginValidationViewController" title:@"安全验证"];
}

-(void)xieyiClick
{
    [MYAlertController showTitltle:@"协议页面还没有"];
}

-(void)RealNameView
{
    [self popControllerwithstr:@"LoginValidationViewController" title:@"安全认证"];
}

-(void)addListeningkeyboard
{
    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h) {
        [self.baseScollView setY:self.nav_h - JN_HH(20)];
        [self.navView setcolorStyle:1];
    } keyboard:^(CGFloat h) {
         [self.baseScollView setY:self.nav_h + JN_HH(80)];
         [self.navView setcolorStyle:0];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [Listeningkeyboard   endEditing];
}

- (BOOL) justPasswordaz:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
- (BOOL) justPasswordnum:(NSString *)passWord
{
    NSString *passWordRegex = @"^[0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
@end
