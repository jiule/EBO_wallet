//
//  LAContextManger.m
//  YB-YH
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "LAContextManger.h"
#import <LocalAuthentication/LocalAuthentication.h>  //指纹解锁

@implementation LAContextManger

+(BOOL)showWithTitle:(NSString *)title  block:(void(^)(LAContextTYPE type))block
{
//#if TARGET_IPHONE_SIMULATOR
//    return NO;
//#endif
    NSLog(@"adsfasdf");

    LAContext * context = [[LAContext alloc]init];
    context.localizedFallbackTitle = title;
    NSError * error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功 刷新主界面");
                block(LAContext_OK);
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                         block(LAContext_Cancel);
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                         block(LAContext_OFF);
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        block(LAContext_OFF);
                        break;
                    }
                    case LAErrorBiometryNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        block(LAContext_OFF);
                        break;
                    }
                    case LAErrorBiometryNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        block(LAContext_OFF);
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                            block(LAContext_SelectTitle);
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                                block(LAContext_OFF);
                        }];
                        break;
                    }
                }
            }
        }];
        return YES;
    }
    return NO;
}


@end
