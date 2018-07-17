//
//  MarketSlidingView.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketSlidingView.h"

@interface MarketSlidingView()
{
    float _w;
    UIView * _upView;
    UILabel * _titleLabel;
    UIView * _slidingView;
}

@property(nonatomic,copy)MarketSliding sliding;

@property(nonatomic,assign)float index;  //显示的进度  0 - 1

@property(nonatomic,retain)UILabel * indexLabel;

@end

@implementation MarketSlidingView

+(MarketSlidingView *)showWithFrame:(CGRect)frame index:(float)index sliding:(MarketSliding)sliding
{
    MarketSlidingView * slidingView = [[MarketSlidingView alloc]initWithFrame:frame];
    slidingView.index = index;
    slidingView.sliding = sliding;
    [slidingView show];
    return slidingView;
}

-(void)show
{
    self.backgroundColor = COLOR_WHITE;
     _titleLabel = JnLabelType(CGRectMake(0, 0, JN_HH(50), JN_HH(20)), 5, [NSString stringWithFormat:@"%d%%",(int)(_index * 100)], 1);
    [self addSubview:_titleLabel];

    [self addSubview:JnButtonImageTag(CGRectMake(JN_HH(15), JN_HH(20), JN_HH(30), JN_HH(30)), MYimageNamed(@"hq_jianhao"), self, @selector(jianClick), 0)];
    [self addSubview:JnButtonImageTag(CGRectMake(SCREEN_WIDTH - JN_HH(45), JN_HH(20), JN_HH(30), JN_HH(30)), MYimageNamed(@"hq_jiahao"), self, @selector(jiaClick), 0)];

    float x = JN_HH(60);
    _w = self.width - JN_HH(120);

    UIView * bgView = JnUIView(CGRectMake(x, JN_HH(20) + JN_HH(14), _w, JN_HH(2)), COLOR_H1);
    JNViewStyle(bgView, JN_HH(1), nil, 0);
    [self addSubview:bgView];

    _upView = JnUIView(CGRectMake(x, JN_HH(20) + JN_HH(14), _w, JN_HH(2)), COLOR_A1);
     JNViewStyle(_upView, JN_HH(1), nil, 0);
    [self addSubview:_upView];

    _slidingView = JnUIView(CGRectMake(0, JN_HH(30), JN_HH(10), JN_HH(10)), COLOR_A1);
    JNViewStyle(_slidingView, JN_HH(5), nil, 0);
    [self addSubview:_slidingView];
    [self readView];

    [self addpanGestureTecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        UIPanGestureRecognizer * pan =  (UIPanGestureRecognizer *)tap;
        CGPoint position =[pan translationInView:self];
        float yi = position.x / self->_w;
    //    NSLog(@"%f",yi);
        self->_index += yi;
        [pan setTranslation:CGPointZero inView:self];
        if (self->_index < 0) {
            self->_index = 0;
        }else if(self->_index > 1){
            self->_index = 1;
        }
        [self readView];
        if (self.sliding) {
            self.sliding(self->_index);
        }
    }];

}

-(void)setIndex:(float)index
{
    _index = index;
    [self readView];
}

-(void)readView{
    float x = JN_HH(60);
    [_slidingView setX:x + _w * _index - JN_HH(5)];
    [_titleLabel setX:x + _w  * _index - JN_HH(25)];
    [_upView setW:_w * _index];
    _titleLabel.text = [NSString stringWithFormat:@"%d%%",(int)(_index * 100)];
}


-(void)jianClick
{
    _index -= 0.1;
    if (_index < 0) {
        _index = 0;
    }
    [self readView];
    if (self.sliding) {
        self.sliding(_index);
    }

}
-(void)jiaClick{
    _index += 0.1;
    if (_index > 1) {
        _index = 1;
    }
     [self readView];
    if (self.sliding) {
        self.sliding(_index);
    }
}

@end
