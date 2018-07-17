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

@interface MarketViewController ()<JNBaseViewDelegate>
{
    MaeketCurveView * _curveView;

    UIButton *  _selBtn;

    UILabel * _ccsLabel ;  //CCS交易 后面的label

    UIView * _downScrollView;
    int _max;

}

@property(nonatomic,retain)  MarketSlidingView * slidingView;

@property(nonatomic,retain)UIView * downView;
@end

@implementation MarketViewController

-(MarketSlidingView *)slidingView
{
    if (!_slidingView) {
        self.slidingView = [MarketSlidingView showWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, JN_HH(60)) index:0 sliding:^(float index) {
            // 看看选中的按钮的tag
            MarketView * etView1 = (MarketView *)[self->_downScrollView viewWithTag:self->_selBtn.tag + 100];
            if (etView1) {
                [etView1 setTextnum:self->_max * index];
            }
        }];
                [self.view addSubview:_slidingView ];
    }
    return _slidingView;
}

-(void)createNavView
{
    [super createNavView];
    [self.navView addDividingLine];
    [self.navView setStyle:3];
    [self.navView.rightButton setBackgroundImage:MYimageNamed(@"hq_dingdan") forState:0];
}

-(void)Initialize
{
    [super Initialize ];
    _max = 100000;
}

-(void)createView
{
    [super createView];

    self.view.backgroundColor = COLOR_B5;

    _curveView = [[MaeketCurveView alloc]initWithFrame:CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(150)) curveModels:nil higt:600];
    [self.view addSubview:_curveView];

    float h = self.nav_h + JN_HH(150);

    _downView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, SCREEN_HEIGHT), COLOR_WHITE);
    [self.view addSubview:_downView];

//    UIImageView * bgImageView = JnImageView(CGRectMake(0,0, SCREEN_WIDTH, JN_HH(97)), MYimageNamed(@""));
//    bgImageView.userInteractionEnabled = YES ;
//    [_downView addSubview: bgImageView];

    [_downView addSubview:JnLabelType(CGRectMake(JNVIEW_X0, 0, JN_HH(100), JN_HH(30)), UILABEL_4, BI_A0STR(@"交易"), 0)];
    _ccsLabel = JnLabelType(CGRectMake(JNVIEW_X(63), 0, SCREEN_WIDTH - JNVIEW_W(63), JN_HH(30)), UILABEL_6, BI_A0STR(@"/ETH"), 2 );
    _ccsLabel.textColor = COLOR_A3;
    [_downView addSubview:_ccsLabel];

    _downScrollView = JnUIView(CGRectMake(0, JN_HH(70), SCREEN_WIDTH * 2, _downView.height - JN_HH(97)), COLOR_H3);
    [_downView addSubview:_downScrollView];

    NSArray * array = @[@"我要买",@"我要卖"];
    for (int i = 0 ; i < array.count; i++) {
        UIButton * btn = JnButtonTextType(CGRectMake(SCREEN_WIDTH / array.count * i, JN_HH(30), SCREEN_WIDTH / array.count, JN_HH(40)), array[i], 1, self, @selector(btnClick:));
        [btn setBackgroundColor:COLOR_WHITE];
        btn.tag = 100 + i ;
        [_downView addSubview:btn];

        [btn setTitleColor:COLOR_WHITE forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
            _selBtn = btn;
              [btn setBackgroundColor:COLOR_A1];
        }else {
            [self addBtn:btn];
        }

        MarketView * etView = [[MarketView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _downScrollView.height) style:i + 1 ];
        etView.delegate = self;
        etView.tag = 200 +i;
        etView.max = _max;
        [_downScrollView addSubview:etView];
    }

}

-(void)downDatas
{
    //获取曲线图
    [self postdownDatas:@"transfer/list/getKindlelist" withdict:@{@"size":@"50",@"period":@"4hour",@"symbol":@"ethusdt"} index:1];
    //获取比例
    [self postdownDatas:@"/transfer/wallet/getEBOProportion" withdict:@{@"coin_name":@"eth"} index:2];
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
    }else if(index == 2)
    {
        self.curManager.portionModel = [[ProportionModel alloc]initWithDict:responseDict];
        for (int i = 0 ; i < 2; i++) {
            MarketView * etView = (MarketView *)[_downScrollView viewWithTag:200 +i];
            if (etView) {
                etView.bili = [self.curManager.portionModel.propor floatValue];
                etView.rmbBili = [self.curManager.portionModel.ebocny floatValue];
            }
        }


    }else if(index == 501)
    {
        NSLog(@"responseDict ===== %@",responseDict);
    }
}

-(void)addListeningkeyboard
{

    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.downView setY:self.nav_h];
            [self.slidingView setY:(SCREEN_HEIGHT-JN_HH(60)-h) ];
        }];
    } keyboard:^(CGFloat h) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.downView setY:self.nav_h + JN_HH(150)];
            [self.slidingView setY:SCREEN_HEIGHT ];
        }];
    }];
}

-(void)btnClick:(UIButton *)btn
{
    if (_selBtn == btn) {
        return ;
    }
  //  [Listeningkeyboard endEditing];
    _selBtn.selected = NO;
    _selBtn.backgroundColor = COLOR_WHITE;
    [self addBtn:_selBtn];
    _selBtn = btn ;
    _selBtn.selected = YES;
    _selBtn.backgroundColor = COLOR_A1;
    [self removeBtn:_selBtn];

    [UIView animateWithDuration:0.3 animations:^{
        if (btn.tag == 100) {
            [self->_downScrollView setX:0];
        }else {
            [self->_downScrollView setX:-SCREEN_WIDTH];
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
        [_slidingView setIndex:1];
    }else {
        [_slidingView setIndex:[text floatValue]/_max];
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
