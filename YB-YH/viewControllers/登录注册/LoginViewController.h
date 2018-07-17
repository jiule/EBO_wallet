//
//  LoginViewController.h
//  YB-YH
//
//  Created by Apple on 2018/6/6.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginViewControllerDelegate <NSObject>

@optional

-(void)loginOK;

@end

@interface LoginViewController : BaseViewController

@property(nonatomic,weak)id <LoginViewControllerDelegate>delegate;

@end
