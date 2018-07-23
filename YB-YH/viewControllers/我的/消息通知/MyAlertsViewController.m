//
//  MyAlertsViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyAlertsViewController.h"
#import "DwTableView.h"

@interface MyAlertsViewController () <DwTableViewDelegate,DwTableViewCellDelegate>
@property(nonatomic,retain)DwTableView * tableView;

@end

@implementation MyAlertsViewController
-(void)createView
{
    float h = self.nav_h;
    self.tableView =  [DwTableView initWithFrame:CGRectMake(0, h , SCREEN_WIDTH, SCREEN_HEIGHT  - h) url:URL(@"/portal/Slide/getNoticeList") modelName:@"MyAlertsModel" cellName:@"MyAlertsCell" delegate:self];
    self.tableView.delegate = self ;
    [self.view addSubview:[self.tableView readTableView]];
}

-(void)tableWithPage:(int)page
{
    [self.tableView downWithdict:@{@"page":[NSString stringWithFormat:@"%d",page],@"num":@"15"} index:page];
}

-(void)downData
{
    [self tableWithPage:1];
}

-(void)DwtableView:(DwTableView *)tableview refresh:(int)page
{
    [self tableWithPage:page];
}

@end
