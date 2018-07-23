//
//  InvitationlistModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface InvitationlistModel : DwTableViewModel

@property(nonatomic,copy)NSString * order_id;

@property(nonatomic,copy)NSString * created_at;

@property(nonatomic,copy)NSString * user_income;
@end
