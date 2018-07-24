//
//  ZiCurrencyModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseModel.h"

@interface ZiCurrencyModel : BaseModel

@property(nonatomic,copy)NSString * address_name;

@property(nonatomic,copy)NSString * address_url;

/**
 余额
 */
@property(nonatomic,copy)NSString * balance;

@property(nonatomic,copy)NSString * coin_name;

@property(nonatomic,copy)NSString * coin_species;

@property(nonatomic,copy)NSString * wallet_id;

@end
