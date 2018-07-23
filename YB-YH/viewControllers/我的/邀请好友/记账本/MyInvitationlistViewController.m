//
//  MyInvitationlistViewController.m
//  YB-YH
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyInvitationlistViewController.h"
#import "DwTableView.h"

@interface MyInvitationlistViewController ()<DwTableViewDelegate,DwTableViewCellDelegate>

@property(nonatomic,retain)DwTableView * tableView;
@end

@implementation MyInvitationlistViewController

-(void)createView
{
    float h = self.nav_h;
    UIView * upView = JnUIView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, JN_HH(30)), COLOR_WHITE);

    [upView addSubview:JnLabel(CGRectMake(0, 0, SCREEN_WIDTH / 3, JN_HH(30)), @"时间", JN_HH(13.5) ,COLOR_BL_1,1)];
    [upView addSubview:JnLabel(CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, JN_HH(30)), @"来自好友", JN_HH(13.5) ,COLOR_BL_1,1)];
    [upView addSubview:JnLabel(CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, JN_HH(30)), BI_A0STR(@"奖励"), JN_HH(13.5) ,COLOR_BL_1,1)];
    [self.view addSubview:upView];
    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, h + JN_HH(35) , SCREEN_WIDTH, SCREEN_HEIGHT  - h) url:URL(@"/share/Myshare/invitationCount") modelName:@"InvitationlistModel" cellName:@"InvitationlistCell" delegate:self];
    self.tableView.is_data = YES;
    self.tableView.delegate = self ;
    [self.view addSubview:[self.tableView readTableView]];
   // [self.view addSubview:[self.tableView readTableView]];
}

-(void)downDatas
{
    [self tableViewWithPage:1];
}

-(void)tableViewWithPage:(int)page
{
    [self.tableView downWithdict:@{@"num":@"15",@"page":[NSString stringWithFormat:@"%d",page]} index:page];
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableViewWithPage:page];
}

@end
