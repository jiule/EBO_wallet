//
//  TranferDetailsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TranferDetailsViewController.h"
#import "TranferDetailsView.h"
#import "TranferDetailsModel.h"

@interface TranferDetailsViewController ()
{
    NSString * _tranferID;
    TranferDetailsView * _tranfetView;
}
@end

@implementation TranferDetailsViewController

-(instancetype)initWithNavTitle:(NSString *)str tranferID:(NSString *)tranferID
{
    self = [super initWithNavTitle:str];
    _tranferID = tranferID;
    if (self) {
        return self;
    }
    return nil;
}

-(void)createNavView
{
    [super createNavView];
  //  [self.navView removeDividingLine];
  //  [self.navView setcolorStyle:0];
}

-(void)createView
{
    _tranfetView = [[TranferDetailsView alloc]initWithFrame:CGRectMake(0, self.nav_h + JN_HH(20), SCREEN_WIDTH, CGSCREEN_HEIGHT() - JN_HH(70) - self.nav_h )];
    [self.view addSubview:_tranfetView];
}

-(void)downData
{
    [self postdownDatas:@"transfer/Wallet/getTransInfo" adddict:@{@"txid":_tranferID} index:1];
}
-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        NSLog(@"%@",responseDict);
        TranferDetailsModel * trmodel = [[TranferDetailsModel alloc]initWithDict:responseDict];
        _tranfetView.tranferModel = trmodel;
        if (trmodel.game_name.length > 0) {
            //游戏的 
        }else {
            [ _tranfetView setY:self.nav_h + JN_HH(20)];
            NSArray * array = @[@"未确定",@"确认中",@"已确认",@"确认失败"];
            if ([trmodel.status intValue] < array.count) {
                    [self.view addSubview:JnLabelType(CGRectMake(0, CGSCREEN_HEIGHT() - JN_HH(50), SCREEN_WIDTH, JN_HH(44)), UILABEL_3, array[[trmodel.status intValue] ], 1)];
            }else {
                NSLog(@"status 数组越界");
                 [self.view addSubview:JnLabelType(CGRectMake(0, CGSCREEN_HEIGHT() - JN_HH(50), SCREEN_WIDTH, JN_HH(44)), UILABEL_3, @"确认失败", 1)];
            }


        }
     }
}

@end
