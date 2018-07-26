//
//  RollOutViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/19.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RollOutViewController.h"
#import "UIMoneyLabel.h"
#import "IPhoneAlectView.h"
#import "RollSaomaViewController.h"
#import "JNCoinView.h"
#import "JNCoinTriangleView.h"

@interface RollOutViewController () <RollSaomaViewControllerDelegate,JNBaseViewDelegate,UITextFieldDelegate>
{
    UIMoneyLabel * _yueLabel;  //每个币中的余额

//    UITextField * _BTCField;
//    UITextField * _jiaoyiField;
    UITextField * _kuanggongField;
    UITextField * _beizuField;

    UILabel * _bizhongLabel;  //交易金额后面的币种
    UILabel * _rmbLabel;   //交换过后的人民币显示label
    UILabel * _bizhong1Label; //矿工费后面的币种

     JNCoinView * _conView;  //切换
}

@property(nonatomic,retain)    UITextField * BTCField;

@property(nonatomic,retain)    UITextField * jiaoyiField;

@end

@implementation RollOutViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self didshuaXinView];
}


-(void)createNavView
{
    [super createNavView];

    _conView = [[JNCoinView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CGNavView_20h(), 60, 44)];
    [self.navView addSubview:_conView];
    _conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
    _conView.titleLabel.textColor = COLOR_BL_3;
    _conView.imageView.image = MYimageNamed(@"选择框剪头1");

    [_conView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        JNCoinTriangleView * coinview =  [[JNCoinTriangleView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, self.nav_h, 90, 60)  selTitle:self->_conView.titleLabel.text type:2];
        coinview.delegate = self;
        [self.view.window addSubview:coinview];
    }];
}

-(void)createView
{
    [super createView];
    self.view.backgroundColor = COLOR_B6;
    float h =  self.nav_h;  float x = JN_HH(20);

    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(80)), COLOR_WHITE)];
    [self.view addSubview:JnLabelType(CGRectMake(x, h + JN_HH(10), JN_HH(100), JN_HH(20)), UILABEL_3, @"账户余额", 0)];

    _yueLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(x, h + JN_HH(30), SCREEN_WIDTH - JN_HH(60), JN_HH(40))];
    [_yueLabel setLeftFont:[UIFont systemFontOfSize:JN_HH(30)] rightFont:[UIFont systemFontOfSize:JN_HH(30)]];
    [_yueLabel setLeftTextColor:COLOR_BLACK rightColor:COLOR_BLACK];
    [_yueLabel setTextAlignment:NSTextAlignmentLeft];

    [self.view addSubview:_yueLabel];

    h += JN_HH(90);

    UIView * bgView =JnUIView(CGRectMake(0, h, SCREEN_WIDTH , JN_HH(44) * 4 + JN_HH(15)), COLOR_WHITE);
    [self.view addSubview:bgView];


    float b_h = JN_HH(10);  float b_x = JN_HH(80);  float b_w = bgView.width;
    //地址
    [bgView addSubview:JnLabelType(CGRectMake(0, b_h , b_x , JN_HH(30)), UILABEL_2, @"地址", 1)];
    [bgView addSubview:JnLabelType(CGRectMake(0, b_h + JN_HH(44) , b_x , JN_HH(30)), UILABEL_2, @"数量", 1)];
    [bgView addSubview:JnLabelType(CGRectMake(0, b_h + JN_HH(88) , b_x, JN_HH(30)), UILABEL_2, @"矿工费", 1)];

    _BTCField = JnTextFiledColor(CGRectMake(b_x, b_h , b_w - 2 * b_x - JN_HH(30), JN_HH(30)), @"输入收币地址", 0,COLOR_H1);
    _BTCField.textColor = COLOR_A1;
    _BTCField.clearButtonMode = UITextFieldViewModeNever;
    [bgView addSubview:_BTCField];

    UIButton * paiBtn = JnButtonImageTag(CGRectMake(b_w - JN_HH(15) - JN_HH(50), 0, JN_HH(44), JN_HH(44)), MYimageNamed(@"sy_zcsaoma"), self, @selector(paiBtnClick), 0);
    [bgView addSubview:paiBtn];

    b_h += JN_HH(44);
    [bgView addUnderscoreWihtFrame:CGRectMake(0, b_h - 10, SCREEN_WIDTH, 1)];

   //交易金额
    _jiaoyiField = JnTextFiledColor(CGRectMake(b_x, b_h, b_w * 0.7 - b_x - JN_HH(5), JN_HH(30)), @"交易金额", 0,COLOR_H1);
    _jiaoyiField.clearButtonMode = UITextFieldViewModeNever;
    _jiaoyiField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _jiaoyiField.textColor = COLOR_A1;
    _jiaoyiField.delegate = self ;
    [bgView addSubview:_jiaoyiField];

    _rmbLabel = JnLabelType(CGRectMake(0, b_h + 5,  SCREEN_WIDTH - JN_HH(15), JN_HH(20)), UILABEL_2,[NSString stringWithFormat:@"%@%@0.00",FUHAO_YUEDENGYU,FUHAO_RENMINGBI], 2);
    [bgView addSubview:_rmbLabel];

    b_h += JN_HH(44);
    [bgView addUnderscoreWihtFrame:CGRectMake(0, b_h - 10, SCREEN_WIDTH, 1)];

   //矿工费

//    [bgView addSubview:JNLabel(CGRectMake(b_x, b_h + JN_HH(15), b_w * 0.5 - b_x , JN_HH(30)), @"矿工费(可输入)", JN_HH(13.5), COLOR_H1, 0)];
//
//    _kuanggongField = JnTextFiledColor(CGRectMake(b_w * 0.4 , b_h + JN_HH(20), b_w * 0.6 - JN_HH(30)- b_x, JN_HH(30)), @"", 0,COLOR_H1);
//     _kuanggongField.clearButtonMode = UITextFieldViewModeNever;
//    _kuanggongField.textAlignment = NSTextAlignmentRight;
//    _kuanggongField.textColor = COLOR_A1;
//    _kuanggongField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [bgView addSubview:_kuanggongField];

    _bizhong1Label = JnLabelType(CGRectMake(SCREEN_WIDTH * 0.5, b_h , SCREEN_WIDTH * 0.5 -JN_HH(15), JN_HH(30)),UILABEL_2,[NSString stringWithFormat:@"0.00%@",self.curManager.selcurrencyModel.coin_name], 2);
    [bgView addSubview:_bizhong1Label];

    b_h += JN_HH(44);
    [bgView addUnderscoreWihtFrame:CGRectMake(0, b_h - 5, b_w, JN_HH(10))];

    //备注
    [bgView addSubview:JnLabelType(CGRectMake(0, b_h + JN_HH(10) , b_x , JN_HH(30)), UILABEL_2, @"备注", 1)];

    _beizuField = JnTextFiledColor(CGRectMake(b_x, b_h + JN_HH(10), b_w - 2 * b_x, JN_HH(30)), @"", 0,COLOR_H1);
     _beizuField.textColor = COLOR_A1;
    [bgView addSubview:_beizuField];

    b_h += JN_HH(50);
  //  [bgView addUnderscoreWihtFrame:CGRectMake(JN_HH(15), b_h - 1, b_w - JN_HH(30), 1)];

    //确认发送
    UIButton * queBtn = JnButtonTextType(CGRectMake(JNVIEW_X0, JN_HH(360), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(40)), @"确认发送", 0, self, @selector(queBtnClick));
    JNViewStyle(queBtn, JN_HH(20), nil, 0);
    [self.view addSubview:queBtn];

//    [_yueLabel setText:@"91518.01" componentsSeparatedByString:@"."];

    [self.navView insertUp];
    [self.navView addDividingLine];
    [self didshuaXinView];
}




-(void)paiBtnClick
{
   [Listeningkeyboard endEditing];
    RollSaomaViewController * vc = [[RollSaomaViewController alloc]initWithNavTitle:@""];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)queBtnClick
{
    if (_BTCField.text.length < 6) {
        [MYAlertController showTitltle:@"输入转出的地址"];
        return ;
    }
    if (_jiaoyiField.text.length < 1) {
        [MYAlertController showTitltle:@"请输入交易金额"];
        return ;
    }

   [Listeningkeyboard endEditing];
    if ([self.model.transpwd intValue] == 0) {
        [ MYAlertController showTitltleArrays:@[@"注意",@"您尚未设置资金密码,不可转出\n请前往安全中心设置"] selButton:^(MYAlertController *AlertController, int index) {
            [self popControllerwithstr:@"MoneyPasswordViewController" title:@"资金密码"];
        } title:@"取消",@"前往设置", nil];
        return ;
    }
    if([self.curManager.selcurrencyModel.coin_name isEqual:@"ETH"]) {
        [self  postdownDatas:@"transfer/Transfer/maketxinfo" withdict:@{@"coin_species":self.curManager.selcurrencyModel.coin_species,@"value":self.jiaoyiField.text,@"to":self.BTCField.text,@"txfee":@"1"} index:2];
    }else {
        [IPhoneAlectView showWithAlect:^(BOOL isAlect , NSString * password) {
            if (isAlect) {
                if ([self.curManager.selcurrencyModel.coin_name isEqual:@"EBO"]) {
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"coin_species":self.curManager.selcurrencyModel.coin_species,@"coin_num":self.jiaoyiField.text,@"toaddress":self.BTCField.text,@"transpwd":password,@"toaddress":self.BTCField.text}];
                    if (self->_beizuField.text.length > 0 ) {
                        [dict setObject:self->_beizuField.text forKey:@"memo"];
                    }
                    [self  postdownDatas:@"/transfer/Transfer/sendTx" withdict:dict index:1];
                }
            }
        }];
    }

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [Listeningkeyboard endEditing];
}

#pragma mark----RollSaomaViewControllerDelegate
-(void)RollSaomaViewController:(RollSaomaViewController *)vc stringValue:(NSString *)stringValue
{
    NSLog(@"%@",stringValue);
    self.BTCField.text = stringValue;
}

-(void)didView:(UIView *)view text:(NSString *)text
{
    if ([[view class] isEqual:[JNCoinTriangleView class]]) {

        if( [[CurrencyManager sharedInstance] setSelBiText:text vc:self]){  //设置默认选中的CurrencyModel
             _conView.titleLabel.text = text;
             [self didshuaXinView];
        }

    }
}

-(void)didshuaXinView
{
    ZiCurrencyModel * ziModel = [CurrencyManager readZiModelWithSpecies:self.curManager.selcurrencyModel.coin_species];
    [_yueLabel setText:[NSString stringWithFormat:@"%@",ziModel.balance] componentsSeparatedByString:@"."];
    _bizhong1Label.text = [NSString stringWithFormat:@"0.00%@",self.curManager.selcurrencyModel.coin_name];
    _bizhong1Label.text = [NSString stringWithFormat:@"%@%@",[CurrencyManager readMinfeeWithspecies:self.curManager.selcurrencyModel.coin_species],self.curManager.selcurrencyModel.coin_name];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 2) {
        [IPhoneAlectView showWithAlect:^(BOOL isAlect , NSString * password) {
            if (isAlect) {
                if ([self.curManager.selcurrencyModel.coin_name isEqual:BI_A1]) {
                    NSString * str = [MyUserDefaultsManager JNobjectForKey:[MyUserDefaultsManager readAddressSign]];
                            NSLog(@"str===========%@",str);
//                    str = [MyUserDefaultsManager readKeychainValue:[MyUserDefaultsManager readAddressSign]];
//                      NSLog(@"str===========%@",str);
                    if (str) {
                        [ETHManager createSignWithKey:str data:responseDict responseCallback:^(id responseta) {
                            NSLog(@"%@",responseta);
                            NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"coin_species":self.curManager.selcurrencyModel.coin_species,@"coin_num":self.jiaoyiField.text,@"txstr":responseta,@"transpwd":password,@"toaddress":self.BTCField.text}];
                            if (self->_beizuField.text.length > 0 ) {
                                [dict setObject:self->_beizuField.text forKey:@"memo"];
                            }
                            [self  postdownDatas:@"/transfer/Transfer/sendTx" withdict:dict index:1];
                        }];
                    }else {
                        [MYAlertController showTitltle:@"当前设备不能签名,请导入加密文件" selButton:^(MYAlertController *AlertController, int index) {
                            if (index == 1) {

                            }
                        } title:@"取消",@"导入", nil];
                    }
                }
            }
        }];
    }else if(index == 1)
    {
        [MYAlertController showTitltle:@"转出成功" selButton:^(MYAlertController *AlertController, int index) {
            FANHUI_JIUSHITU ;
        } ];
    }else {
        NSLog(@"%@",responseDict);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"0"] && textField.text.length == 0) {
        return  NO;
    }
    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if ([self.curManager.selcurrencyModel.coin_name isEqual:BI_A0]) {
       _rmbLabel.text = [NSString stringWithFormat:@"%@%@%.2f",FUHAO_YUEDENGYU,FUHAO_RENMINGBI,[str floatValue] / self.curManager.portionModel.ebocny];
     }else {
         _rmbLabel.text = [NSString stringWithFormat:@"%@%@%.2f",FUHAO_YUEDENGYU,FUHAO_RENMINGBI,[str floatValue] / self.curManager.portionModel.ebocny * self.curManager.portionModel.propor];
    }
    return  YES;
}

@end
