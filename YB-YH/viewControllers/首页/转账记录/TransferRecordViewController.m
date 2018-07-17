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

@interface TransferRecordViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>
{

    UIButton * _navRightBtn;
    ScreeningTransferView * _screeningTransferView;
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
    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, self.nav_h , SCREEN_WIDTH, SCREEN_HEIGHT  - self.nav_h) url:@"transfer/wallet/getTransferList" modelName:@"TransferRecordModel" cellName:@"TransferRecordCell" delegate:self];
    [self.tableView readTableView].backgroundColor = COLOR_H3;
    [self.view addSubview:[self.tableView readTableView]];

    NSMutableArray * transModels = [NSMutableArray array];
    for (int i = 0 ; i < 5;  i++)
    {
        TransferRecordModel * model = [[TransferRecordModel alloc]init];
        model.timer = @"5月6日";
        NSMutableArray * array = [NSMutableArray array];
        for (int j = 0; j + i < 6; j++) {
            TransferModel * model1 = [[TransferModel alloc]init];
         //   model1.type = @"转出";
       //     model1.type1 = @"归还";
         //   model1.timer = @"14:20";
        //    model1.num = @"+10.00";
        //    model1.name = @"CCS";
            model1.transfer_id = [NSString stringWithFormat:@"j"];
            [array addObject:model1];
        }
        model.transFerArrays = array;
        [transModels addObject:model];
    }
    [self.tableView ceshiArrays:transModels];
}

-(void)rightBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        ScreeningTransferView * view = [[ScreeningTransferView alloc]initWithFrame:CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h)];
        _screeningTransferView = view;
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

-(void)didselview:(DwTableViewCell *)Mycell data:(id)data
{
    TransferModel  * tranModel = (TransferModel *)data;
    TranferDetailsViewController * vc = [[TranferDetailsViewController alloc]initWithNavTitle:@"支付订单详情" tranferID:tranModel.transfer_id];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)downDatas
{
    [self getDownDatas:@"transfer/wallet/getTransferList" withdict:@{@"page":@"1",@"num":@"100"} index:501 type:0];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 501)
    {
        NSLog(@"%@",responseDict);
    }
}

@end
