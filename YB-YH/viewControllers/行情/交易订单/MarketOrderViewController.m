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
    int  _selstate;
}
@property(nonatomic,retain)DwTableView * tableView;

@end

@implementation MarketOrderViewController

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:2];
}

-(void)Initialize
{
    [super Initialize  ];
    _selstate = 0;
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


    self.tableView = [DwTableView initWithFrame:CGRectMake(0, self.nav_h + JN_HH(50), SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h - JN_HH(56)) url:URL(@"/transfer/Wallet/getChangeList") modelName:@"MarketOrderModel" cellName:@"MarketOrderCell" delegate:self];
    [self.view addSubview:self.tableView.readTableView];



    [self tableViewDownWithPage:1];
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

    _selstate = (int)btn.tag - 100;
    [self tableViewDownWithPage:1];

}

-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
    MarketOrderModel * orModel = (MarketOrderModel *)myTableViewModel;
    MarketOrderdDetailsViewController * vc = [[MarketOrderdDetailsViewController alloc]initWithNavTitle:@"交易订单详情" detailesId:orModel.order_id];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)downDatas
{
    //  [self getDownDatas:@"/transfer/Wallet/getChangeList" withdict:@{@"num":@"10",@"page":@"1"} index:501 type:0];
    //  [self postdownDatas:@"/transfer/Wallet/getChangeList" withdict:@{@"num":@"10",@"page":@"1"} index:501];
}

-(void)tableViewDownWithPage:(int)page
{
    if (_selstate != 0 ) {
        NSArray * array = @[@"",@"81",@"110"];
        [self.tableView downWithdict:@{@"page":[NSNumber numberWithInt:page],@"num":@"10",@"state":array[_selstate]} index:page];
    }else
        [self.tableView downWithdict:@{@"page":[NSNumber numberWithInt:page],@"num":@"10"} index:page];
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewDownWithPage:page];
}


-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 501)
    {
        NSLog(@"responseDict========%@",responseDict);
    }else if(index == 1)
    {

    }
}

-(void)readDowndatawithArray:(NSArray *)dataArray index:(int)index
{
    if (index == -1) {
        NSLog(@"%@",dataArray);
    }
}

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    NSLog(@"%@",dict);
}

@end
