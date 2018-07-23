//
//  MyAlertsModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface MyAlertsModel : DwTableViewModel

@property(nonatomic,copy)NSString * create_time;

@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * description_text;

@end
