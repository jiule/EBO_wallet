//
//  BaseBgimgeViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseBgimgeViewController.h"

@interface BaseBgimgeViewController ()

@end

@implementation BaseBgimgeViewController

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self addListeningkeyboard];
//}

-(void)Initialize
{
    [super Initialize];
    self.upView_y = JN_HH(0);
    self.downView_y = JN_HH(150);
}

-(void)createNavView
{
    [super createNavView];
    self.navView.backgroundColor = [UIColor clearColor];
}

-(void)createView
{
    [super createView];
    self.baseScollView.frame = self.view.bounds;
    UIImage * bgImage = [UIImage imageNamed:@"wd_beijin-1"];
    self.bgImageView = JnImageView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), bgImage);
    [self.baseScollView addSubview:self.bgImageView];
}

-(void)addBgDownViewWithy:(float)y  bgColor:(UIColor *)bgColor
{
    if (!self.bgDownView) {
        self.bgDownView = JnUIView(CGRectMake(0,y, SCREEN_WIDTH, CGSCREEN_HEIGHT() - y), bgColor);
        [self.baseScollView addSubview:self.bgDownView];
    }else {
        self.bgDownView.frame = CGRectMake(0,y, SCREEN_WIDTH, CGSCREEN_HEIGHT() - y);
        self.bgDownView.backgroundColor = bgColor;
    }
}

-(void)addListeningkeyboard{
    JNWeakSelf(self);
    [[Listeningkeyboard sharedInstance]startlisteningblockcompletion:^(CGFloat h) {
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.bgDownView setY:self.nav_h + self.upView_y];
        }];
    } keyboard:^(CGFloat h) {
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.bgDownView setY:self.nav_h + self.downView_y];
        }];
    }];
}

@end
