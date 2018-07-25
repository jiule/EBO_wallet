//
//  MarketOrderModel.h
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface MarketOrderModel : DwTableViewModel

@property(nonatomic,copy)NSString * coin_num;

@property(nonatomic,copy)NSString * coin_species;

@property(nonatomic,copy)NSString * create_time;


@property(nonatomic,copy)NSString * market_id;

@property(nonatomic,copy)NSString * ob_coin;
@property(nonatomic,copy)NSString * ob_species;
@property(nonatomic,copy)NSString * order_id;
@property(nonatomic,copy)NSString * state;
@property(nonatomic,copy)NSString * state_name;
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * wallet_id;
@end
