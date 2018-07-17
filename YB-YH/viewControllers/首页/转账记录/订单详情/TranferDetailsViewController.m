//
//  TranferDetailsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TranferDetailsViewController.h"
#import "TranferDetailsView.h"

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


@end
