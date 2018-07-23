//
//  MarketViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketView.h"
#import "MarketSlidingView.h"
#import "IPhoneAlectView.h"


#import "MaeketCurveView.h"
#import "MarketCurveModel.h"

#define exchangeStr @"最低兑换数量100"
#define ETH @"ETH"

@interface MarketViewController ()<JNBaseViewDelegate , UITextFieldDelegate>
{
    

    UIButton *  _selBtn;
    int _max;

}
XH_ATTRIBUTE(retain, MaeketCurveView, curveView);
XH_ATTRIBUTE(strong, UITextField, numTf);
XH_ATTRIBUTE(strong, UITextField, exchangeNumTf);
XH_ATTRIBUTE(strong, UILabel, upLab);
XH_ATTRIBUTE(strong, UILabel, downLb);
XH_ATTRIBUTE(strong, UILabel, valuationLb);
XH_ATTRIBUTE(strong, UIImageView, changeImv);
XH_ATTRIBUTE(strong, UILabel, lab1);
@end

@implementation MarketViewController

-(UITextField *)numTf{
    if (!_numTf) {
        _numTf = JnTextFiled(CGRectZero, [NSString stringWithFormat:@"%@%@",BI_A0,exchangeStr], 0);
        _numTf.layer.borderColor = COLOR_B6.CGColor;
        _numTf.backgroundColor = COLOR_B6;
        _numTf.delegate = self;
        [_numTf setKeyboardType:UIKeyboardTypeDecimalPad];
    }
    return _numTf;
}
-(UITextField *)exchangeNumTf{
    if (!_exchangeNumTf) {
        _exchangeNumTf = JnTextFiled(CGRectZero, @"请输入数量", 0);
        _exchangeNumTf.layer.borderColor = COLOR_B6.CGColor;
        _exchangeNumTf.backgroundColor = COLOR_B6;
        _exchangeNumTf.delegate = self;
        [_exchangeNumTf setKeyboardType:UIKeyboardTypeDecimalPad];
    }
    return _exchangeNumTf;
}
-(UILabel *)valuationLb{
    if (!_valuationLb) {
        _valuationLb = [UIKitAdditions labelWithBlackText:@"￥0.0" fontSize:0];
    }
    return _valuationLb;
}
-(UIImageView *)changeImv{
    if (!_changeImv) {
        _changeImv =  [UIKitAdditions imageViewWithImageName:@"hq_qiehuan"];
    }
    return _changeImv;
}
-(UILabel *)upLab{
    if (!_upLab) {
        _upLab = [UIKitAdditions labelWithBlackText:BI_A0 fontSize:0];
        _upLab.textAlignment = NSTextAlignmentRight;
    }
    return _upLab;
}
-(UILabel *)downLb{
    if (!_downLb) {
        _downLb = [UIKitAdditions labelWithBlackText:ETH fontSize:0];
    }
    return _downLb;
}

-(void)createNavView{
    [super createNavView];
    [self.navView addDividingLine];
    [self.navView setStyle:3];
    [self.navView.rightButton setBackgroundImage:MYimageNamed(@"hq_dingdan") forState:0];
}

-(void)Initialize{
    [super Initialize ];
    _max = 100000;
}

-(void)createView{
    [super createView];
    self.bodyView.backgroundColor = COLOR_WHITE;
    
    _curveView = [[MaeketCurveView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(150)) curveModels:nil higt:600];
    _curveView.backgroundColor = COLOR_WHITE;
    [self.bodyView addSubview:_curveView];
    self.lab1 = [UILabel new];
    self.lab1.backgroundColor = COLOR_B6;
    [self.bodyView addSubview:self.lab1];
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.curveView.mas_bottom);
        make.left.centerX.equalTo(self.bodyView);
        make.height.mas_equalTo(20);
    }];
    

    UILabel * lab = [UIKitAdditions labelWithBlackText:[NSString stringWithFormat:@"%@/ETH兑换",BI_A0] fontSize:0];
    [self.bodyView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab1.mas_bottom).offset(20);
        make.left.equalTo(self.bodyView).offset(JNVIEW_X0);
    }];
    [self.bodyView creatLineOnRelativeView:lab offSet:20];
    
    UILabel * lab11 = [UIKitAdditions labelWithBlackText:@"输入数量" fontSize:0];
    [self.bodyView addSubview:lab11];
    [lab11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab);
        make.top.equalTo(lab.mas_bottom).offset(50);
    }];

    
    [self.bodyView addSubview:self.upLab];
    [self.upLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bodyView).offset(-20);
        make.top.equalTo(lab11);
    }];
    
    [self.bodyView addSubview:self.numTf];
    [self.numTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab11.mas_right).offset(20);
        make.right.equalTo(self.upLab.mas_left).offset(-20);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(lab11);
    }];
    
    UIButton * btn2 = [UIKitAdditions buttonSetImage:@"hq_qiehuanxia" target:self selector:@selector(change)];
    [self.bodyView addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upLab.mas_bottom);
        make.width.height.mas_equalTo(JN_HH(44));
        make.right.equalTo(self.bodyView).offset(-10);
    }];
    [btn2 addSubview:self.changeImv];
    [self.changeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.centerX.centerY.equalTo(btn2);
    }];
    
    UILabel * lab2 = [UIKitAdditions labelWithBlackText:@"兑换数量" fontSize:0];
    [self.bodyView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab);
        make.top.equalTo(btn2.mas_bottom);
    }];
    
    [self.bodyView addSubview:self.downLb];
    [self.downLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.upLab);
        make.top.equalTo(lab2);
    }];
    
    [self.bodyView addSubview:self.exchangeNumTf];
    [self.exchangeNumTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab2.mas_right).offset(20);
        make.right.equalTo(self.downLb.mas_left).offset(-20);
        make.height.equalTo(self.numTf);
        make.centerY.equalTo(lab2);
    }];
    
    UILabel * lab3 = [UIKitAdditions labelWithBlackText:@"估值" fontSize:0];
    [self.bodyView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab);
        make.top.equalTo(self.exchangeNumTf.mas_bottom).offset(20);
    }];
    
    [self.bodyView addSubview:self.valuationLb];
    [self.valuationLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numTf);
        make.top.equalTo(lab3);
    }];
    
    UIButton * btn = [UIKitAdditions buttonWithText:@"兑换" backGroundColor:nil textColor:COLOR_A1 fontSize:0 target:self selector:@selector(valuationClick)];
    [self.bodyView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bodyView);
        make.top.equalTo(self.valuationLb.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    JNViewStyle(btn, JN_HH(15), COLOR_A1, 1);
    
    UIButton * btn1 = [UIKitAdditions buttonWithText:@"兑换比例历史记录" backGroundColor:nil textColor:COLOR_A1 fontSize:0 target:self selector:@selector(historyClick)];
    [self.bodyView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bodyView).offset(-20);
        make.top.equalTo(btn.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark 兑换按钮点击了
-(void)valuationClick{
    [Listeningkeyboard endEditing];
    //ob_coin to币种ID   src_coin from币种ID  cost_ob to币种数量  cost_src  from币种数量
    if ([self.upLab.text isEqualToString:ETH]) {
        //ETH  - EBO
        [MyNetworkingManager DDPOSTResqust:@"/transfer/Transfer/maketxinfo" withparameters:@{@"value":self.numTf.text,@"coin_species":[CurrencyManager readspeciesWithName:BI_A1]} withVC:self progress:^(NSProgress * _Nonnull progre) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [IPhoneAlectView showWithAlect:^(BOOL isAlect , NSString * password) {
                if (isAlect) {
                    NSString * str = [MyUserDefaultsManager JNobjectForKey:[MyUserDefaultsManager readAddressSign]];
                    NSLog(@"str===========%@",str);
                    if (str) {
                        [ETHManager createSignWithKey:str data:responseObject responseCallback:^(id responseta) {
                            NSLog(@"%@",responseta);
                            [MyNetworkingManager DDPOSTResqust:@"/transfer/Transfer/changeCoin" withparameters:@{@"src_coin":[CurrencyManager readspeciesWithName:BI_A1],@"cost_src":self.numTf.text,@"ob_coin":[CurrencyManager readspeciesWithName:BI_A0],@"cost_ob":self.exchangeNumTf.text,@"txsign":responseta,@"transpwd":password,@"txfee1":@"0.00008",@"txfee2":@"0.00005"} withVC:self progress:^(NSProgress * _Nonnull progre) {
                            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [MYAlertController showTitltle:@"兑换成功" vc:self];
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                
                            }];
                        }];
                    }else {
                        [MYAlertController showTitltle:@"当前设备不能签名,请导入加密文件" selButton:^(MYAlertController *AlertController, int index) {
                            if (index == 1) {
                                
                            }
                        } title:@"取消",@"导入", nil];
                    }
                }
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
    }
    else{
        [IPhoneAlectView showWithAlect:^(BOOL isAlect , NSString * password) {
            if (isAlect) {
                [MyNetworkingManager DDPOSTResqust:@"/transfer/Transfer/changeCoin" withparameters:@{@"ob_coin":[CurrencyManager readspeciesWithName:BI_A1],@"cost_ob":self.exchangeNumTf.text,@"src_coin":[CurrencyManager readspeciesWithName:BI_A0],@"cost_src":self.numTf.text,@"transpwd":password} withVC:self progress:^(NSProgress * _Nonnull progre) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            }
        }];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"0"] && textField.text.length == 0) {
        return  NO;
    }
    NSString * str = @"0";
    if (textField == self.numTf) {
        if (range.length == 1) {
            if (textField.text.length > 0) {
                str = [textField.text substringWithRange:NSMakeRange(0, textField.text.length -1)];
            }
            if (str.length == 0) {
                str = @"0";
            }
        }else {
            str  = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        NSLog(@"====%@ ==== %@",self.curManager.portionModel.propor,self.curManager.portionModel.ebocny);
        
        if ([self.upLab.text isEqualToString:BI_A0]) {
            self.exchangeNumTf.text = [NSString stringWithFormat:@"%f",[str floatValue] / [self.curManager.portionModel.propor floatValue]];
            self.valuationLb.text = [NSString stringWithFormat:@"￥%.2f",[str floatValue] / [self.curManager.portionModel.ebocny floatValue]];
        }
        else{
            self.exchangeNumTf.text = [NSString stringWithFormat:@"%f",[str floatValue] * [self.curManager.portionModel.propor floatValue]];
            self.valuationLb.text = [NSString stringWithFormat:@"￥%.2f",[self.exchangeNumTf.text floatValue] / [self.curManager.portionModel.ebocny floatValue]];
        }
        
        
    }else {
        
        if (range.length == 1) {
            if (textField.text.length > 0) {
                str = [textField.text substringWithRange:NSMakeRange(0, textField.text.length -1)];
            }
            if (str.length == 0) {
                str = @"0";
            }
        }else {
            NSArray * array = [textField.text componentsSeparatedByString:@"."];
            if (array.count > 1 ) {
                NSString * textStr = array[1];
                if (textStr.length >=6 || [string isEqual:@"."]) {
                    return  NO;
                }
            }
            if ([string isEqual:@"."] && textField.text.length == 0 ) {
                textField.text = @"0";
            }
            if ([textField.text isEqual:@"0"] && ![string isEqual:@"."]) {
                textField.text = nil;
            }
            str  = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }
        
        if ([self.upLab.text isEqualToString:BI_A0]) {
            self.numTf.text = [NSString stringWithFormat:@"%f",[str intValue] / [self.curManager.portionModel.propor floatValue]];
            str = self.numTf.text ;
            self.valuationLb.text = [NSString stringWithFormat:@"￥%.2f",[str intValue] / [self.curManager.portionModel.ebocny floatValue]];
        }
        else{
            self.numTf.text = [NSString stringWithFormat:@"%f",[str intValue] * [self.curManager.portionModel.propor floatValue]];
            str = self.numTf.text ;
            self.valuationLb.text = [NSString stringWithFormat:@"￥%.2f",[str intValue] / [self.curManager.portionModel.ebocny floatValue]];
        }
    }
    return YES;
}
#pragma mark 历史点击了
-(void)historyClick{
    
}
-(void)change{
    self.numTf.text = @"";
    self.exchangeNumTf.text = @"";
    [self.changeImv oneCircles];
    [Helpr dispatch_queue_t_timer:1 send:^{
        if ([self.upLab.text isEqualToString:BI_A0]) {
            self.upLab.text = ETH;
            self.downLb.text = BI_A0;
        }
        else{
            self.upLab.text = BI_A0;
            self.downLb.text = ETH;
        }
        self.numTf.placeholder = [NSString stringWithFormat:@"%@%@",self.upLab.text,exchangeStr];
    }];
}
-(void)downDatas{
    //获取曲线图
    [self postdownDatas:@"transfer/list/getKindlelist" withdict:@{@"size":@"50",@"period":@"4hour",@"symbol":@"ethusdt"} index:1];
    //获取比例
    [CurrencyManager exchangeProportion:^(ProportionModel * model) {
//        self.valuationLb.text = [NSString stringWithFormat:@"$%f",[model.ebocny floatValue]/[model.propor floatValue]];
    }];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
     //   NSLog(@"responseDict=====%@",responseDict);
        if (responseDict) {
            NSMutableArray * array = [NSMutableArray array];
            if ([responseDict class] == [NSNull class]) {
                return ;
            }
            NSArray * dataArrays = responseDict[@"data"];
            for (int i = 0 ; i < dataArrays.count; i++) {
                NSDictionary * dict = dataArrays[i];
                MarketCurveModel * curModel = [[MarketCurveModel alloc]init];
                curModel.close = dict[@"close"];
                curModel.index = [NSString stringWithFormat:@"%d",i] ;
                [array addObject:curModel];
            }
            _curveView.curveModels = array;
        }
    }
}

-(void)addListeningkeyboard{
    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bodyView.frame = CGRectMake(0, - h + self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - self.tab_h);
        }];
    } keyboard:^(CGFloat h) {
        self.bodyView.frame = CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - self.tab_h);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [Listeningkeyboard endEditing];
}

-(void)didView:(UIView *)view
{
    [Listeningkeyboard endEditing];
    MarketView * maView = (MarketView *)view;
    if ([[maView readNum] intValue]<= 100) {
        [MYAlertController   showTitltle:@"交易数量太少"];
        return ;
    }
    if (view.tag == 200) {
        // 这是买入
        [IPhoneAlectView showWithAlect:^(BOOL isAlect , NSString * password) {
          //  [self addListeningkeyboard];
            if (isAlect) {
                [self postdownDatas:@"/transfer/Transfer/changeCoin" withdict:@{@"ob_coin":[CurrencyManager readspeciesWithName:BI_A0],@"cost_ob":[maView readNum],@"src_coin":[CurrencyManager readspeciesWithName:BI_A1],@"cost_src":[maView readNumeth],@"transpwd":password} index:501];
            }
        }];
    }else {
   //这是卖出
        [IPhoneAlectView showWithAlect:^(BOOL isAlect, NSString * password) {
            if (isAlect) {
                [self postdownDatas:@"/transfer/Transfer/changeCoin" withdict:@{@"src_coin":[CurrencyManager readspeciesWithName:BI_A0],@"cost_src":[maView readNum],@"ob_coin":[CurrencyManager readspeciesWithName:BI_A1],@"cost_ob":[maView readNumeth],@"transpwd":password} index:501];
            }
        }];
    }
}

-(void)didView:(UIView *)view text:(NSString *)text
{
    if ([text floatValue] >= _max) {
//        [_slidingView setIndex:1];
    }else {
//        [_slidingView setIndex:[text floatValue]/_max];
    }
}

-(void)clickRightButton:(UIButton *)rightBtn
{ 
    [self popControllerwithstr:@"MarketOrderViewController" title:@"交易订单"];
}
#pragma mark----给按钮添加两条线
-(void)addBtn:(UIButton *)btn
{
    UIView * xian = JnUIView(CGRectMake(0, 0, btn.width, 1), COLOR_B5);
    [btn addSubview:xian];
    xian.tag = 10000;
    UIView * xian1 = JnUIView(CGRectMake(0, btn.height -1, btn.width, 1), COLOR_B5);
    [btn addSubview:xian1];
    xian1.tag = 10001;
}

-(void)removeBtn:(UIButton *)btn
{
    UIView * view = [btn viewWithTag:10000];
    UIView * view1 = [btn viewWithTag:10001];
    [view removeFromSuperview];
    [view1 removeFromSuperview];
}

@end
