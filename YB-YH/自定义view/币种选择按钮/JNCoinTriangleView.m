//
//  JNCoinTriangleView.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "JNCoinTriangleView.h"
#import "JNCoinView.h"

@interface JNCoinTriangleView()
{
    CGRect _frame;
    NSArray * _titleArray;
    NSString * _title;
    int _type;
    JNCoinView * _selCoinView;
}
@end


@implementation JNCoinTriangleView

-(instancetype)initWithFrame:(CGRect)frame  selTitle:(NSString *)title type:(int)type
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        _frame = frame;
        _title = title;
        _titleArray = [CurrencyManager readNames];
        _type = type;
        self.backgroundColor = COLOR_B(0.7);
        [self createView];
        return self;
    }
    return nil;
}

-(void)createView
{
    UIView * bgView = JnUIView(_frame, COLOR_WHITE);
    JNViewStyle(bgView, 5, nil, 0);
    [self addSubview:bgView];
    bgView.clipsToBounds = NO;
    if (_type == 1) {
        [bgView addSubview:JnImageView(CGRectMake(bgView.width * 0.5 - 6.5,  -6.5, 13, 6.5), MYimageNamed(@"选择框剪头"))];
    }else if(_type == 2) {
        [bgView addSubview:JnImageView(CGRectMake(bgView.width  -26.5,  -6.5, 13, 6.5), MYimageNamed(@"选择框剪头"))];
    }


    float h = bgView.height / _titleArray.count;
    for (int i = 0 ; i < _titleArray.count; i++) {
        NSString * str = _titleArray[i];
        JNCoinView * coin = [[JNCoinView alloc]initWithFrame:CGRectMake(bgView.width / 2 - 30, h * i, 60, h)];

        coin.titleLabel.text = str;
        
        if ([_title isEqualToString:str]) {
            coin.titleLabel.textColor = COLOR_A1;
            coin.imageView.image = MYimageNamed(@"选择对勾");
            _selCoinView = coin;
        }else {
            coin.titleLabel.textColor = COLOR_BL_3;
            coin.imageView.image = nil;
        }
        [bgView addSubview:coin];

        [coin addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            if (view == self->_selCoinView) {
                return ;
            }else {
                self->_selCoinView.imageView.image = nil;
                self->_selCoinView.titleLabel.textColor = COLOR_BL_3;
                JNCoinView * coin1 = (JNCoinView *)view;
                self->_selCoinView =  coin1;
                self->_selCoinView.imageView.image = MYimageNamed(@"选择对勾");;
                self->_selCoinView.titleLabel.textColor = COLOR_A1;
                self->_title = self->_selCoinView.titleLabel.text;
            }
            if ([self->_delegate respondsToSelector:@selector(didView:text:)] ) {
                [self->_delegate didView:self text:self->_title];
            }
            [self removeFromSuperview];
        }];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.superview];
    if (touchPoint.x > _frame.origin.x && touchPoint.y > _frame.origin.y && touchPoint.x < _frame.origin.x + _frame.size.width && touchPoint.y < _frame.origin.y + _frame.size.height) {
        return;
    }
    [self removeFromSuperview];
}

@end
