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
#import "GameMyViewModel.h"
#import "GameMyDetailsViewController.h"


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


    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, h , SCREEN_WIDTH, SCREEN_HEIGHT  - h) url:@"" modelName:@"GameMyViewModel" cellName:@"GameMyViewCell" delegate:self];
    [self.tableView readTableView].backgroundColor = COLOR_H3;
    [self.view addSubview:[self.tableView readTableView]];
    [self.tableView setTableViewHearView:upView];


    [_zichanLabel setText:@"1000.00" componentsSeparatedByString:@"."];

    NSMutableArray * transModels = [NSMutableArray array];
    for (int i = 0 ; i < 5;  i++)
    {
        GameMyViewModel * model = [[GameMyViewModel alloc]init];
        model.timer = @"5月6日";
        NSMutableArray * array = [NSMutableArray array];
        for (int j = 0; j + i < 6; j++) {
            GameMyModel * model1 = [[GameMyModel alloc]init];
            model1.name = @"胖胖大作战";
            model1.dingdan_id  = @"100000000001";
            model1.num = @"+10.00";
            model1.type = @"成功";
            [array addObject:model1];
        }
         model.gameMyModelArrays = array;
        [transModels addObject:model];
    }
    [self.tableView ceshiArrays:transModels];

}

-(void)didselview:(DwTableViewCell *)Mycell data:(id)data
{
    GameMyModel  * tranModel = (GameMyModel *)data;
    GameMyDetailsViewController * vc = [[GameMyDetailsViewController alloc]initWithNavTitle:@"支付订单详情" tranferID:tranModel.dingdan_id];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
