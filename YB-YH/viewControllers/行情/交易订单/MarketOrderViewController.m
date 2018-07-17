//
//  MarketOrderViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketOrderViewController.h"
#import "DwTableView.h"
#import "MarketOrderModel.h"
#import "MarketOrderCell.h"
#import "MarketOrderdDetailsViewController.h"

@interface MarketOrderViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{
    UIButton *  _selBtn;
}
@property(nonatomic,retain)DwTableView * tableView;

@end

@implementation MarketOrderViewController

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:2];
}
-(void)createView
{
    [super createView];

    UIView * upView = JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(50)), COLOR_WHITE);
    [self.view addSubview:upView];
    NSArray * titleArray = @[@"全部",@"交易中",@"申诉订单"];
    for (int i = 0 ; i < titleArray.count; i++) {
        UIButton * btn = JnButtonTextType(CGRectMake(SCREEN_WIDTH / titleArray.count * i, 0, SCREEN_WIDTH / titleArray.count, JN_HH(50)), titleArray[i], 3, self, @selector(btnClick:));
        btn.tag = 100 + i ;
        JNViewStyle(btn, 0, COLOR_B5, 1);
        [upView addSubview:btn];
        [btn setTitleColor:SXRGB16Color(0x4c4c4c) forState:0];
        [btn setTitleColor:COLOR_WHITE forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
            _selBtn = btn;
             JNViewStyle(btn, 0, COLOR_A1, 1);
            _selBtn.backgroundColor = COLOR_A1;
        }
    }


    self.tableView = [DwTableView initWithFrame:CGRectMake(0, self.nav_h + JN_HH(50), SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(56)) url:@"" modelName:@"MarketOrderModel" cellName:@"MarketOrderCell" delegate:self];
    [self.view addSubview:self.tableView.readTableView];

    NSMutableArray * arrayDatas = [NSMutableArray array];
    for (int i = 0 ; i < 10; i++) {
        MarketOrderModel * orModel = [[MarketOrderModel alloc]initWithDict:@{}];
        orModel.style = @(1);
        [arrayDatas addObject:orModel];
    }
    [self.tableView ceshiArrays:arrayDatas];
    
}

-(void)Initialize
{
    [super Initialize ];

}

-(void)btnClick:(UIButton *)btn
{
    if (_selBtn == btn) {
        return ;
    }
    //  [Listeningkeyboard endEditing];
    _selBtn.selected = NO;
    _selBtn.backgroundColor = COLOR_WHITE;
     JNViewStyle(_selBtn, 0, COLOR_B5, 1);
    _selBtn = btn ;
    _selBtn.selected = YES;
     JNViewStyle(_selBtn, 0, COLOR_A1, 1);
    _selBtn.backgroundColor = COLOR_A1;

}

-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
    MarketOrderModel * orModel = (MarketOrderModel *)myTableViewModel;
    MarketOrderdDetailsViewController * vc = [[MarketOrderdDetailsViewController alloc]initWithNavTitle:@"交易订单详情" detailesId:orModel.detailesId];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
