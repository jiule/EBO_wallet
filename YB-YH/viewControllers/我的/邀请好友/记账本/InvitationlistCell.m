//
//  InvitationlistCell.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "InvitationlistCell.h"
#import "InvitationlistModel.h"

@interface InvitationlistCell()
{
    UILabel * _timerLabel;
    UILabel * _nameLabel;
    UILabel * _jiangliLabel;
}
@end


@implementation InvitationlistCell

-(void)createCell
{
    
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    InvitationlistModel * model = (InvitationlistModel *)tableViewModel;
    _timerLabel.text = model.timer;
    _nameLabel.text= model.name ;
    _nameLabel.text = BI_A0STR(model.jiangli);
    [self createcell_h:JN_HH(50) BgColor:nil xian_h:1];
}

@end
