//
//  CurrencyModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseModel.h"
#define currencyNOopen   @"未开通"

@interface CurrencyModel : BaseModel

/**
 币种ID
 */
@property(nonatomic,copy)NSString * coin_species;

/**
 币种名称
 */
@property(nonatomic,copy)NSString * coin_name;

/**
 是否开通
 */
@property(nonatomic,copy)NSString * isopen;

/**
 对应图片icon
 */
@property(nonatomic,copy)NSString * icon;

@property(nonatomic,copy)NSString * zc_min_fee;


@end
