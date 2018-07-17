//
//  GameModel.h
//  YB-YH
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "DwTableViewModel.h"

@interface GameModel : DwTableViewModel

@property(nonatomic,copy)NSString * c_name;

@property(nonatomic,copy)NSString * icon;

@property(nonatomic,copy)NSString * game_id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * score;
@property(nonatomic,copy)NSString * weight;
@property(nonatomic,retain)NSString * ios;

@end
