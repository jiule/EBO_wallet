//
//  PersonalManager.m
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import "PersonalManager.h"
#import "PersonalModel.h"
@interface PersonalManager()
{
    PersonalModel * _model;
}
@end

@implementation PersonalManager
XMGSingletoM
-(void)login
{
 //   [PersonalModel sharedInstance].sessionId = [PersonalManager readPersonal];
     _model = [[PersonalModel alloc]initWithDict:[MyUserDefaultsManager JNobjectForKey:@"USER_PERSON"]];
}

+(PersonalModel *)readPersonalModel
{
    return [PersonalModel sharedInstance];
}

+(BOOL)readlogin
{
    return YES;
//    if ([PersonalModel sharedInstance].) {
//        return YES;
//    }else {
//        return NO;
//    }
}

+(void)savePersonal
{
//    if ([PersonalModel sharedInstance].sessionId) {
//        [MyUserDefaultsManager setJNObject:[PersonalModel sharedInstance].sessionId forkey:@"sessionID"];
//
//    }
}
+(NSString *)readPersonal
{
    return  [MyUserDefaultsManager JNobjectForKey:@"sessionID"];
}
@end
