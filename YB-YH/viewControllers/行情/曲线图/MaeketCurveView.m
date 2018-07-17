//
//  MaeketCurveView.m
//  YB-YH
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MaeketCurveView.h"
#import "MarketCurveModel.h"

@interface MaeketCurveView()
{
    float _x ;
    float _y ;
    float _jian;
}
//画笔
@property(nonatomic,assign)CGContextRef context;

@end



@implementation MaeketCurveView

-(instancetype)initWithFrame:(CGRect)frame curveModels:(NSArray  <MarketCurveModel *>*)curveModels higt:(int)higt
{
    self = [super initWithFrame:frame];
    if (self) {
        _curveModels = curveModels;
        _higt = higt;
        _x = JN_HH(50);
        _y = JN_HH(20);
        _jian = 5;
        self.backgroundColor = [UIColor clearColor];
        return self;
    }
    return nil;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_curveModels.count == 0) {
        return;
    }
 //   NSLog(@"%@",_curveModels);
    _context=UIGraphicsGetCurrentContext();
    [self createXY];
    [self drawXian];
}

-(void)createXY
{
    int b = 300;
    int index = (_higt - b) / (_jian - 1);
    float heigt = self.height - 2 * _y ;
    NSString *str;
    UIFont *font=[UIFont systemFontOfSize:10];
    for (int i = 0 ; i<_jian; i++) {
        str=[NSString stringWithFormat:@"%d",(_higt - b) - index * i + b ];
        CGFloat w=[str widthOfFont:[UIFont systemFontOfSize:13] height:20];
        //画X的角标
        CGContextSetRGBFillColor (_context, 0x80 /255.00,0x89 /255.00,0xc3 /255.00,1.0);//设置填充颜色
        [str drawInRect:CGRectMake(_x - w - 5,  _y + heigt /(_jian - 1) * i - 5 , w, 20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:COLOR_A1, NSParagraphStyleAttributeName: [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy]}];

        //画横线
        CGContextSetRGBStrokeColor(_context,0x80 /255.00,0x89 /255.00,0xc3 /255.00,1.0);
        CGContextSetLineWidth(_context, 1);
        CGPoint apoints[2];
        apoints[0]=CGPointMake(_x, _y + heigt /(_jian - 1) * i - 0.5);
        apoints[1]=CGPointMake(self.width - JN_HH(20), _y + heigt /(_jian - 1) * i - 1);
        CGContextAddLines(_context, apoints, 2);//添加线
        CGContextDrawPath(_context, kCGPathStroke);
    }
}

-(void)drawXian
{
      int b = 300;
    CGContextRef context = UIGraphicsGetCurrentContext();
     CGPoint apoints[_curveModels.count];
    float w = self.width - JN_HH(20) - _x;
    float heigt = self.height - 2 * _y ;
    float jiange = w / (float)_curveModels.count;
    for ( int i = 0 ; i < _curveModels.count; i++) {
        MarketCurveModel * model = _curveModels[i];
        float xx = _x + i * jiange;
        float yy = _y + (_higt - [model.close floatValue]) / (float)(_higt - b ) * heigt;
       apoints[i]=CGPointMake(xx, yy);
    }

    CGContextSetRGBStrokeColor(context,0x80 /255.00,0x89 /255.00,0xc3 /255.00,1.0);
    //设置画笔的宽度
    CGContextSetLineWidth(context, 1);
    CGContextAddLines(context, apoints, _curveModels.count-1);//添加线
    CGContextDrawPath(context, kCGPathStroke);
}


-(void)setCurveModels:(NSArray *)curveModels
{
    _curveModels = curveModels;
    [self setNeedsDisplay];
}


@end
