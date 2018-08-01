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
#import "BaseDDView.h"

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

    UIView * _qianbaoView;

    JNCoinView * _conView;  //切换

    UIButton * _addQianBtn;
    UIImageView *_addQianImageView;
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
    [self.navView setStyle:2];
    [self.navView setRrturnBackImage:MYimageNamed(@"hq_dingdan")];
    _conView = [[JNCoinView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 30, CGNavView_20h(), 60, 44)];
    _conView.imageView.image =MYimageNamed(@"选择框剪头1");
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
    self.baseScollView.frame = CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.tab_h - self.nav_h);
    self.baseScollView.bounces = NO;
    self.baseScollView.backgroundColor = COLOR_WHITE;

    float h =  JN_HH(10);
    _zongziLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(JN_HH(15), h , SCREEN_WIDTH - JN_HH(30), JN_HH(40))];
    [_zongziLabel setTextAlignment:NSTextAlignmentCenter];
    [_zongziLabel setText:@"0" componentsSeparatedByString:@"."];
    [_zongziLabel setLeftTextColor:COLOR_BL_2 rightColor:COLOR_BL_2];
    [self.baseScollView addSubview:_zongziLabel];

    h += JN_HH(40);
    [self.baseScollView addSubview:JnLabel(CGRectMake(0, h , SCREEN_WIDTH, JN_HH(20)), @"账户余额", JN_HH(13.5), COLOR_BL_2, 1)];

    h += JN_HH(30);
    [self.baseScollView addUnderscoreWihtFrame:CGRectMake(0, h, SCREEN_WIDTH, 1)];

     NSArray *  titleArray = @[@"转入",@"转出"];
     NSArray *  imageArray = @[@"sy_zhuanru",@"sy_zhuanchu"];

    float label_w  = SCREEN_WIDTH  / titleArray.count;
    for (int i = 0;  i < titleArray.count; i++)
    {
        UIButton * btn = JnButtonTextType(CGRectMake(label_w * i , h, label_w, JN_HH(50) ), @"", 0, self, @selector(btnClick:));
        btn.backgroundColor = COLOR_WHITE;
        btn.tag = 100 + i;
        [self.baseScollView addSubview:btn];
      
        [btn addSubview:JnImageView(CGRectMake(btn.width * 0.5 - JN_HH(44), JN_HH(3), JN_HH(44), JN_HH(44)), MYimageNamed(imageArray[i]))];

        [btn addSubview:JnLabelType(CGRectMake(btn.width * 0.5, JN_HH(10), btn.width * 0.5, JN_HH(30)), UILABEL_2, titleArray[i], 0)];
        if (i != 0 ) {
            [btn addSubview:JnUIView(CGRectMake(0, JN_HH(5), 1, btn.height - JN_HH(10)), DIVIDER_COLOR1)];
        }
    }
    h += JN_HH(50);
//轮播图
    UIView * paoView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH , JN_HH(105)), COLOR_WHITE);
    [self.baseScollView addSubview:paoView];

    _ffilingView = [[ShufflingView alloc]initWithFrame:CGRectMake(0, 0, paoView.width, JN_HH(80)) BgColor:COLOR_WHITE];
    [paoView addSubview:_ffilingView];

//跑马灯
    [paoView addSubview:JnImageView(CGRectMake(JN_HH(20), JN_HH(86),JN_HH(10), JN_HH(12)), MYimageNamed(@"sy_laba"))];

    SXHeadLine *headLine3 = [[SXHeadLine alloc]initWithFrame:CGRectMake(JN_HH(30), JN_HH(80), paoView.width - JN_HH(60), JN_HH(25))];
    headLine3.messageArray = @[@"",@"",@"",@"", @""];
    [headLine3 setBgColor:[UIColor whiteColor] textColor:COLOR_A1 textFont:[UIFont systemFontOfSize:13]];
    [headLine3 setScrollDuration:3 stayDuration:3];
    headLine3.hasGradient = YES;
    [paoView addSubview:headLine3];

    [headLine3 changeTapMarqueeAction:^(NSInteger index) {

      //  NSLog(@"你点击了第 %ld 个button！内容：%@", index, headLine3.messageArray[index]);

    }];
    _headLine3 = headLine3;
//我的数据
   h += JN_HH(115);
    [self.baseScollView addUnderscoreWihtFrame:CGRectMake(0, h - JN_HH(10), SCREEN_WIDTH, JN_HH(10))];
    [self.baseScollView addSubview:[[BaseView alloc]initWithFrame:CGRectMake(0, h , SCREEN_WIDTH, JN_HH(44)) leftName:nil title:@"赚取工作量证明" rightName:@"jiantou_H1_88"]];
    h += JN_HH(44);
    UIScrollView * gongzScrollView = JnScrollView(CGRectMake(JNVIEW_X0, h, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(150)), COLOR_WHITE);
    [self.baseScollView addSubview:gongzScrollView];
    NSArray * nameArray = @[@"xyxz",@"zkfl",@"zkfl"];
    for (int i = 0 ; i < nameArray.count; i++) {
        [gongzScrollView addSubview:JnImageView(CGRectMake(JN_HH(290) * i, 0, JN_HH(285), JN_HH(140)), MYimageNamed(nameArray[i]))];
    }
    gongzScrollView.contentSize = CGSizeMake(JN_HH(290) * nameArray.count, 0);
    h += JN_HH(160);
    [self.baseScollView addUnderscoreWihtFrame:CGRectMake(0, h - JN_HH(10), SCREEN_WIDTH, JN_HH(10))];
    UIImageView * imageView = JnImageView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(262)), MYimageNamed(@"gamepay_ceshi"));
    [imageView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        [MYAlertController showTitltle:@"功能暂未开放"];
    }];
    [self.baseScollView addSubview:imageView];

    h +=  JN_HH(272);
    [self.baseScollView addUnderscoreWihtFrame:CGRectMake(0, h - JN_HH(10), SCREEN_WIDTH, JN_HH(10))];

    _qianbaoView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(44) + JN_HH(80)), COLOR_WHITE);
    [self.baseScollView addSubview:_qianbaoView];

    [_qianbaoView addSubview:[[BaseView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, JN_HH(44)) leftName:nil title:@"我的钱包" rightName:nil]];
    UIButton * btn = JnButton_tag(CGRectMake(SCREEN_WIDTH * 0.5, 0, SCREEN_WIDTH * 0.5, JN_HH(44)), COLOR_WHITE, self, @selector(addQianClick:), 0);
    [_qianbaoView addSubview:btn];

    [btn setImage:MYimageNamed(@"sy_tjqb") forState:0];
    [btn setTitle:@"添加钱包" forState:0];
    [btn setTitleColor:COLOR_BL_2 forState:0];
    [btn setTitleColor:COLOR_B5 forState:UIControlStateSelected];
    [btn setImage:MYimageNamed(@"sy_tjqb") forState:UIControlStateSelected];
    [btn titleLabel].font = [UIFont systemFontOfSize:UILABEL_BZ_2];
    [_qianbaoView addUnderscoreWihtFrame:CGRectMake(0, JN_HH(44) - 1, SCREEN_WIDTH, 1)];

    ShouyeQianView * qianView = [[ShouyeQianView alloc]initWithFrame:CGRectMake(JNVIEW_X0, JN_HH(44), SCREEN_WIDTH - JNVIEW_W(0), JN_HH(80))];
    [_qianbaoView addSubview:qianView];
    qianView.imgeV.image = MYimageNamed(@"sy_ebog");
    qianView.titleLb.text = BI_A0;
    qianView.tag = 1000;
    self.baseScollView.contentSize = CGSizeMake(0, [_qianbaoView getY] + _qianbaoView.height);
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

        //跑马灯
        NSArray * array1 = responseDict[@"notice"];
        NSMutableArray * filArr = [NSMutableArray array];
        for (int  i =  0 ; i < array1.count; i++) {
            NSDictionary * dict = array[i];
            [filArr addObject:dict[@"title"]];
        }
        _headLine3.messageArray = filArr;

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
        [self didShuaxinView];
    }
}

-(void)didShuaxinView
{
    //修改显示的
      ZiCurrencyModel * model = [CurrencyManager readZiModelWithSpecies:self.curManager.selcurrencyModel.coin_species];
    [_zongziLabel setText:model.balance componentsSeparatedByString:@"."];

//刷新下面的 钱包数据
    NSArray * biArray = @[BI_A0,BI_A1];
    NSArray * biImageArray = @[@"sy_ebog",@"sy_eth"];
    for (int i = 0 ; i < 2; i++) {
        ZiCurrencyModel * model = [CurrencyManager readZiModelWithSpecies:[CurrencyManager readspeciesWithName:biArray[i]]];
        if ([CurrencyManager readisOpenWithName:biArray[i]]) { //开通
            ShouyeQianView * qianView = (ShouyeQianView *)[_qianbaoView viewWithTag:1000 + i];
            if (qianView == nil) {
                NSLog(@"asdfsadfsdf");
                qianView = [[ShouyeQianView alloc]initWithFrame:CGRectMake(JNVIEW_X0, JN_HH(44) + JN_HH(90) * i, SCREEN_WIDTH - JNVIEW_W(0), JN_HH(80))];
                qianView.tag = 1000 + i ;
                [_qianbaoView addSubview:qianView];
            }
            qianView.imgeV.image = MYimageNamed(biImageArray[i]);
            qianView.titleLb.text = biArray[i];
            qianView.balanceLb.text = [NSString stringWithFormat:@"%@",model.balance];
            if (i == 0) {
                qianView.rmbLb.text = [NSString stringWithFormat:@"¥%f",[model.balance floatValue] / self.curManager.portionModel.ebocny];
            }else {
                qianView.rmbLb.text = [NSString stringWithFormat:@"¥%f",[model.balance floatValue]  * self.curManager.portionModel.propor/ self.curManager.portionModel.ebocny];
            }
            [_qianbaoView setH:JN_HH(44)+ JN_HH(90) * i + JN_HH(90)];
            self.baseScollView.contentSize = CGSizeMake(0, [_qianbaoView getY] + _qianbaoView.height);

            if ( [biArray[i] isEqual:BI_A1]) {
                _addQianBtn.selected = YES;
            }
        }
    }
}

-(void)addQianClick:(UIButton *)btn
{
    if (btn.selected == YES) {
        return ;
    }
    MoneyViewController * vc = [[MoneyViewController alloc]initWithNavTitle:@"创建钱包" name:BI_A1];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
