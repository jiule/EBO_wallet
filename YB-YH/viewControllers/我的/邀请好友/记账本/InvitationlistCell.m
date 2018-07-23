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
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _timerLabel = JnLabelType(CGRectMake(0, 0, SCREEN_WIDTH / 3, JN_HH(50)), UILABEL_2, @"", 1);
    [self addSubview:_timerLabel];

    _nameLabel = JnLabelType(CGRectMake(SCREEN_WIDTH / 3 , 0, SCREEN_WIDTH / 3, JN_HH(50)), UILABEL_2, @"", 1);
    [self addSubview:_nameLabel];

    _jiangliLabel = JnLabelType(CGRectMake(SCREEN_WIDTH / 3 * 2, 0, SCREEN_WIDTH / 3, JN_HH(50)), UILABEL_2, @"", 1);
    [self addSubview:_jiangliLabel];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    InvitationlistModel * model = (InvitationlistModel *)tableViewModel;
    _timerLabel.text = [model.created_at substringToIndex:10];
    _nameLabel.text= model.order_id  ;
    _jiangliLabel.text = [NSString stringWithFormat:@"%d",[model.user_income intValue]];
    [self createcell_h:JN_HH(50) BgColor:nil xian_h:1];
}

@end
