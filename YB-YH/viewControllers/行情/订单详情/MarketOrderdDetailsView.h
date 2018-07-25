//
//  MarketOrderdDetailsView.h
//  YB-YH
//
//  Created by Apple on 2018/6/15.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketOrderdDetailsView : UIView

//_style   2 是交易时间订单号     0 1 是交易详情
-(void)showWithStyle:(int)style;

-(void)showWithTmer:(NSString *)timer order_id:(NSString * )order_id;


@end
