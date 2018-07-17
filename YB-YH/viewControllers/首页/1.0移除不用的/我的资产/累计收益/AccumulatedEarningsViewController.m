//
//  AccumulatedEarningsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "AccumulatedEarningsViewController.h"
#import "DwTableView.h"
#import "UIMoneyLabel.h"
#import "AccumulatedEarningModel.h"  //模拟数据

@interface AccumulatedEarningsViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{
    UIMoneyLabel * _shouyiLabel;  //每个币中的收益
    UIButton * _navRightBtn;

}


@property(nonatomic,retain)DwTableView * tableView;


@end

@implementation AccumulatedEarningsViewController

-(void)createNavView
{
    [super createNavView];
    self.navView.backgroundColor = [UIColor clearColor];

    _navRightBtn = JnButtonColorIndexSize(CGRectMake(SCREEN_WIDTH - JN_HH(80), CGNavView_20h() + 12, JN_HH(70), 20), @"全部收益", 12.5, COLOR_WHITE, COLOR_A1, 1, self, @selector(rightBtnClick:), 0);
    JNViewStyle(_navRightBtn, 10, COLOR_A3, 1);
    [self.navView addSubview:_navRightBtn];

}


-(void)createView
{
    [super createView];
    UIImage * bgImage = [UIImage imageNamed:@"wd_beijin-1"];
    [self.view addSubview: JnImageView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), bgImage)];
    [self.view addSubview: JnUIView(CGRectMake(0, self.nav_h +JN_HH(100), SCREEN_WIDTH, JN_HH(10)), COLOR_WHITE)];

    _shouyiLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(JN_HH(15), JN_HH(30) + self.nav_h,SCREEN_WIDTH - JN_HH(30), JN_HH(40))];
    [_shouyiLabel setLeftTextColor:COLOR_WHITE rightColor:COLOR_A3];
    [_shouyiLabel setLeftFont:[UIFont systemFontOfSize:JN_HH(30)] rightFont:[UIFont systemFontOfSize:JN_HH(13.5)]];
    [_shouyiLabel rightLabelup:NO];
    _shouyiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_shouyiLabel];



    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, self.nav_h + JN_HH(110), SCREEN_WIDTH, SCREEN_HEIGHT - JN_HH(100) - self.nav_h) url:@"" modelName:@"AccumulatedEarningModel" cellName:@"AccumulatedEarningCell" delegate:self];
    [self.tableView readTableView].backgroundColor = COLOR_WHITE;
    [self.view addSubview:[self.tableView readTableView]];

//模拟数据
    [_shouyiLabel setText:[NSString stringWithFormat:@"%@ %@",@"300.00",BI_A0] componentsSeparatedByString:@" "];

    NSMutableArray * arrayDatas = [NSMutableArray array];
    for (int i = 0 ; i < 20;  i++) {
        AccumulatedEarningModel * aModel = [[AccumulatedEarningModel alloc]init];
        aModel.num = [NSString stringWithFormat:@"%d",i];
        aModel.timer = @"1990-01-01";
        if (i == 0) {
            aModel.selber  = @(1);
        }
        [arrayDatas addObject:aModel];
    }
    [self.tableView ceshiArrays:arrayDatas];
    
}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSObject *)dict index:(int)index
{

}


-(void)rightBtnClick:(UIButton *)btn
{

}

@end
