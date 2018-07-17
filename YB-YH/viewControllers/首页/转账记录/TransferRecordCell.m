//
//  TransferRecordCell.m
//  YB-YH
//
//  Created by Apple on 2018/6/22.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TransferRecordCell.h"
#import "TransferRecordModel.h"

@interface TransferRecordCell()
{
    UILabel * _timerLabel;
    UIView * _downView;
}
@end

@implementation TransferRecordCell

-(void)createCell
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.backgroundColor = COLOR_H3;
    _timerLabel = JnLabelType(CGRectMake(JN_HH(10), JN_HH(10), SCREEN_WIDTH - JN_HH(20), JN_HH(20)),UILABEL_3, @"5月13日",  1);
    [self addSubview:_timerLabel];

    _downView  = JnUIView(CGRectMake(0, JN_HH(35), SCREEN_WIDTH, JN_HH(60)), COLOR_WHITE);
   // JNViewStyle(_downView, 5, nil, 0);
    [self addSubview:_downView];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    for (UIView * view in _downView.subviews) {
        [view removeFromSuperview];
    }
    TransferRecordModel * model  = (TransferRecordModel *)tableViewModel;
    _timerLabel.text = model.timer;
    for (int i = 0 ; i < model.transFerArrays.count; i++) {

        UIView * view = JnUIView(CGRectMake(0, JN_HH(60) * i, _downView.width, JN_HH(60)), COLOR_WHITE);
        view.tag = 100 + i;
        [_downView addSubview:view];
        TransferModel * mdoel1 = model.transFerArrays[i];
   //     [view addSubview:JnLabelType(CGRectMake(JN_HH(20), JN_HH(5) , _downView.width, JN_HH(30)),UILABEL_2, [NSString stringWithFormat:@"%@ [%@]",mdoel1.type,mdoel1.type1], 0)];
    //    [view addSubview:JnLabelType(CGRectMake(JN_HH(20), JN_HH(35), _downView.width, JN_HH(20)),UILABEL_4 ,mdoel1.timer, 0)];
    //    [view addSubview:JnLabel(CGRectMake(SCREEN_WIDTH * 0.25, JN_HH(15) ,SCREEN_WIDTH * 0.75 - JN_HH(80), JN_HH(30)), mdoel1.num, JN_HH(14.5), COLOR_A1, 2)];
   //     [view addSubview:JnLabelType(CGRectMake(SCREEN_WIDTH - JN_HH(80), JN_HH(15), JN_HH(60), JN_HH(30)), UILABEL_2,mdoel1.name, 2)];
        [_downView addUnderscoreWihtFrame:CGRectMake(0, JN_HH(60) * i, SCREEN_WIDTH, 1)];
        [view addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            if ([self.delegate respondsToSelector:@selector(didselview:data:)]) {
                [self.delegate didselview:self data:mdoel1];
            }
        }];
    }
    [_downView setH:model.transFerArrays.count * JN_HH(60)];

    [self createcell_h:JN_HH(35) + _downView.height + 2 BgColor:self.backgroundColor xian_h:2];
}



@end
