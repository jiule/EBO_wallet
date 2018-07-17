//
//  PersonalManager.h
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PersonalModel;

@interface PersonalManager : NSObject
XMGSingletoH
/*
 * 根据保存的信息 登录 登录的参数 在PersonaHelp 属性里设置 登录链接 url.h 设置
 */
-(void)login;
/*
 *  读取当前登录者的信息
 */
+(PersonalModel *)readPersonalModel;
/*
 * 是否登录
 */
+(BOOL)readlogin;
/*
 * 保存用户信息
 */
+(void)savePersonal;
/*
 * 读取用户信息
 */
+(NSString *)readPersonal;

@end
