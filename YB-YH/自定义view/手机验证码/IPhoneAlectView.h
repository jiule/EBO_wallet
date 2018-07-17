//
//  IPhoneAlectView.h
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IPhoneAlect)(BOOL isAlect , NSString * password);


@interface IPhoneAlectView : UIView

+(void)showWithAlect:(IPhoneAlect)alect;

@end
