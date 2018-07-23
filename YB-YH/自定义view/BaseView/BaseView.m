//
//  BaseView.m
//  YB-YH
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseView.h"

@interface BaseView()
{
    NSString * _leftName;
    NSString * _title;
    NSString * _rightName;
}
@end


@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title
{
    return  [self initWithFrame:frame leftName:leftName title:title rightName:nil];
}


-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title rightImageName:(BOOL)rightImageName
{
    if (rightImageName) {
         return  [self initWithFrame:frame leftName:leftName title:title rightName:@"jiantou_H1_88"];
    }
    return  [self initWithFrame:frame leftName:leftName title:title rightName:nil];
}
-(instancetype)initWithFrame:(CGRect)frame leftName:(nullable NSString *)leftName title:(NSString *)title rightName:(nullable NSString *)rightName
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftName  = leftName;
        _title = title;
        _rightName = rightName;
        if (frame.size.width > 0) {
              [self show];
        }
        return self;
    }
    return nil;
}

-(void)show{
    float x = JN_HH(10);
    if (_leftName) {
        _leftBtn = JnButtonImageTag(CGRectMake(x, self.height * 0.5  - JN_HH(22), JN_HH(44), JN_HH(44)), MYimageNamed(_leftName), self, @selector(leftBtnClick:), -10);
        [self addSubview:_leftBtn];
        x += JN_HH(44);
    }
    _titleLabel = JnLabelType(CGRectMake(x, 0, self.width - x - JNVIEW_X(44), self.height), UILABEL_2, _title, 0);
    [self addSubview:_titleLabel];

    if (_rightName) {
        _rightBtn = JnButtonImageTag(CGRectMake(self.width - JN_HH(44) - JN_HH(0), self.height * 0.5  - JN_HH(22), JN_HH(44), JN_HH(44)), MYimageNamed(_rightName), self, @selector(rightBtnClick:), -10);
        [self addSubview:_rightBtn];
    }

    [self addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        [self didView];
    }];

}

-(void)jn_setRightName:(NSString *)rightName
{
    _rightName = rightName;
    if (rightName) {
        if (self.rightBtn == nil) {
            self.rightBtn = JnButtonImageTag(CGRectMake(SCREEN_WIDTH - JN_HH(44) - JN_HH(15), self.height * 0.5  - JN_HH(22), JN_HH(44), JN_HH(44)), MYimageNamed(_rightName), self, @selector(rightBtnClick:), -10);
        }else {
            [self.rightBtn setBackgroundImage:MYimageNamed(_rightName) forState:0];
        }
    }else {
        [_rightBtn removeFromSuperview];
    }
}
-(void)jn_setLeftName:(nullable NSString *)leftName
{
    _leftName = leftName;
    if (leftName) {
        if (self.leftBtn == nil) {
            self.leftBtn = JnButtonImageTag(CGRectMake(SCREEN_WIDTH - JN_HH(44) - JN_HH(15), self.height * 0.5  - JN_HH(22), JN_HH(44), JN_HH(44)), MYimageNamed(_rightName), self, @selector(rightBtnClick:), -10);
        }else {
            [self.leftBtn setBackgroundImage:MYimageNamed(_rightName) forState:0];
        }
        [ _titleLabel setX:JNVIEW_X0 + JN_HH(44) ];
    }else {
        [_leftBtn removeFromSuperview];
        [_titleLabel setX:JNVIEW_X0];
    }
}

-(void)leftBtnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(didView:leftbtn:)]) {
        [_delegate didView:self leftbtn:btn];
    }else {
        [self didView];
    }
}

-(void)rightBtnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(didView:rightbtn:)]) {
        [_delegate didView:self rightbtn:btn];
    }else {
        [self didView];
    }
}

-(void)didView
{
    if ([_delegate respondsToSelector:@selector(didView:)]) {
        [_delegate didView:self];
    }
}
@end
