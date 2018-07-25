//
//  TransferRecordViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/22.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TransferRecordViewController.h"
#import "DwTableView.h"
#import "TransferRecordModel.h"
#import "ScreeningTransferView.h"
#import "TranferDetailsViewController.h"

@interface TransferRecordViewController ()<DwTableViewDelegate,DwTableViewCellDelegate,ScreeningTransferViewDelegate>
{

    UIButton * _navRightBtn;
    ScreeningTransferView * _screeningTransferView;
    NSDictionary * _screeningDict;
}

@property(nonatomic,retain)DwTableView * tableView;

@end

@implementation TransferRecordViewController

-(void)createNavView
{
    [super createNavView];

    _navRightBtn = JnButtonColorIndexSize(CGRectMake(SCREEN_WIDTH - JN_HH(80), CGNavView_20h() + 12, JN_HH(65), 20), @"筛选", 16, COLOR_B2, COLOR_WHITE, 2, self, @selector(rightBtnClick:), 0);
    [self.navView addSubview:_navRightBtn];

}

-(void)createView
{
    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, self.nav_h , SCREEN_WIDTH, SCREEN_HEIGHT  - self.nav_h) url:URL(@"transfer/wallet/getTransferList") modelName:@"TransferModel" cellName:@"TransferRecordCell" delegate:self];
    [self.tableView readTableView].backgroundColor = COLOR_H3;
    [self.view addSubview:[self.tableView readTableView]];
}

-(void)rightBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        ScreeningTransferView * view = [[ScreeningTransferView alloc]initWithFrame:CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h)];
        _screeningTransferView = view;
        view.delegate = self;
        [self.view addSubview:view];
    }else {
        [_screeningTransferView removeFromSuperview];
    }
}
-(void)clickonReturn
{
    if (_navRightBtn.selected == YES) {
        [self rightBtnClick:_navRightBtn];
    }else {
        FANHUI_JIUSHITU ;
    }
}

-(void)downData
{
    [self tableViewWithPage:1];
}



-(void)tableViewWithPage:(int)page
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithDictionary:_screeningDict];
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

-(void)DwtableView:(DwTableView *)tableView downDatasWithDict:(NSDictionary *)dict index:(int)index
{
    NSLog(@"%@",dict);
}

#pragma mark----_screeningDict
-(void)didScreeningTransferView:(ScreeningTransferView *)view dict:(NSDictionary *)dict
{
    _screeningDict = dict;
    NSLog(@"%@",dict);
    [self tableViewWithPage:1];
}
@end
