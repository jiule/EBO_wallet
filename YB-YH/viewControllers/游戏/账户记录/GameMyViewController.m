//
//  GameMyViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameMyViewController.h"
#import "UIMoneyLabel.h"
#import "DwTableView.h"
#import "TransferRecordModel.h"
#import "ScreeningTransferView.h"
#import "TranferDetailsViewController.h"


@interface GameMyViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{
    UIMoneyLabel * _zichanLabel;
}
@property(nonatomic,retain)DwTableView * tableView;
@end

@implementation GameMyViewController

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:2];
}

-(void)createView
{
    float h = self.nav_h;  float x = JN_HH(15);
    UIView * upView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(100)), COLOR_WHITE);

    [upView addSubview:JnLabelType(CGRectMake(x, JN_HH(10), JN_HH(150), JN_HH(30)), UILABEL_3, BI_A0STR(@"余额"), 0)];
    _zichanLabel = [[UIMoneyLabel alloc]initWithFrame:CGRectMake(x, JN_HH(40), SCREEN_WIDTH, JN_HH(45))];
    [_zichanLabel setLeftTextColor:SXRGB16Color(0x4d4d4d) rightColor:SXRGB16Color(0x4d4d4d)];
    [_zichanLabel setLeftFont:[UIFont systemFontOfSize:JN_HH(35.5)] rightFont:[UIFont systemFontOfSize:JN_HH(35.5)]];
    [upView addSubview:_zichanLabel];
    [upView addUnderscoreWihtFrame:CGRectMake(0, JN_HH(90), SCREEN_WIDTH, JN_HH(10))];

    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, h , SCREEN_WIDTH, SCREEN_HEIGHT  - h) url:URL(@"transfer/wallet/getTransferList") modelName:@"TransferModel" cellName:@"TransferRecordCell" delegate:self];
    [self.tableView readTableView].backgroundColor = COLOR_H3;
    [self.view addSubview:[self.tableView readTableView]];
    [self.tableView setTableViewHearView:upView];


    ZiCurrencyModel * zim = [CurrencyManager readZiModelWithSpecies:[CurrencyManager readspeciesWithName:BI_A0]];
    [_zichanLabel setText:zim.balance componentsSeparatedByString:@"."];

}

-(void)downData
{
    [self tableViewWithPage:1];
}

-(void)tableViewWithPage:(int)page
{
    //NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"trans_type":@"Game"}];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:@{@"trans_type":@"Game"}];
    [dict setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [dict setObject:@"10" forKey:@"num"];
    [self.tableView downWithdict:dict index:page];
}


-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewWithPage:page];
}
-(void)DwtableView:(DwTableView *)tableView model:(DwTableViewModel *)myTableViewModel indexPath:(NSIndexPath *)indexPath
{
    TransferModel  * tranModel = (TransferModel *)myTableViewModel;
    TranferDetailsViewController * vc = [[TranferDetailsViewController alloc]initWithNavTitle:@"支付订单详情" tranferID:tranModel.txid];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
