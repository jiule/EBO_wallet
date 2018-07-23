//
//  ShouyeQianView.h
//  YB-YH
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouyeQianView : UIView

/**
 图片
 */
@property(nonatomic,retain)UIImageView * imgeV;

/**
 名称
 */
@property(nonatomic,retain)UILabel * titleLb;


/**
 余额
 */
@property(nonatomic,retain)UILabel * balanceLb;

/**
 人民币
 */
@property(nonatomic,retain)UILabel * rmbLb;

@end
