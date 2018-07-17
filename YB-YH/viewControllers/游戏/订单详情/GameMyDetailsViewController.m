//
//  GameMyDetailsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameMyDetailsViewController.h"
#import "TranferDetailsView.h"

@interface GameMyDetailsViewController ()
{
    NSString * _tranferID;
    TranferDetailsView * _tranfetView;
    UILabel * _titleLabel;
}
@end

@implementation GameMyDetailsViewController

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
    [self.navView addDividingLine];
   // [self.navView setcolorStyle:1];
}

-(void)createView
{
    self.view.backgroundColor = COLOR_WHITE;
    _titleLabel = JnLabel(CGRectMake(JN_HH(15), self.nav_h + JN_HH(10), SCREEN_WIDTH - JN_HH(30), JN_HH(40)), @"胖胖大作战", JN_HH(25.5), COLOR_A2, 0);
    [self.view addSubview:_titleLabel];

    [self.view addUnderscoreWihtFrame:CGRectMake(0, self.nav_h + JN_HH(50) - 1.5, SCREEN_WIDTH, 1.5)];

    _tranfetView = [[TranferDetailsView alloc]initWithFrame:CGRectMake(0, self.nav_h + JN_HH(50), SCREEN_WIDTH, CGSCREEN_HEIGHT() - JN_HH(50) - self.nav_h )];
    [self.view addSubview:_tranfetView];
}

@end
