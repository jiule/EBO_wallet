//
//  GameMyViewModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface GameMyViewModel : DwTableViewModel

@property(nonatomic,copy)NSString * timer;

@property(nonatomic,retain)NSMutableArray * gameMyModelArrays;

@end

@interface GameMyModel :BaseModel

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * dingdan_id;

@property(nonatomic,copy)NSString * dingdan_haoma;

@property(nonatomic,copy)NSString * num;

@property(nonatomic,copy)NSString * type;

@end
