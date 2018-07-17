//
//  JNGraphView.m
//  YB-YH
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "JNGraphView.h"
#import "JNGraphModel.h"

@interface JNGraphView()
{
    NSArray * _crosstextArrays ;  //x 轴显示的文字
    NSArray * _verticalTextArrays; //y 轴显示的文字

    float  _crossX;           //图标区域的x 起点
    float  _crossW;           //图标区域的宽度
    float  _verticalY;        //图标区域的高度起点
    float  _verticalH;        //图标区域的高度
}

@property(nonatomic,retain)NSArray <JNGraphModel *> *dataModels;  //存放显示点的 数组

@property(nonatomic,retain)UIView * layerView;

@end


@implementation JNGraphView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super  initWithFrame:frame];
    if (self) {
        _crossX = JN_HH(30);
        _crossW = self.bounds.size.width - JN_HH(40);
        _verticalY = JN_HH(10);
        _verticalH = self.bounds.size.height - JN_HH(20) - _verticalY;
        return self;
    }
    return nil;
}


-(instancetype)initWithFrame:(CGRect)frame crossTextArrays:(NSArray *)crosstextArrays verticalTextArrays:(NSArray *)verticalTextArrays
{
    self = [self initWithFrame:frame];
    if (self) {
        _crosstextArrays = crosstextArrays;
        _verticalTextArrays = verticalTextArrays;
        return self;
    }
    return nil;
}

-(void)showWithModels:(NSArray <JNGraphModel *>*)models
{
    _dataModels = models;
    [self setNeedsDisplay];
}

#pragma mark-----画layer 线
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

-(CGSize)readGraphSize
{
    return CGSizeMake(_crossW, _verticalY);
}
@end
