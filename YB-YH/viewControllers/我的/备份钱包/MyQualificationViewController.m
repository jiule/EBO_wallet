//
//  MyQualificationViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyQualificationViewController.h"
#import "QualificationView.h"

@interface MyQualificationViewController ()< JNBaseViewDelegate >

@end

@implementation MyQualificationViewController

-(void)createView
{
    [self.view addSubview:JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(80)), COLOR_A1)];
    UILabel * titLabel = JnLabel(CGRectMake(JNVIEW_X0, self.nav_h + JN_HH(10), SCREEN_WIDTH - JNVIEW_X0, JN_HH(60)), @"        为了方便备份,我们将钱包账户加密为以下英文字母组成的私钥,备份该私钥即可恢复钱包.", JN_HH(13.5), COLOR_WHITE, 0);
    titLabel.numberOfLines = 0;
    [self.view addSubview:titLabel];

    float h = self.nav_h + JN_HH(90);
    for (int i = 0 ; i < self.curManager.allCurrencyModel.count;i++ ) {
        CurrencyModel * curModel = self.curManager.allCurrencyModel[i];
        if (![curModel.isopen isEqualToString:@"未开通"]) {
            QualificationView * view = [[QualificationView alloc]initWithFrame:CGRectMake(0, h, SCREEN_WIDTH, JN_HH(120)) BgColor:COLOR_WHITE];
            view.tag = 100 + i;
            [self.view addSubview:view];
            view.delegate  = self;

            h += JN_HH(130);
        }
    }


}


-(void)didView:(UIView *)view
{
    NSLog(@"%ld",view.tag);
}


@end
