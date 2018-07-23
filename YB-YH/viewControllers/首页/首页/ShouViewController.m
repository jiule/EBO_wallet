//
//  ShouViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ShouViewController.h"
#import "ShufflingView.h"
#import "SXHeadLine.h"
#import "BaseView.h"

#import "UIMoneyLabel.h"
#import "LAContextManger.h"

#import "CandyView.h"
#import "JNCoinView.h"
#import "JNCoinTriangleView.h"
#import "ShouyeQianView.h"

#import "MoneyViewController.h"  //创建钱包

@interface ShouViewController ()<UIScrollViewDelegate,JNBaseViewDelegate>
{
    ShufflingView * _ffilingView;   //轮播图
    SXHeadLine * _headLine3;        //跑马灯

    UIMoneyLabel * _zongziLabel;    //总资产
    
    UIView * _shujuView;
    UIMoneyLabel * _ccsyueLabel;   //CCS余额
    UIMoneyLabel * _usdtyueLabel;  //usdt 余额
    UILabel * _zhifuLabel;    //支付笔数
    UILabel * _zongzhifuLabel; //总支付笔数
    UIView * _jiluView;
    UIView * _qianbaoView;

    JNCoinView * _conView;  //切换
}

@property(nonatomic,retain)UIView * downView;

@property(nonatomic,retain)NSMutableArray * jiluArrays;

@property(nonatomic,retain)NSMutableArray * qianbaoArrays;

@property(nonatomic,retain)UIButton * navBiBtn;

@end

@implementation ShouViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_headLine3 start];
    [_ffilingView startTimer];
    //获取最新
    _conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [_ffilingView endTimer];
     [_headLine3 stop];
}

-(void)Initialize
{
    [super Initialize ];
    self.jiluArrays = [NSMutableArray array];
    self.qianbaoArrays = [NSMutableArray array];
}

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:3];
    self.navView.backgroundColor = [COLOR_A1 colorWithAlphaComponent:0];
    _conView = [[JNCoinView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 30, CGNavView_20h(), 60, 44)];
    [self.navView addSubview:_conView];
    _conView.titleLabel.text = BI_A0;

    [_conView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        JNCoinTriangleView * coinview =  [[JNCoinTriangleView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 45, self.nav_h, 90, 60)  selTitle:self->_conView.titleLabel.text type:1];
        coinview.delegate = self;
        [self.view.window addSubview:coinview];
    }];
}

-(void)createView
{
    [super createView];
    self.baseScollView.frame = CGRectMake(0, -CGNavView_20h(), SCREEN_WIDTH, SCREEN_HEIGHT - self.tab_h);
    self.baseScollView.delegate = self;
    self.baseScollView.bounces = NO;
    self.baseScollView.backgroundColor = DIVIDER_COLOR1;

    float h = self.nav_h + JN_HH(10);

    UIView * layerView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(h + 80)), COLOR_WHITE);
    [layerView addJianbianWithColor:SXRGB16Color(0Xec6237) upColor:COLOR_A1];
    [self.baseScollView addSubview:layerView];

    [self.baseScollView addSubview:JnLabel(CGRectMake(JN_HH(15), h + JN_HH(10), JN_HH(100), JN_HH(20)), @"账户余额", JN_HH(13.5), SXRGB16Color(0XF3A095), 0)];

    h += JN_HH(20);

    _zongziLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(JN_HH(15), h + JN_HH(10), SCREEN_WIDTH - JN_HH(45), JN_HH(40))];
    [self.baseScollView addSubview:_zongziLabel];

    h += JN_HH(60);
  NSArray *  titleArray = @[@"转入",@"转出",@"记录"];
  NSArray *  imageArray = @[@"sy_zhuanru",@"sy_zhuanchu",@"sy_jilun"];

    float label_w  = SCREEN_WIDTH  / titleArray.count;
    for (int i = 0;  i < titleArray.count; i++)
    {
        UIButton * btn = JnButtonTextType(CGRectMake(label_w * i , h, label_w, SCREEN_WIDTH * 0.25 ), @"", 0, self, @selector(btnClick:));
        btn.backgroundColor = COLOR_WHITE;
        btn.tag = 100 + i;
        [self.baseScollView addSubview:btn];
      
        [btn addSubview:JnImageView(CGRectMake(btn.width * 0.5 - JN_HH(22), JN_HH(10), JN_HH(44), JN_HH(44)), MYimageNamed(imageArray[i]))];

        [btn addSubview:JnLabelType(CGRectMake(0, JN_HH(49), label_w, SCREEN_WIDTH * 0.25 - JN_HH(60)), UILABEL_2, titleArray[i], 1)];
        if (i != 0 ) {
            [btn addSubview:JnUIView(CGRectMake(0, 0, 1, btn.height), DIVIDER_COLOR1)];
        }
    }
    h += SCREEN_WIDTH * 0.25 +JN_HH(10);

    self.downView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, SCREEN_HEIGHT * 2 - self.nav_h - JN_HH(230)), COLOR_H3);
    [self.baseScollView addSubview:self.downView];
    self.baseScollView.contentSize = CGSizeMake(0, [self.downView getY] + self.downView.height);
//轮播图
    UIView * paoView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH , JN_HH(105)), COLOR_WHITE);
    [self.downView addSubview:paoView];

    _ffilingView = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, paoView.width, JN_HH(80)) BgColor:COLOR_WHITE];
    [paoView addSubview:_ffilingView];

//跑马灯
    [paoView addSubview:JnImageView(CGRectMake(JN_HH(20), JN_HH(86),JN_HH(10), JN_HH(12)), MYimageNamed(@"sy_laba"))];

    SXHeadLine *headLine3 = [[SXHeadLine alloc]initWithFrame:CGRectMake(JN_HH(30), JN_HH(80), paoView.width - JN_HH(60), JN_HH(25))];
    headLine3.messageArray = @[@"1、库里43分，勇士吊打骑士",@"2、伦纳德死亡缠绕詹姆斯，马刺大胜骑士",@"3、乐福致命失误，骑士惨遭5连败",@"4、五小阵容发威，雄鹿吊打骑士", @"5、天猫的双十一，然而并没卵用"];
    [headLine3 setBgColor:[UIColor whiteColor] textColor:COLOR_A1 textFont:[UIFont systemFontOfSize:13]];
    [headLine3 setScrollDuration:0.5 stayDuration:3];
    headLine3.hasGradient = YES;
    [paoView addSubview:headLine3];

    [headLine3 changeTapMarqueeAction:^(NSInteger index) {

        NSLog(@"你点击了第 %ld 个button！内容：%@", index, headLine3.messageArray[index]);

    }];
    _headLine3 = headLine3;
//我的数据
   h = JN_HH(115);

   _shujuView = JnUIView(CGRectMake(0, h , SCREEN_WIDTH, JN_HH(120)), COLOR_WHITE);
   [self.downView addSubview:_shujuView];
   JNViewStyle(_shujuView, 5, nil, 0);

    [_shujuView addSubview:JnLabelType(CGRectMake(JN_HH(15), JN_HH(7), _shujuView.width * 0.5 - JN_HH(15), JN_HH(20)), UILABEL_2, BI_A0STR(@"账户余额"), 0)];
    [_shujuView addSubview:JnLabelType(CGRectMake( _shujuView.width * 0.5 + JN_HH(15), JN_HH(7), _shujuView.width * 0.5 - JN_HH(15), JN_HH(20)), UILABEL_2, BI_A1STR(@"账户余额"), 0)];

   _ccsyueLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(JN_HH(15), JN_HH(27), _shujuView.width * 0.5 - JN_HH(15), JN_HH(30))];
    [_ccsyueLabel setLeftFont:[UIFont systemFontOfSize:UILABEL_BZ_3] rightFont:[UIFont systemFontOfSize:UILABEL_BZ_3]];
    [_ccsyueLabel  setLeftTextColor:COLOR_BL_3 rightColor:COLOR_BL_3];
    [_shujuView addSubview:_ccsyueLabel];


    _usdtyueLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(_shujuView.width * 0.5 + JN_HH(15), JN_HH(27), _shujuView.width * 0.5, JN_HH(30))];
    [_usdtyueLabel setLeftFont:[UIFont systemFontOfSize:UILABEL_BZ_3] rightFont:[UIFont systemFontOfSize:UILABEL_BZ_3]];
    [_usdtyueLabel  setLeftTextColor:COLOR_BL_3 rightColor:COLOR_BL_3];
    [_shujuView addSubview:_usdtyueLabel];


    [_shujuView addUnderscoreWihtFrame:CGRectMake(0, JN_HH(60), _shujuView.width , 1)];
    [_shujuView addUnderscoreWihtFrame:CGRectMake( _shujuView.width * 0.5, 0, 1 , _shujuView.height)];

    [_shujuView addSubview:JnLabelType(CGRectMake(JN_HH(15), JN_HH(67), _shujuView.width * 0.5, JN_HH(20)),UILABEL_2, @"游戏支付笔数", 0)];
    [_shujuView addSubview:JnLabelType(CGRectMake(_shujuView.width * 0.5 + JN_HH(15), JN_HH(67), _shujuView.width * 0.5, JN_HH(20)),UILABEL_2, @"转账总笔数", 0)];

    _zhifuLabel = JnLabelType(CGRectMake(JN_HH(15), JN_HH(90), _shujuView.width * 0.5, JN_HH(20)), UILABEL_3, @"0", 0);
    _zongzhifuLabel = JnLabelType(CGRectMake(_shujuView.width * 0.5 +JN_HH(15), JN_HH(90), _shujuView.width * 0.5, JN_HH(20)), UILABEL_3, @"0", 0);
    [_shujuView addSubview:_zhifuLabel];
    [_shujuView addSubview:_zongzhifuLabel];

    [self downViewArrayView];

     h = _jiluView.height + [_jiluView getY] + JN_HH(10);
    _qianbaoView = JnUIView(CGRectMake(0, h , SCREEN_WIDTH ,  JN_HH(160) + JN_HH(30)), COLOR_WHITE);
     [_qianbaoView addSubview:JnLabelType(CGRectMake(JN_HH(15), 0, SCREEN_WIDTH, JN_HH(30)), UILABEL_5, @"我的钱包", 0)];
    for (int i = 0 ; i < 2; i++) {
        ShouyeQianView * qianView = [[ShouyeQianView alloc]initWithFrame:CGRectMake(JN_HH(15), JN_HH(30) + JN_HH(80) * i, SCREEN_WIDTH - JN_HH(30), JN_HH(75)) BgColor:COLOR_WHITE];
        qianView.tag = 100 + i;
        [_qianbaoView addSubview:qianView];
//        if (i == 0) {
//            qianView.imggeView.image = MYimageNamed(@"sy_ebog");
//        }else {
//            qianView.imggeView.image = MYimageNamed(@"sy_eth");
//            [qianView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
//                ShouyeQianView * anView = (ShouyeQianView *)view;
//                if ( ![CurrencyManager readisOpenWithName:anView.eboLabel.text]) {
//
//                    MoneyViewController * vc = [[MoneyViewController alloc]initWithNavTitle:@"创建钱包" name:anView.eboLabel.text];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//            }];
//        }
    }
    [self.downView addSubview:_qianbaoView];
//    [self didShuaxinView];
    [self downViewArrayView];
}

-(void)downData
{
    [self postdownDatas:@"/user/Assets/isreceiveSuger" withdict:@{} index:1]; //获取糖果
    [self postdownDatas:@"/portal/Slide/getSlideList" withdict:@{} index:3];  //获取轮播
}
-(void)downDatas
{
    [self postdownDatas:@"/user/Assets/getAssets" withdict:@{} index:-1];      //获取资产
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 100) {
        [self popControllerwithstr:@"RollIntoViewController" title:@"转入"];
    }else if(btn.tag == 101)
    {
        [self popControllerwithstr:@"RollOutViewController" title:@"转出"];
    }else if(btn.tag == 102)
    {
        [self popControllerwithstr:@"TransferRecordViewController" title:@"转账记录"];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navView.backgroundColor = [COLOR_A1 colorWithAlphaComponent:scrollView.contentOffset.y / JN_HH(200.00)];
}

-(void)didView:(UIView *)view
{
      [self downDatas];
}
-(void)didView:(UIView *)view text:(NSString *)text
{
    if ([[view class] isEqual:[JNCoinTriangleView class]]) {
        //设置默认选中的CurrencyModel
        if ([[CurrencyManager sharedInstance] setSelBiText:text vc:self]) {
            _conView.titleLabel.text = text;
            [self didShuaxinView];
        }
    }
}


-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
    //获取糖果
        if ([responseDict[@"isreceive"] isEqualToString:@"false"]) {
            [CandyView showWithnum:[responseDict[@"suger"] intValue] delegate:self];
        }
    }else if(index == 3)
    {
        NSArray * array = responseDict[@"slide"];
        NSMutableArray * ffilingArray = [NSMutableArray array];
        for (int  i =  0 ; i < array.count; i++) {
            NSDictionary * dict = array[i];
            [ffilingArray addObject:dict[@"image"]];
        }

        if (ffilingArray.count < 3) {
            for (int i = 0 ; i < array.count; i++    ) {
                NSDictionary * dict = array[i];
                [ffilingArray addObject:dict[@"image"]];
            }
        }

        [_ffilingView showWithImageUrlPaths:ffilingArray didShuffling:^(ShufflingView *shufflingView, int index) {

        }];
    }
}


-(void)readDowndatawithArray:(NSArray *)dataArray index:(int)index
{
    if (index == -1) {
        NSLog(@"dataArray====%@",dataArray);
        NSMutableArray * ziArray = [NSMutableArray array];
        for (int i = 0 ; i < dataArray.count; i++) {
            ZiCurrencyModel * ziModel = [[ZiCurrencyModel  alloc]initWithDict:dataArray[i]];
            [ziArray addObject:ziModel];
        }
        [CurrencyManager sharedInstance].allZiCurrencyModel = ziArray;
        [self downViewArrayView];
    }
}


-(void)downViewArrayView
{
    [_jiluView removeFromSuperview];

    float  h = JN_HH(250);

    _jiluView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(25)), COLOR_WHITE);
    [_jiluView addUnderscoreBottomline];
    [self.downView addSubview:_jiluView];
    [_jiluView addSubview:JnLabelType(CGRectMake(JN_HH(15), 0, SCREEN_WIDTH, JN_HH(25)), UILABEL_5, @"最近记录", 0)];

    if (self.jiluArrays.count > 0) {
        JNViewStyle(_jiluView, 5, nil, 0);
        [_jiluView setH:self.jiluArrays.count * JN_HH(50) + JN_HH(25)];
        h += JN_HH(50) * self.jiluArrays.count + JN_HH(35);
    }else
    {
        [_jiluView addSubview:JnLabel(CGRectMake(JN_HH(15), JN_HH(25), JN_HH(100), JN_HH(50)), @"暂无记录", JN_HH(15.5), COLOR_H1, 0)];
        [_jiluView setH:JN_HH(50) + JN_HH(25)];
        h += JN_HH(50) + JN_HH(35);
    }
    [self didShuaxinView];
}

-(void)didShuaxinView
{
    float h = _jiluView.height + [_jiluView getY] + JN_HH(10);

    [_qianbaoView setY:h];
    self.downView.height = [_qianbaoView getY] + _qianbaoView.height + JN_HH(10);

    self.baseScollView.contentSize = CGSizeMake(0, [self.downView getY] + self.downView.height);

    for (int i = 0 ; i < 2; i++) {
        ShouyeQianView * view = (ShouyeQianView *)[_qianbaoView viewWithTag:100 +i];
<<<<<<< HEAD
        if ( i < [CurrencyManager sharedInstance].allZiCurrencyModel.count) {
            ZiCurrencyModel * ziModel = [CurrencyManager sharedInstance].allZiCurrencyModel[i];
            if (view) {
                view.eboLabel.text = ziModel.coin_name;
                view.yueLabel.text = ziModel.balance;
            }
            if (i == 0) {
                [_ccsyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
            }else {
                [_usdtyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
            }
            if ([ziModel.coin_species isEqual:self.curManager.selcurrencyModel.coin_species]) {
                [_zongziLabel setText:ziModel.balance componentsSeparatedByString:@"."];
                _conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;
            }
        }else {
            view.eboLabel.text = BI_A1;
            view.yueLabel.text = @"去开通";
            [_usdtyueLabel setText:@"0" componentsSeparatedByString:@"."];
        }
=======
//        if ( i < [CurrencyManager sharedInstance].allZiCurrencyModel.count) {
//            ZiCurrencyModel * ziModel = [CurrencyManager sharedInstance].allZiCurrencyModel[i];
//            if (view) {
//                view.eboLabel.text = ziModel.coin_name;
//                view.yueLabel.text = ziModel.balance;
//            }
//            if (i == 0) {
//                [_ccsyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
//            }else {
//                [_usdtyueLabel setText:view.yueLabel.text componentsSeparatedByString:@"."];
//            }
//            if ([ziModel.coin_species isEqual:self.curManager.selcurrencyModel.coin_species]) {
//                [_zongziLabel setText:ziModel.balance componentsSeparatedByString:@"."];
//            }
//        }else {
//            view.eboLabel.text = BI_A1;
//            view.yueLabel.text = @"去开通";
//            [_usdtyueLabel setText:@"0" componentsSeparatedByString:@"."];
//        }
>>>>>>> 07f82cfd39cb013e328119def3b4fdccf3dddbd2

    }



}

@end
