//
//  CreditViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/19.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "CreditViewController.h"
#import "AssetModel.h"
#import "TaskDoView.h"
#import "AssetsBtn.h"


@interface CreditViewController () <UIScrollViewDelegate,JNBaseViewDelegate>
{
    UILabel * _pinfenLabel;  //信用评分
    UILabel * _pinfentyleLabel; //信用评价
    UILabel * _pingfenTimerLabel; //评分的时间

    UILabel * _userNameLabel;  //用户显示的名称

    TaskDoView * _taskView;
}

@property(nonatomic,retain)UIView * downView;
//保存高级任务的数组
@property(nonatomic,retain)NSMutableArray * gaojiArrays;

@property(nonatomic,retain)UIView * gaojiView;

@end

@implementation CreditViewController

-(NSMutableArray *)gaojiArrays
{
    if (!_gaojiArrays) {
        _gaojiArrays = [NSMutableArray array];
    }
    return _gaojiArrays;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated ];
    [_taskView startTimer];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_taskView endTimer];
}

-(void)createNavView
{
    [super createNavView];
    self.navView.backgroundColor = [COLOR_A1 colorWithAlphaComponent:0];
}

-(void)createView
{
    [super createView];

    UIImage * bgImage = [UIImage imageNamed:@"wd_beijin-1"];
    self.baseScollView.frame = CGRectMake(0, -CGNavView_20h(), SCREEN_WIDTH, SCREEN_HEIGHT - self.tab_h + CGNavView_20h());
    [self.baseScollView  addSubview:JnImageView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), bgImage)];
    self.baseScollView.delegate = self;
    self.baseScollView.bounces = NO;

    _pinfenLabel = JnLabel(CGRectMake(0, self.nav_h + JN_HH(0), SCREEN_WIDTH, JN_HH(40)), @"600", JN_HH(28), COLOR_WHITE, 1);
    [self.baseScollView addSubview:_pinfenLabel];

    _pinfentyleLabel = JnLabel(CGRectMake(0, self.nav_h + JN_HH(42), SCREEN_WIDTH, JN_HH(20)), @"信用良好", JN_HH(15), COLOR_A3, 1);
    [self.baseScollView addSubview:_pinfentyleLabel];

    _pingfenTimerLabel = JnLabel(CGRectMake(0, self.nav_h + JN_HH(65), SCREEN_WIDTH, JN_HH(15)), @"评估时间: 2018-05-26", JN_HH(10.5), COLOR_A1, 1);
    [self.baseScollView addSubview:_pingfenTimerLabel];

    UIButton * queBtn = JnButtonTextType(CGRectMake(JN_HH(40), JN_HH(95) + self.nav_h, SCREEN_WIDTH  * 0.5 - JN_HH(55), JN_HH(35)), @"守约记录", 0, self, @selector(shouyueBtnClick));
    JNViewStyle(queBtn, JN_HH(17.5), nil, 0);
    [[queBtn titleLabel] setFont:[UIFont systemFontOfSize:14.5]];
    [self.baseScollView addSubview:queBtn];

    UIButton * queBtn1 = JnButtonTextType(CGRectMake(JN_HH(15) + SCREEN_WIDTH * 0.5, JN_HH(95) + self.nav_h, SCREEN_WIDTH  * 0.5 - JN_HH(55), JN_HH(35)), @"违约记录", 0, self, @selector(weiyueBtnClick));
    [[queBtn1 titleLabel] setFont:[UIFont systemFontOfSize:14.5]];
    JNViewStyle(queBtn1, JN_HH(17.5), nil, 0);
    [self.baseScollView addSubview:queBtn1];

    self.downView = JnUIView(CGRectMake(0, self.nav_h + JN_HH(160), SCREEN_WIDTH, SCREEN_HEIGHT * 2 - self.nav_h - JN_HH(230)), COLOR_H3);
    [self.baseScollView addSubview:self.downView];

// 评估记录
    UIView * paoView = JnUIView(CGRectMake(JN_HH(20), - JN_HH(13), SCREEN_WIDTH - JN_HH(40), JN_HH(70)), COLOR_WHITE);
    JNViewStyle(paoView, 5, nil, 0);
    [self.downView addSubview:paoView];

    _userNameLabel = JnLabel(CGRectMake(JN_HH(20), JN_HH(7), paoView.width - JN_HH(100), JN_HH(30)), @"Hi,霸气的队友", JN_HH(16.5), COLOR_A1, 0);
    [paoView addSubview:_userNameLabel];

    [paoView addSubview:JnLabel(CGRectMake(JN_HH(20), JN_HH(40), paoView.width - JN_HH(100), JN_HH(20)), @"了解你更多,评估就会更准呢", JN_HH(13.5), SXRGB16Color(0x737375), 0)];
    [paoView addSubview:JnLabel(CGRectMake(0, paoView.height * 0.5 - JN_HH(10), paoView.width - JN_HH(33), JN_HH(20)), @"评估记录", JN_HH(12.5), COLOR_A1, 2)];
    [paoView addSubview:JnImageView(CGRectMake(paoView.width - JN_HH(45), paoView.height * 0.5 - JN_HH(20), JN_HH(40), JN_HH(40)), MYimageNamed(@"jiantou_A1_88"))];
   //点击评估记录
    [paoView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {

    }];
//必做任务

    [self.downView addSubview:JnLabel(CGRectMake(JN_HH(25), JN_HH(70), JN_HH(60), JN_HH(20)), @"必做任务", JN_HH(13.5), COLOR_H1, 0)];
    [self.downView addSubview:JnLabel(CGRectMake(JN_HH(85), JN_HH(75), SCREEN_WIDTH -JN_HH(115), JN_HH(15)), @"动动手指,轻松加信用,提升共享额度,领糖果", JN_HH(11.5), COLOR_H1, 0)];



    TaskDoView * taskView = [[TaskDoView alloc]initWithFrame:CGRectMake(JN_HH(15), JN_HH(92), SCREEN_WIDTH - JN_HH(30), JN_HH(100)) textArrays:nil btnClsName:@"AssetsBtn"];
    taskView.delegate = self;
    [self.downView addSubview:taskView];

    _taskView = taskView;

    float hh = JN_HH(190);

    self.gaojiView = JnUIView(CGRectMake(0, hh, SCREEN_WIDTH , JN_HH(100)), self.downView.backgroundColor);
    [self.downView addSubview:self.gaojiView];


//模拟数据
    NSMutableArray * asserArray = [NSMutableArray array];
    NSArray * titleArrays =@[@"邀请好友",@"人脸识别",@"关注公众号",@"实名认证",@"高级认证",@"备份钱包"];
    NSArray * imageArrays = @[@"sy_xingyongyqhy",@"sy_xingyongrlsb",@"sy_xingyongwxgzh",@"sy_xingyongsmrz",@"sy_xingyonggjrz",@"sy_xingyongqbbf"];
    NSArray * numArrays = @[@"10",@"10",@"10",@"10",@"10",@"10"];
    for (int i = 0 ; i < titleArrays.count; i++) {
        AssetModel * assModel = [[AssetModel alloc]init];
        assModel.title = titleArrays[i];
        assModel.imageUrl = imageArrays[i];
        assModel.num = numArrays[i];
        [asserArray addObject:assModel];
    }
//高级任务
    titleArrays = @[@"支付宝授权",@"京东授权",@"手机运营授权",@"信用卡邮箱账单",@"学信网授权",@"开通共享功能",@"币种第一次充值",@"第一次共享成功",@"第一次借币到期归还"];
    imageArrays = @[@"sy_xingyongzfb",@"sy_xingyongjd",@"sy_xingyongsjyys",@"sy_xingyongyx",@"sy_xingyongxxw",@"sy_xingyongktgx",@"sy_xingyongsccb",@"sy_xingyonggxcg",@"sy_xingyongjbgh"];
    numArrays = @[@"10",@"10",@"10",@"10",@"10",@"10",@"10",@"10",@"10"];
    NSMutableArray * assergaojiArray = [NSMutableArray array];
    for (int i = 0 ; i < titleArrays.count; i++) {
        AssetGaojiModel * assModel = [[AssetGaojiModel alloc]init];
        assModel.title = titleArrays[i];
        assModel.imageUrl = imageArrays[i];
        assModel.num = numArrays[i];
        assModel.selNum = [NSNumber numberWithInteger:i % 2];
        [assergaojiArray addObject:assModel];
    }
    [_taskView showWtihTextArrays:asserArray];
    [self loadgaojiArray:assergaojiArray];

    //重新计算 下面的view 的frame
    self.baseScollView.contentSize = CGSizeMake(0, [self.downView getY] + self.downView.height);

}

-(void)loadgaojiArray:(NSArray *)gaojiArrays
{
    for (UIView * view  in self.gaojiView.subviews) {
        [view removeFromSuperview];
    }
    [self.gaojiView addSubview:JnLabel(CGRectMake(JN_HH(25), 0, JN_HH(80), JN_HH(20)), @"高奖励任务", JN_HH(13.5), COLOR_H1, 0)];
    for (int i = 0 ; i < gaojiArrays.count; i++) {
        AssetsGaojiBtn * btn = [[AssetsGaojiBtn alloc]initWithFrame:CGRectMake(JN_HH(15), JN_HH(25) + JN_HH(75) * i, SCREEN_WIDTH - JN_HH(30), JN_HH(60))];
        [btn addTarget:self action:@selector(gaojiClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200 + i;
        //JnButton_tag(CGRectMake(JN_HH(20), JN_HH(20) + JN_HH(60) * i, SCREEN_WIDTH - JN_HH(40), JN_HH(50)), COLOR_WHITE, self, @selector(gaojiClick:), 200 + i);
        [btn setModel:gaojiArrays[i]];
        [self.gaojiView addSubview:btn];
    }
    self.gaojiView.height = gaojiArrays.count * JN_HH(75) + JN_HH(20);
    self.downView.height = [self.gaojiView getY] + self.gaojiView.height;
    self.baseScollView.contentSize = CGSizeMake(0, self.downView.height + [self.downView getY]);

}



-(void)shouyueBtnClick
{

}

-(void)weiyueBtnClick
{

}

-(void)gaojiClick:(UIButton *)btn
{
    if (btn.selected == YES) {
        return ;
    }
    btn.selected = YES ;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navView.backgroundColor = [COLOR_A1 colorWithAlphaComponent:scrollView.contentOffset.y / JN_HH(160.00)];


}

-(void)didView:(UIView *)view btn:(UIButton *)btn
{
    if (btn.selected == YES) {
        return ;
    }
    btn.selected = YES ;
}
@end
