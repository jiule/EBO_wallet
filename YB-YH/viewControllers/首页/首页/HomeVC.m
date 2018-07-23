//
//  HomeVC.m
//  YB-YH
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "HomeVC.h"
#import "JNCoinView.h"
#import "JNCoinTriangleView.h"
#import "ShufflingView.h"
#import "SXHeadLine.h"
#import "ShouyeQianView.h"
#import "BaseView.h"


#define Tag 666

@interface HomeVC ()<JNBaseViewDelegate>
XH_ATTRIBUTE(strong, JNCoinView, conView);
XH_ATTRIBUTE(strong, UILabel, propertyLb);
XH_ATTRIBUTE(strong, ShufflingView, scolV);//轮播图
XH_ATTRIBUTE(strong, SXHeadLine, runLb);//跑马灯
@end

@implementation HomeVC

-(UILabel *)propertyLb{
    if (!_propertyLb) {
        _propertyLb = [UIKitAdditions labelWithBlackText:@"500 0000" fontSize:25];
    }
    return _propertyLb;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.runLb start];
    [self.scolV startTimer];
    //获取最新
    self.conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createNavView{
    [super createNavView];
    [self.navView setStyle:2];
    self.conView = [[JNCoinView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 30, CGNavView_20h(), 60, 44)];
    self.conView.imageView.image = MYimageNamed(@"选择框剪头1");
    [self.navView addSubview:self.conView];
    self.conView.titleLabel.text = BI_A0;
    
    [self.conView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        JNCoinTriangleView * coinview =  [[JNCoinTriangleView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 45, self.nav_h, 90, 60)  selTitle:self.conView.titleLabel.text type:1];
        coinview.delegate = self;
        [self.view.window addSubview:coinview];
    }];
    [self.navView setRrturnBackImage:MYimageNamed(@"hq_dingdan")];
}
-(void)createView{
    UIScrollView * scl = [UIScrollView new];
    scl.bounces = NO;
    [self.bodyView addSubview:scl];
    [scl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIView * containView = [UIView new];
    [scl addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scl).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(scl);
    }];
    
    [containView addSubview:self.propertyLb];
    [self.propertyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containView);
        make.top.equalTo(containView).offset(20);
    }];
    UILabel * lab = [UIKitAdditions labelWithText:@"账户余额" textColor:[UIColor grayColor] alignment:1 fontSize:14];
    [containView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.propertyLb.mas_bottom).offset(20);
        make.centerX.equalTo(containView);
    }];
    [containView creatLineOnRelativeView:lab offSet:20];
    UIButton * lastBtn = nil;
    for (int i = 0;  i < 2; i ++) {
        UIButton * btn = [UIButton new];
        [containView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(0);
            }
            else
                make.left.equalTo(containView);
            make.top.equalTo(lab.mas_bottom).offset(20);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(50);
        }];
        [btn addTarget:self action:@selector(inOutClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = Tag + i;
        UIImageView * imav = [UIKitAdditions imageViewWithImageName:@[@"sy_zhuanru",@"sy_zhuanchu"][i]];
        [btn addSubview:imav];
        [imav mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn.mas_centerX).offset(-30);
            make.centerY.equalTo(btn);
        }];
        UILabel * lab1 = [UIKitAdditions labelWithText:@[@"转入",@"转出"][i] textColor:COLOR_A1 alignment:0 fontSize:14];
        [btn addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imav.mas_right).offset(20);
            make.centerY.equalTo(btn);
        }];
        if (!lastBtn) {
            UILabel * lab = [UILabel new];
            lab.backgroundColor  = COLOR_B6;
            [containView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn);
                make.left.equalTo(btn.mas_right);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(1);
            }];
        }
        lastBtn = btn;
    }
    [containView creatLineOnRelativeView:lastBtn offSet:0];
    [containView creatStrongLineOnRelativeView:lastBtn offSet:0];
    
    
    self.scolV = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) BgColor:COLOR_WHITE];
    [containView addSubview:self.scolV];
    [self.scolV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(JN_HH(80));
        make.left.centerX.equalTo(containView);
        make.top.equalTo(lastBtn.mas_bottom).offset(20);
    }];
    
    //跑马灯
    UIImageView * laba = [UIKitAdditions imageViewWithImageName:@"sy_laba"];
    [containView addSubview:laba];
    [laba mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containView).offset(20);
        make.top.equalTo(self.scolV.mas_bottom).offset(20);
    }];
    
    self.runLb = [[SXHeadLine alloc] initWithFrame:CGRectMake(JN_HH(30), JN_HH(80), SCREEN_WIDTH - JN_HH(60), JN_HH(25))];
    [containView addSubview:self.runLb];
    [self.runLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(laba.mas_right).offset(10);
        make.top.centerY.equalTo(laba);
        make.right.equalTo(containView).offset(-20);
    }];
    
    [self.runLb setBgColor:[UIColor whiteColor] textColor:COLOR_A1 textFont:[UIFont systemFontOfSize:13]];
    [self.runLb setScrollDuration:0.5 stayDuration:3];
    self.runLb.hasGradient = YES;
    [containView addSubview:self.runLb];
#pragma mark 跑马灯点击事件
    [self.runLb changeTapMarqueeAction:^(NSInteger index) {
        
        NSLog(@"你点击了第 %ld 个button！内容：%@", index, self.runLb.messageArray[index]);
        
    }];
    [containView creatStrongLineOnRelativeView:self.runLb offSet:20];
    BaseView * workBtn = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) leftName:nil title:@"asdfasdf" rightName:@"jiantou_H1_88"];
    workBtn.delegate = self;
    workBtn.backgroundColor = COLOR_WHITE;
    [containView addSubview:workBtn];
    [workBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(containView);
        make.top.equalTo(self.runLb.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
    }];
    [containView creatLineOnRelativeView:workBtn offSet:0];
    [containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(workBtn.mas_bottom).offset(-20);
    }];
    
    
}
-(void)didView:(UIView *)view{
    
}
-(void)downData{
    //获取轮播
    [MyNetworkingManager DDPOSTResqust:@"/portal/Slide/getSlideList" withparameters:@{} withVC:self progress:^(NSProgress * _Nonnull progre) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray * array = dic[@"slide"];
        NSMutableArray * ffilingArray = [NSMutableArray array];
        for (int  i =  0 ; i < array.count; i++) {
            NSDictionary * dict = array[i];
            [ffilingArray addObject:dict[@"image"]];
            [UIImage removeimageWithURL:dict[@"image"]];
        }
        if (ffilingArray.count < 3) {
            for (int i = 0 ; i < array.count; i++    ) {
                NSDictionary * dict = array[i];
                [ffilingArray addObject:dict[@"image"]];
            }
        }
        [self.scolV showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {
            
        }];
        
        //跑马灯
        NSArray * array1 = dic[@"notice"];
        NSMutableArray * filArr = [NSMutableArray array];
        for (int  i =  0 ; i < array1.count; i++) {
            NSDictionary * dict = array[i];
            [filArr addObject:dict[@"title"]];
        }
        self.runLb.messageArray = filArr;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)downDatas{
    //获取资产
    [MyNetworkingManager DDPOSTResqust:@"/user/Assets/getAssets" withparameters:@{} withVC:self progress:^(NSProgress * _Nonnull progre) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"===%@",responseObject);
        NSArray * arr = (NSArray *)responseObject;
        NSMutableArray * ziArray = [NSMutableArray array];
        for (int i = 0 ; i < arr.count; i++) {
            ZiCurrencyModel * ziModel = [[ZiCurrencyModel  alloc]initWithDict:arr[i]];
            [ziArray addObject:ziModel];
        }
        [CurrencyManager sharedInstance].allZiCurrencyModel = ziArray;
        
//        for (int i = 0 ; i < 2; i++) {
//            ShouyeQianView * view = (ShouyeQianView *)[_qianbaoView viewWithTag:100 +i];
//            if ( i < [CurrencyManager sharedInstance].allZiCurrencyModel.count) {
//                ZiCurrencyModel * ziModel = [CurrencyManager sharedInstance].allZiCurrencyModel[i];
//                if (view) {
//                    view.eboLabel.text = ziModel.coin_name;
//                    view.yueLabel.text = ziModel.balance;
//                }
//                if (i == 0) {
//                    [_ccsyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
//                }else {
//                    [_usdtyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
//                }
//                if ([ziModel.coin_species isEqual:self.curManager.selcurrencyModel.coin_species]) {
//                    [_zongziLabel setText:ziModel.balance componentsSeparatedByString:@"."];
//                }
//            }else {
//                view.eboLabel.text = BI_A1;
//                view.yueLabel.text = @"去开通";
//                [_usdtyueLabel setText:@"0" componentsSeparatedByString:@"."];
//            }
//
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark 转入转出按钮点击了
-(void)inOutClick:(UIButton *)btn{
    
}
#pragma mark 订单点击了
-(void)clickonReturn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
