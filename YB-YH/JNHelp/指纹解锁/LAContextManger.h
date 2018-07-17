//
//  LAContextManger.h
//  YB-YH
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    LAContext_OK,            //验证通过
    LAContext_Cancel,        //取消
    LAContext_SelectTitle ,  //选中自定义按钮
    LAContext_OFF,           //权限错误
} LAContextTYPE;



@interface LAContextManger : NSObject

+(BOOL)showWithTitle:(NSString *)title  block:(void(^)(LAContextTYPE type))block;

@end
