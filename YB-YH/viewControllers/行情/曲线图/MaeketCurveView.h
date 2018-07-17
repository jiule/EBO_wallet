//
//  MaeketCurveView.h
//  YB-YH
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MarketCurveModel;

@interface MaeketCurveView : UIView

-(instancetype)initWithFrame:(CGRect)frame curveModels:(NSArray  <MarketCurveModel *>*)curveModels higt:(int)higt;

@property(nonatomic,assign)int higt;

@property(nonatomic,retain)NSArray * curveModels;

@end
