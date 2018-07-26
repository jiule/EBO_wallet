//
//  PentagramView.m
//  i-qlady
//
//  Created by Apple on 2018/2/27.
//  Copyright © 2018年 i-qlady. All rights reserved.
//

#import "PentagramView.h"

@interface PentagramView()
{
    UIImage * _upImage;
    UIImage * _downImage;
}
@property(nonatomic,retain)UIView * upView;

@property(nonatomic,retain)UIView * downView;

@end

@implementation PentagramView

-(UIView *)upView
{
    if (!_upView) {
        _upView = JnUIView(self.bounds, self.backgroundColor );
       // [self loadDataUpView];
        _upView.clipsToBounds = YES ;
        [self addSubview:_upView];
    }
    return _upView;
}

-(UIView *)downView
{
    if (!_downView) {
        _downView = JnUIView(self.bounds, self.backgroundColor );
      //  [self loadDataDownView];
        [self addSubview:_downView];
    }
    return _downView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    _maxIndex = 5;
    _upImage = [UIImage imageNamed:@"xingxing"];
    _downImage = [UIImage imageNamed:@"xingxingh"];
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    return self;
}

-(void)loadDataDownView
{
    for (UIView * view in self.downView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < _maxIndex; i++) {
        UIButton * btn = JnButtonImageTag(CGRectMake(self.width / _maxIndex * i, 0, self.width / _maxIndex, self.width / _maxIndex), _downImage, self, @selector(btnClick: ), 100 +i);
            [_downView addSubview:btn];
    }
}

-(void)loadDataUpView
{
    for (UIView * view in self.upView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < _maxIndex; i++) {
        UIImageView * imageView = JnImageView(CGRectMake(self.width / _maxIndex * i, 0, self.width / _maxIndex, self.width / _maxIndex), _upImage);
        [_upView addSubview:imageView];
    }
}

-(void)showUpImage:(UIImage *)upImage downImage:(UIImage *)downImage
{
    _upImage = upImage;
    _downImage = downImage;
    [self loadDataDownView];
    [self loadDataUpView];
}

-(void)showScore:(float)score
{
    if (!_downView) {
        [self loadDataDownView];
    }
    if (!_upView) {
        [self loadDataUpView];
    }
    [self.upView setW:self.width * score];
}

-(void)setMaxIndex:(int)maxIndex
{
    _maxIndex = maxIndex;
    [self loadDataDownView];
    [self loadDataUpView];
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didView:btn:)]) {
        [self.delegate didView:self btn:btn];
    }
}

@end
