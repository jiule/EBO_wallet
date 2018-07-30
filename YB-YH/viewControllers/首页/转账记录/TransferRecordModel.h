//
//  TransferRecordModel.h
//  YB-YH
//
//  Created by Apple on 2018/6/22.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface TransferRecordModel : DwTableViewModel

@property(nonatomic,copy)NSString * timer;

@property(nonatomic,retain)NSMutableArray * transFerArrays;

@end

@interface TransferModel :DwTableViewModel

@property(nonatomic,copy)NSString * blockstate;

@property(nonatomic,copy)NSString * coin_name;

@property(nonatomic,copy)NSString * coin_species;

@property(nonatomic,copy)NSString * created_at;

@property(nonatomic,copy)NSString * transfer_id;

@property(nonatomic,copy)NSString * invite_type;

@property(nonatomic,copy)NSString * memo;

@property(nonatomic,copy)NSString * order_id;

@property(nonatomic,copy)NSString * txid;

@property(nonatomic,copy)NSString * tx_id;

@property(nonatomic,copy)NSString * updated_at;

@property(nonatomic,copy)NSString * user_id;

@property(nonatomic,copy)NSString * user_income;

@property(nonatomic,copy)NSString * wallet_id;


@end
