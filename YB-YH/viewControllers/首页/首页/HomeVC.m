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
#import "BaseDDView.h"
#import "MoneyViewController.h"


#define Tag 666
#define vTag 888




@interface HomeVC ()<JNBaseViewDelegate>

XH_ATTRIBUTE(strong, UIScrollView, scl);
XH_ATTRIBUTE(strong, UIView, containView);//scollView 的内容视图
XH_ATTRIBUTE(strong, JNCoinView, conView);
XH_ATTRIBUTE(strong, UILabel, propertyLb);
XH_ATTRIBUTE(strong, ShufflingView, scolV);//轮播图
XH_ATTRIBUTE(strong, SXHeadLine, runLb);//跑马灯
XH_ATTRIBUTE(strong, UIButton, walletBtn);
@end

@implementation HomeVC

-(UILabel *)propertyLb{
    if (!_propertyLb) {
        _propertyLb = [UIKitAdditions labelWithBlackText:@"0" fontSize:25];
    }
    return _propertyLb;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.runLb start];
    [self.scolV startTimer];
    //获取最新
    if (self.curManager.selcurrencyModel) {
         self.conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)createNavView{
    [super createNavView];
    [self.navView setStyle:2];
    [self.navView addDividingLine];
    self.conView = [[JNCoinView alloc]initWithFrame:CGRectMake( SCREEN_WIDTH * 0.5 - 30, CGNavView_20h(), 60, 44)];
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
    self.scl = [UIScrollView new];
 //   self.scl.bounces = NO;
    [self.bodyView addSubview:self.scl];
    [self.scl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bodyView).with.insets(UIEdgeInsetsMake(0, 0, Tabbar_49h(), 0));
    }];

    self.containView = [UIView new];
    [self.scl addSubview:self.containView];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scl).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(self.scl);
    }];
    
    [self.containView addSubview:self.propertyLb];

    [self.propertyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scl);
        make.top.equalTo(self.scl).offset(20);
    }];
    UILabel * lab = [UIKitAdditions labelWithText:@"账户余额" textColor:[UIColor grayColor] alignment:1 fontSize:14];
    [self.scl addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.propertyLb.mas_bottom).offset(10);
        make.centerX.equalTo(self.scl);
    }];
    [self.scl creatLineOnRelativeView:lab offSet:20];
    UIButton * lastBtn = nil;
    for (int i = 0;  i < 2; i ++) {
        UIButton * btn = [UIButton new];
        [self.scl addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(0);//取件码
            }
            else
                make.left.equalTo(self.scl);
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
            [self.scl addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btn);
                make.left.equalTo(btn.mas_right);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(1);
            }];
        }
        lastBtn = btn;
    }
    [self.scl creatLineOnRelativeView:lastBtn offSet:0];
    [self.scl creatStrongLineOnRelativeView:lastBtn offSet:0];

    
    self.scolV = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) BgColor:COLOR_WHITE];
    [self.scl addSubview:self.scolV];
    [self.scolV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(JN_HH(80));
        make.left.centerX.equalTo(self.scl);
        make.top.equalTo(lastBtn.mas_bottom).offset(20);
    }];

    //跑马灯
    UIImageView * laba = [UIKitAdditions imageViewWithImageName:@"sy_laba"];
    [self.scl addSubview:laba];
    [laba mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scl).offset(20);
        make.top.equalTo(self.scolV.mas_bottom).offset(20);
    }];


    BaseDDView * workBtn = [[BaseDDView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) leftName:nil title:@"赚取工作量证明" rightName:@"jiantou_H1_88"];
    workBtn.delegate = self;
    workBtn.backgroundColor = COLOR_WHITE;
    [self.scl addSubview:workBtn];
    [workBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.scl);
        make.top.equalTo(laba.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
    }];

    UIScrollView * scl1 = [UIScrollView new];

    scl1.bounces = YES;
    [self.containView addSubview:scl1];

    [scl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scl).offset(20);
        make.right.equalTo(self.scl);
        make.top.equalTo(workBtn.mas_bottom);
        make.height.mas_equalTo(200);
    }];


    UIView * conv = [UIView new];
    [scl1 addSubview:conv];
    [conv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scl1).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.equalTo(scl1);
    }];
    UIImageView * lastimav = nil;
    for ( int i = 0; i < 2; i ++) {
        UIImageView * ima = [UIKitAdditions imageViewWithImageName:@[@"xyxz",@"zkfl"][i]];
        [conv addSubview:ima];
        [ima mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastimav) {
                make.left.equalTo(lastimav.mas_right).offset(20);
            }
            else{
                make.left.equalTo(conv);
            }
            make.centerY.equalTo(conv);
        }];
        lastimav = ima;
        [lastimav addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            [MYAlertController showTitltle:@"此功能暂未开放！" vc:self];
        }];
    }
    [conv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastimav.mas_right).offset(20);
    }];
    

    
    [self.scl creatStrongLineOnRelativeView:scl1 offSet:0];
    
    BaseDDView * commBtn = [[BaseDDView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) leftName:nil title:@"GamePay社区" rightName:@"jiantou_H1_88"];
    commBtn.delegate = self;
    commBtn.backgroundColor = COLOR_WHITE;
    [self.scl addSubview:commBtn];
    [commBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(self.scl);
        make.top.equalTo(scl1.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView * v1 = [UIKitAdditions imageViewWithImageName:@"gamepay"];
    [self.scl addSubview:v1];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(workBtn);
        make.top.equalTo(commBtn.mas_bottom);
    }];
    [v1 addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        [MYAlertController showTitltle:@"此功能暂未开放！" vc:self];
    }];
    
    [self.scl creatStrongLineOnRelativeView:v1 offSet:0];
    UILabel * lab2 = [UIKitAdditions labelWithBlackText:@"我的钱包" fontSize:0];
    [self.scl addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scl).offset(20);
        make.top.equalTo(v1.mas_bottom).offset(40);
    }];
    self.walletBtn = [UIButton new];
    [self.scl addSubview:self.walletBtn];
    [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scl).offset(-20);
        make.centerY.equalTo(lab2);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(50);
    }];
    [self.walletBtn addTarget:self action:@selector(addWallet) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * imav = [UIKitAdditions imageViewWithImageName:@"sy_tjqb"];
    [self.walletBtn addSubview:imav];
    [imav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.walletBtn.mas_centerX).offset(-30);
        make.centerY.equalTo(self.walletBtn);
    }];
    UILabel * btlab = [UIKitAdditions labelWithText:@"新增钱包" textColor:COLOR_A1 alignment:0 fontSize:14];
    [self.walletBtn addSubview:btlab];
    [btlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imav.mas_right).offset(20);
        make.centerY.equalTo(self.walletBtn);
    }];

    [self.containView creatLineOnRelativeView:self.walletBtn offSet:20];

    [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.walletBtn.mas_bottom).offset(20);

    }];

    
}

#pragma mark 新增钱包
-(void)addWallet{
    MoneyViewController * vc = [[MoneyViewController alloc]initWithNavTitle:@"创建钱包" name:BI_A1];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)didView:(UIView *)view{
    [MYAlertController showTitltle:@"此功能暂未开放！" vc:self];
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
            for (int i = 0 ; i < array.count; i++) {
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
    [CurrencyManager exchangeProportion:^(ProportionModel * pmodel) {
        //获取资产
        [MyNetworkingManager DDPOSTResqust:@"/user/Assets/getAssets" withparameters:@{} withVC:self progress:^(NSProgress * _Nonnull progre) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * arr = (NSArray *)responseObject;
            NSMutableArray * ziArray = [NSMutableArray array];
            NSLog(@"responseObject ====== %@",responseObject);
            ZiCurrencyModel * zicurmodel ;
            for (int i = 0 ; i < arr.count; i++) {
                ZiCurrencyModel * ziModel = [[ZiCurrencyModel  alloc]initWithDict:arr[i]];
                [ziArray addObject:ziModel];
                if ([ziModel.coin_name isEqual:self.curManager.selcurrencyModel.coin_name]) {
                    zicurmodel = ziModel;
                }
            }
            [CurrencyManager sharedInstance].allZiCurrencyModel = ziArray;
            self.propertyLb.text = [NSString stringWithFormat:@"%@",zicurmodel.balance];
            for (UIView * v in self.scl.subviews) {
                if (v.tag > vTag - 1) {
                    [v removeFromSuperview];
                }
            }
            //如果开通了ETH
            if ([CurrencyManager readisOpenWithName:BI_A1]) {
                self.walletBtn.alpha = 0;
            }
            else
                self.walletBtn.alpha = 1;
            ShouyeQianView * lastV = nil;
            for (int i = 0; i < self.curManager.allCurrencyModel.count; i ++) {
                CurrencyModel * model = self.curManager.allCurrencyModel[i];
                if (![model.isopen isEqualToString:currencyNOopen]) {
                    ShouyeQianView * v = [[ShouyeQianView alloc] init];
                    [self.scl addSubview:v];
                    v.imgeV.image = MYimageNamed(model.icon);
                    v.titleLb.text = model.coin_name;
                    ZiCurrencyModel * zim = [CurrencyManager readZiModelWithSpecies:model.coin_species];
                    v.balanceLb.text = zim.balance;
                    if ([model.coin_name isEqualToString:BI_A0]) {
                        v.imgeV.image = MYimageNamed(@"sy_ebog");
                        v.rmbLb.text = [NSString stringWithFormat:@"%.2f",self.curManager.portionModel.ebocny * [zim.balance floatValue]];
                    }
                    else if ([model.coin_name isEqualToString:BI_A1]){
                        v.imgeV.image = MYimageNamed(@"sy_eth");
                        v.rmbLb.text = [NSString stringWithFormat:@"%.4f",self.curManager.portionModel.propor * [zim.balance floatValue] * self.curManager.portionModel.ebocny];
                    }
                    [v mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (lastV) {
                            make.top.equalTo(lastV.mas_bottom).offset(20);
                        }
                        else
                            make.top.equalTo(self.walletBtn.mas_bottom).offset(40);
                        make.left.equalTo(self.scl).offset(20);
                        make.centerX.equalTo(self.scl);
                        make.height.mas_equalTo(100);
                    }];
                    v.layer.borderColor = COLOR_B6.CGColor;
                    v.layer.borderWidth = 0.7;
                    v.tag = vTag + i;
                    lastV = v;
                }
            }
            [self.containView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.scl);
                if (lastV) {
                    make.bottom.equalTo(lastV.mas_bottom).offset(20);
                }
                else
                    make.bottom.equalTo(self.walletBtn.mas_bottom).offset(20);
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }];
    
}
-(void)didView:(UIView *)view text:(NSString *)text{
    if ([[view class] isEqual:[JNCoinTriangleView class]]) {
        //设置默认选中的CurrencyModel
        if ([[CurrencyManager sharedInstance] setSelBiText:text vc:self]) {
            self.conView.titleLabel.text = text;
            [self refreshData];
        }
    }
}
#pragma mark 刷新数据
-(void)refreshData{
    if (self.curManager.selcurrencyModel) {
        self.conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
        ZiCurrencyModel * model = [CurrencyManager readZiModelWithSpecies:self.curManager.selcurrencyModel.coin_species];
        self.propertyLb.text = [NSString stringWithFormat:@"%@",model.balance];
    }
}
#pragma mark 转入转出按钮点击了
-(void)inOutClick:(UIButton *)btn{
    if (btn.tag == Tag) {
        [self popControllerwithstr:@"RollIntoViewController" title:@"转入"];
    }
    else if(btn.tag == Tag + 1){
        [self popControllerwithstr:@"RollOutViewController" title:@"转出"];
    }
}
#pragma mark 订单点击了
-(void)clickonReturn{
    [self popControllerwithstr:@"TransferRecordViewController" title:@"转账记录"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scolV endTimer];
    [self.runLb stop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scl != scrollView) {
        NSLog(@"asdfasdfasdf---=====%f",scrollView.contentOffset.x);
        self.scl.contentOffset =  CGPointMake(0,  self.scl.contentOffset.y + scrollView.contentOffset.y);
      //  scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }

}

@end
