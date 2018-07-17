//
//  RealNameViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RealNameViewController.h"

@interface RealNameViewController ()
{
    UITextField * _nameField;
    UITextField * _shenfenField;
}



@end

@implementation RealNameViewController

-(void)createView
{
    [super createView];
    float y = JN_HH(30) + self.nav_h;  float j = 10;
    
    [self.view addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_xingming"))];

    _nameField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), y + JN_HH(2.5), SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"输入真实姓名" borderStyle:0];
    _nameField.backgroundColor = [UIColor clearColor];
    //    _iponeField.textColor = COLOR_WHITE;
    [self.view addSubview:_nameField];
  
    y += JN_HH(50);
    //分割线
    [self.view addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];

    [self.view addSubview:JnImageView(CGRectMake(JNVIEW_X0 , y, JN_HH(44), JN_HH(44)), MYimageNamed(@"dl_shengfengzheng"))];

    _shenfenField = [UITextField TextFieldWithframe:CGRectMake(JNVIEW_X(44), y + JN_HH(3), SCREEN_WIDTH - JNVIEW_W(44), JN_HH(44)) placeholder:@"输入身份证号" borderStyle:0];
    _shenfenField.backgroundColor = [UIColor clearColor];
    _shenfenField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_shenfenField];

    y += JN_HH(50);
    //分割线
    [self.view addUnderscoreWihtColor:DIVIDER_COLOR dividerFrame:CGRectMake(JNVIEW_X0, y - j, SCREEN_WIDTH - JNVIEW_W(0), 1)];

    y += JN_HH(20);

    UIButton * logBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, y, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(40)), @"下一步", JN_HH(15.5), COLOR_WHITE, COLOR_A1, 1, self, @selector(nextClick), 0);
    JNViewStyle(logBtn, JN_HH(20), nil, 0);
    [self.view addSubview:logBtn];


}

-(void)nextClick
{
    [Listeningkeyboard endEditing];
    if (_nameField.text.length == 0) {
        [MYAlertController showTitltle:@"姓名不能为空"];
        return ;
    }
    if (_shenfenField.text.length !=18 && _shenfenField.text.length != 15) {
        [MYAlertController showTitltle:@"身份证输入有误"];
        return ;
    }
    [self postdownDatas:@"/user/Profile/setAuthentication" withdict:@{@"name":_nameField.text,@"idnumber":_shenfenField.text} index:1];

}
-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
            [self popControllerwithstr:@"NickNameViewController" title:@"修改昵称"];
    }
}

@end
