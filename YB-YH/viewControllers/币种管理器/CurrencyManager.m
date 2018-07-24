//
//  CurrencyManager.m
//  YB-YH
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "CurrencyManager.h"
#import "Personal.h"
#import "MoneyViewController.h"

@interface CurrencyManager()



@end


@implementation CurrencyManager

XMGSingletoM




-(void)Initialize
{
    // 读取本地有没有数据 避免网络慢
//    id dict = [MyUserDefaultsManager JNobjectForKey:[MyUserDefaultsManager readCoinTypes]];
//    [self InitializeWithDict:dict];
//    if (dict) {
//        //获取本地 缓冲余额
//         NSArray * dataArray = [MyUserDefaultsManager JNobjectForKey:[MyUserDefaultsManager readAssets]];
//        [self InitializeWithZiArray:dataArray];
//    }

    //获取用户币种绑定情况
    [MyNetworkingManager POST:@"transfer/wallet/getCoinTypes" withparameters:@{} progress:^(NSProgress * _Nonnull progree) {    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      id responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
   //     [MyUserDefaultsManager  setJNObject:responseDict forkey:[MyUserDefaultsManager readCoinTypes]];  //保存到本地
        [self InitializeWithDict:responseDict];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    [CurrencyManager exchangeProportion];

}

+(void)saveZiCurrencyArray:(NSArray *)array
{
    [MyUserDefaultsManager  setJNObject:array forkey:[MyUserDefaultsManager readAssets]];  //保存到本地

}
-(void)InitializeWithZiArray:(NSArray *)dataArray
{
    NSMutableArray * ziArray = [NSMutableArray array];
    for (int i = 0 ; i < dataArray.count; i++) {
        ZiCurrencyModel * ziModel = [[ZiCurrencyModel  alloc]initWithDict:dataArray[i]];
        [ziArray addObject:ziModel];
    }
    [CurrencyManager sharedInstance].allZiCurrencyModel = ziArray;
}

-(void)InitializeWithDict:(NSDictionary *)responseDict
{
    NSArray * array = responseDict[@"data"];
    NSMutableArray * array1 = [NSMutableArray array];
    for (int i = 0 ; i < array.count; i++) {
        CurrencyModel * model =  [[CurrencyModel alloc]initWithDict:array[i]];
        [array1 addObject:model];
        if ([model.coin_name isEqualToString:BI_A0]) {
            self.selcurrencyModel = model;
        }
    }
    self.allCurrencyModel = array1;
}

-(BOOL)setSelBiText:(NSString *)text vc:(UIViewController *)vc
{
    if (_selcurrencyModel.coin_name == text) {
        return YES;
    }
    for (int i = 0; i < _allCurrencyModel.count; i++) {
        CurrencyModel * model = _allCurrencyModel[i];
        if ([model.coin_name isEqualToString:text]) {
            if (![model.isopen isEqualToString:@"未开通"]) {
                   _selcurrencyModel = model;
                return YES ;
            }else
            {
                [MYAlertController showTitltle:[NSString stringWithFormat:@"您还没有开通%@",text] selButton:^(MYAlertController *AlertController, int index) {
                    if (index == 1) {
                        MoneyViewController * vc1 = [[MoneyViewController alloc]initWithNavTitle:@"创建钱包" name:model.coin_name];
                        [vc.navigationController pushViewController:vc1 animated:YES];
                    }

                } title:@"取消",@"开通", nil];
                return  NO;
            }
        }
    }
    return NO;
}

+(CurrencyModel *)readCurModelWithSpecies:(NSString *)species
{
    for (int i = 0; i < [CurrencyManager sharedInstance].allCurrencyModel.count; i++) {
        CurrencyModel * model =  [CurrencyManager sharedInstance].allCurrencyModel[i];
        //    NSLog(@"%@------%@========%@",model.coin_name,model.coin_species,name);
        if ([model.coin_species intValue] == [species intValue]) {
            return model;
        }
    }
    return nil;
}

+(NSString *)readspeciesWithName:(NSString *)name
{
    for (int i = 0; i < [CurrencyManager sharedInstance].allCurrencyModel.count; i++) {
        CurrencyModel * model =  [CurrencyManager sharedInstance].allCurrencyModel[i];
    //    NSLog(@"%@------%@========%@",model.coin_name,model.coin_species,name);
        if ([model.coin_name isEqualToString:name]) {
            return model.coin_species;
        }
    }
    return nil;
}

+(BOOL)readisOpenWithName:(NSString *)name
{
    for (int i = 0; i < [CurrencyManager sharedInstance].allCurrencyModel.count; i++) {
        CurrencyModel * model =  [CurrencyManager sharedInstance].allCurrencyModel[i];
          //  NSLog(@"%@------========%@",model.coin_name,name);
        if ([model.coin_name isEqualToString:name]) {
            NSLog(@"%@",model.isopen);
            if ([model.isopen isEqual:@"未开通"]) {
                return NO;
            }
        }
    }
    return YES;
}

+(NSString *)readMinfeeWithspecies:(NSString *)species
{
    for (int i = 0 ; i < [CurrencyManager sharedInstance].allCurrencyModel.count; i++) {
        CurrencyModel * model =  [CurrencyManager sharedInstance].allCurrencyModel[i];
        NSLog(@"%@-------%@",model.coin_species,species);
        if ([model.coin_species intValue] == [species intValue]) {
            NSLog(@"sadfasdfsadfsadf");
            return model.zc_min_fee;
        }
    }
    return nil;
}

+(NSArray *)readNames
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < [CurrencyManager sharedInstance].allCurrencyModel.count; i++) {
        CurrencyModel * model =  [CurrencyManager sharedInstance].allCurrencyModel[i];
        [array addObject:model.coin_name];
    }
    return array;
}
+(NSString *)readAddressWithSpecies:(NSString *)species
{
    for (int i = 0 ; i < [CurrencyManager sharedInstance].allZiCurrencyModel.count; i++) {
        ZiCurrencyModel * model  = [CurrencyManager sharedInstance].allZiCurrencyModel[i];
        if ([[NSString stringWithFormat:@"%@",model.coin_species] isEqualToString:species]) {
            return [NSString stringWithFormat:@"%@",model.address_url];
        }
    }
    return nil;
}

+(ZiCurrencyModel *)readZiModelWithSpecies:(NSString *)species
{
    for (int i = 0 ; i < [CurrencyManager sharedInstance].allZiCurrencyModel.count; i++) {
        ZiCurrencyModel * model  = [CurrencyManager sharedInstance].allZiCurrencyModel[i];
        if ([model.coin_species isEqual:species]) {
            return model;
        }
    }
    return nil;
}
/**
 获取币种的互换比例
 */
+(void)exchangeProportion{
    [CurrencyManager exchangeProportion:nil];
}

/**
 获取币种的互换比例

 @param model 返回最新的比例model
 */
+(void)exchangeProportion:(void (^)(ProportionModel * ))model{
    [MyNetworkingManager DDPOSTResqust:@"/transfer/wallet/getEBOProportion" withparameters:@{@"coin_name":@"eth"} withVC:nil progress:^(NSProgress * _Nonnull progree) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        //  [MyUserDefaultsManager  setJNObject:responseDict forkey:[MyUserDefaultsManager readCoinTypes]];  //保存到本地
        [CurrencyManager sharedInstance].portionModel = [[ProportionModel alloc]initWithDict:dic];
        if (model) {
            model([CurrencyManager sharedInstance].portionModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(NSString *)readInvite:(int)invite
{
    NSArray * inviteArray = @[@"",@"",@"邀请",@"邀请",@"关注",@"实名认证",@"高级认证",@"备份钱包",@"支付宝授权",@"京东授权",@"学信网授权",@"手机运营授权",@"信用卡邮箱账单"
                              ,@"开通共享共功能",@"币种首次充值",@"共享",@"",@"",@"",@"",@"糖果",@"糖果",@"转账",@"转账",@"买入",@"卖出",@"赠送",@"领取",@"派发",@"游戏" ];
    if (invite >= inviteArray.count || invite < 0) {
        return nil;
    }
   return  inviteArray[invite];
}
@end
