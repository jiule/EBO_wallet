//
//  LAContextManger.m
//  YB-YH
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "LAContextManger.h"
#import <LocalAuthentication/LocalAuthentication.h>  //指纹解锁
#import "RootViewController.h"

@interface LAContextManger()

@property(nonatomic,assign) int  timerIndex;

@property(nonatomic,assign)BOOL is_open;

@end


@implementation LAContextManger

XMGSingletoM
+(void)Initialize
{
    [LAContextManger sharedInstance].isopen = [[MyUserDefaultsManager JNobjectForKey:[MyUserDefaultsManager readContextManger]] boolValue];
    NSLog(@"%d",  [LAContextManger sharedInstance].isopen);
    [LAContextManger sharedInstance].isopen = YES ;
}
//app进入后台 调用
+(void)applicationDidEnterBackground
{
    if ([LAContextManger sharedInstance].isopen && [LAContextManger sharedInstance].is_open) {
        [LAContextManger sharedInstance].timerIndex = (int)[[NSDate date] timeIntervalSince1970];
    }else {
        NSLog(@"aaaaaaaaaa");
    }

}
//app 进入前台调用
+(void)applicationWillEnterForeground:(UIWindow *)window
{
//    NSLog(@"%d----%d",  [LAContextManger sharedInstance].timerIndex, (int)[[NSDate date] timeIntervalSince1970] );
    if ((int)[[NSDate date] timeIntervalSince1970] -  [LAContextManger sharedInstance].timerIndex >= 2) {
        UIView * bgView = JnUIView(window.bounds, COLOR_B(0.9));
        [window addSubview:bgView];
        [LAContextManger sharedInstance].is_open = YES;
        [LAContextManger showWithTitle:@"指纹解锁" block:^(LAContextTYPE type) {
            [LAContextManger sharedInstance].is_open = NO;
            [Helpr dispatch_queue_t_timer:1 send:^{
                [bgView removeFromSuperview];
                if (type != LAContext_OK) {
                    [[RootViewController sharedInstance]loginOFF];
                }
            }];
        }];
    }
}



-(void)setIsopen:(BOOL)isopen
{
    _isopen = isopen;
    [MyUserDefaultsManager setJNObject:[NSNumber numberWithBool:_isopen] forkey:[MyUserDefaultsManager readContextManger]];  //保存沙盒
}


+(BOOL)showWithTitle:(NSString *)title  block:(void(^)(LAContextTYPE type))block
{


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
