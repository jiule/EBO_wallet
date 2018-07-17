//
//  BaseScrollViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()

@end

@implementation BaseScrollViewController

-(void)createView
{
    [super createView];
    self.baseScollView = JnScrollView(CGRectMake(0, self.nav_h, SCREEN_WIDTH, SCREEN_HEIGHT - self.nav_h), self.view.backgroundColor);
    [self.view addSubview:self.baseScollView];

    if (self.isRootViewController ) {
       [self.baseScollView setH:SCREEN_HEIGHT - self.nav_h -Tabbar_49h()];
    }
}
@end
