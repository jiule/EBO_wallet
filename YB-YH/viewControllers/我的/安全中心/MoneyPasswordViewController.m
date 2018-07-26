//
//  MoneyPasswordViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MoneyPasswordViewController.h"

@interface MoneyPasswordViewController ()
{
    UITextField * _yanzhengField;
    UIButton * _yuyinBtn;
    UITextField * _passWorfField;
        int  _timerIndex;
}
@property(nonatomic,assign)NSTimer * timer;
@end

@implementation MoneyPasswordViewController

-(void)createView
{
    float h =  self.nav_h + JN_HH(10); float jian = JN_HH(50);

    [self.view addSubview:JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(150)), COLOR_WHITE)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"手机号", 0)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(20), jian), 2, [NSString userIphoneHaoma:self.model.mobile], 2)];
    h += jian;
    [self.view addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH , 1)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"验证码", 0)];

    _yanzhengField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(70), h + JN_HH(5), SCREEN_WIDTH - JNVIEW_W(190), JN_HH(44)) placeholder:@"输入验证码" borderStyle:0];
    _yanzhengField.keyboardType = UIKeyboardTypeNumberPad;
    _yanzhengField.backgroundColor = [UIColor clearColor];
    _yanzhengField.clearButtonMode = UITextFieldViewModeNever;
    [self.view addSubview:_yanzhengField];

    _yuyinBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH - JNVIEW_X(120), h + JN_HH(7.5) + JN_HH(5), JN_HH(120), JN_HH(30)), @"短信验证码", 0, self, @selector(yuyinClick:));
    [_yuyinBtn titleLabel].font = [UIFont systemFontOfSize:JN_HH(13.5)];
    JNViewStyle(_yuyinBtn, JN_HH(15), COLOR_A1, 1);
    //_yuyinBtn.backgroundColor = COLOR_WHITE;
    [self.view addSubview:_yuyinBtn];
    h += jian;
    [self.view addUnderscoreWihtFrame:CGRectMake(0, h - 1, SCREEN_WIDTH , 1)];
    [self.view addSubview:JnLabelType(CGRectMake(JNVIEW_X0, h, 100, jian), 2, @"资金密码", 0)];

    _passWorfField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(70), h + JN_HH(5), SCREEN_WIDTH - JNVIEW_W(90), JN_HH(44)) placeholder:@"请输入6位数字密码" borderStyle:0];
    _passWorfField.keyboardType = UIKeyboardTypeNumberPad;
    _passWorfField.backgroundColor = [UIColor clearColor];
    _passWorfField.clearButtonMode = UITextFieldViewModeNever;
    [self.view addSubview:_passWorfField];

    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0,h + JN_HH(180), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(35)), @"确定", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(loginClick), 2);
    JNViewStyle(loginBtn, JN_HH(17.5), nil, 1);
    [self.view addSubview:loginBtn];

}

-(void)yuyinClick:(UIButton *)btn
{

//    [btn setTitle:@"验证码已发送" forState:0];

    [self postdownDatas:@"user/VerificationCode" withdict:@{@"username":self.model.mobile} index:2];
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

-(void)loginClick
{
    [self postdownDatas:@"/user/Profile/setTransPwd" withdict:@{@"verification_code":@"213456",@"transpwd":_passWorfField.text} index:1];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        [MYAlertController showTitltle:@"设置成功" selButton:^(MYAlertController *AlertController, int index) {
            self.model.transpwd = [NSNumber numberWithInt:1];
            FANHUI_JIUSHITU ;
        } ];

    }else {
        [MYAlertController showNavViewWith:@"验证码已经发送"];
        _yuyinBtn.enabled = NO;
        _timerIndex = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [_yuyinBtn setTitle:[NSString stringWithFormat:@"%02ds",_timerIndex] forState:0];
        [_timer setFireDate:[NSDate distantPast]];
    }
}


@end
