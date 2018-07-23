//
//  TranferDetailsModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseModel.h"

@interface TranferDetailsModel : BaseModel

@property(nonatomic,copy)NSString * account;

@property(nonatomic,copy)NSString * coin_number;

@property(nonatomic,copy)NSString * invite_type;

@property(nonatomic,copy)NSString * created_at;

@property(nonatomic,copy)NSString * confirm;

@property(nonatomic,copy)NSString * platform_coin_address;

@property(nonatomic,copy)NSString * users_coin_address;

@property(nonatomic,copy)NSString * memo; //备注

@property(nonatomic,copy)NSString * game_name;

@property(nonatomic,copy)NSString * txfee;

@property(nonatomic,copy)NSString * txid;

@property(nonatomic,copy)NSString * status;

@end
