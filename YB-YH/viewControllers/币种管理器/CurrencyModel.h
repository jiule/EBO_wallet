//
//  CurrencyModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseModel.h"

@interface CurrencyModel : BaseModel

@property(nonatomic,copy)NSString * coin_species;

@property(nonatomic,copy)NSString * coin_name;

@property(nonatomic,copy)NSString * isopen;

@property(nonatomic,copy)NSString * icon;

@property(nonatomic,copy)NSString * zc_min_fee;

@end
