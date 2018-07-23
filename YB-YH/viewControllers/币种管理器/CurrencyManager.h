//
//  CurrencyManager.h
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrencyModel.h"    //用户币种绑定信息
#import "ZiCurrencyModel.h"  //用户资产信息
#import "ProportionModel.h"  //币种之间的比例


@interface CurrencyManager : NSObject

XMGSingletoH

-(void)Initialize;

@property(nonatomic,retain)CurrencyModel * selcurrencyModel;
+(CurrencyModel *)readCurModelWithSpecies:(NSString *)species;
//设置选中的币种
-(BOOL)setSelBiText:(NSString *)text vc:(UIViewController *)vc;
//保存币种的所有
@property(nonatomic,retain)NSArray * allCurrencyModel;
//根据币种名称币种的id
+(NSString *)readspeciesWithName:(NSString *)name;
+(BOOL)readisOpenWithName:(NSString *)name;
//获取币种的矿工费
+(NSString *)readMinfeeWithspecies:(NSString *)species;
//获取币种的全部名称
+(NSArray *)readNames;
//保存本地 币种余额
+(void)saveZiCurrencyArray:(NSArray *)array;
//保存用户币种账户的信息
@property(nonatomic,retain)NSArray * allZiCurrencyModel;
//根据币种id 查找用户地址
+(NSString *)readAddressWithSpecies:(NSString *)species;
//根据币种id 查找当前币种信息
+(ZiCurrencyModel *)readZiModelWithSpecies:(NSString *)species;


//获取币种的互换比例
+(void)exchangeProportion;
+(void)exchangeProportion:(void (^)(ProportionModel * ))model;

@property(nonatomic,retain)ProportionModel * portionModel;
//根据交易类型 获取字符串类型
+(NSString *)readInvite:(int)invite;

@end
