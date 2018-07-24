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
@property(nonatomic,copy)NSString * ios;
@property(nonatomic,copy)NSString * category_name;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * image_url;

@end

@interface GameffilingModel : BaseModel

@property(nonatomic,copy)NSString * end_time;

@property(nonatomic,copy)NSString * listorder;

@property(nonatomic,copy)NSString * slide_cid;
@property(nonatomic,copy)NSString * slide_content;
@property(nonatomic,copy)NSString * slide_des;
@property(nonatomic,copy)NSString * slide_id;
@property(nonatomic,copy)NSString * slide_name;

@property(nonatomic,copy)NSString * slide_pic;
@property(nonatomic,copy)NSString * slide_status;
@property(nonatomic,copy)NSString * slide_url;
@property(nonatomic,copy)NSString * start_time;

@end
