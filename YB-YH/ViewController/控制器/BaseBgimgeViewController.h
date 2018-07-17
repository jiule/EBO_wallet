//
//  BaseBgimgeViewController.h
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseBgimgeViewController : BaseScrollViewController


//父类没有初始化 子类需要重新创建
@property(nonatomic,retain)UIView * bgDownView;

@property(nonatomic,retain)UIImageView * bgImageView;
//根据y值 创建 bgDownView；
-(void)addBgDownViewWithy:(float)y bgColor:(UIColor *)bgColor;

@property(nonatomic,assign)float downView_y;

@property(nonatomic,assign)float upView_y;



@end
