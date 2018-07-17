//
//  GerenModel.h
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//

#import "BaseModel.h"
#import "Danli.h"
#import "Personal.h"
#import "MyUserDefaultsManager.h"

/*
 * 用户登录 成功返回的一些数据
*/
@interface PersonalModel : BaseModel

XMGSingletoH

@property(nonatomic,copy)NSString * avatar;

@property(nonatomic,copy)NSString * avatar_path;

@property(nonatomic,copy)NSString * create_user;

@property(nonatomic,copy)NSString * created_at;

@property(nonatomic,copy)NSString * credit;

@property(nonatomic,copy)NSString * email;

@property(nonatomic,copy)NSString * equipment_id;

@property(nonatomic,copy)NSString * idexpire;

@property(nonatomic,copy)NSString * idnumber;

@property(nonatomic,copy)NSString * invite_code;

@property(nonatomic,copy)NSString * invite_id;

@property(nonatomic,copy)NSString * last_login_ip;

@property(nonatomic,copy)NSString * last_login_region;

@property(nonatomic,copy)NSString * last_login_time;

@property(nonatomic,copy)NSString * level;

@property(nonatomic,copy)NSString * level_type;

@property(nonatomic,copy)NSString * login_error_number;

@property(nonatomic,copy)NSString * mobile; //手机号码
@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * nickname;

@property(nonatomic,copy)NSString * password;

@property(nonatomic,copy)NSString * register_ip;

@property(nonatomic,copy)NSString * register_region;

@property(nonatomic,copy)NSString * sweet_total;

@property(nonatomic,copy)NSString * transpwd;

@property(nonatomic,copy)NSString * uid;

@property(nonatomic,copy)NSString * update_user;

@property(nonatomic,copy)NSString * updated_at;

@property(nonatomic,copy)NSString * user_status;

@property(nonatomic,copy)NSString * username;



@end


