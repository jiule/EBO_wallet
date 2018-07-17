//
//  JNGraphView.h
//  YB-YH
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define PI 3.14159265358979323846

@class JNGraphModel;

@interface JNGraphView : UIView

//初始化 曲线图的大小  坐标显示的文字 crosstextArrays  verticalTextArrays 
-(instancetype)initWithFrame:(CGRect)frame crossTextArrays:(NSArray *)crosstextArrays verticalTextArrays:(NSArray *)verticalTextArrays;

-(void)showWithModels:(NSArray <JNGraphModel *>*)models;

//获取绘画区域的范围
-(CGSize)readGraphSize;

@end
