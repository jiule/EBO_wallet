//
//  MyDataView.m
//  i-qlady
//
//  Created by Apple on 17/4/21.
//  Copyright © 2017年 i-qlady. All rights reserved.
//

#import "MyDataView.h"

@interface MyDataView ()

@property(nonatomic,retain)DatePickerView * riqiPickView;

@end



@implementation MyDataView

-(DatePickerView *)riqiPickView
{
    if (!_riqiPickView) {
        _riqiPickView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - JN_HH(250), SCREEN_WIDTH, JN_HH(250)) BgColor:[UIColor whiteColor]];
        [self addSubview:_riqiPickView];
        
        [_riqiPickView addSubview:[self addBtn]];
    }
    return _riqiPickView ;
}

-(instancetype)initWithFrame:(CGRect)frame BgColor:(UIColor *)BgColor
{
    if (self = [super initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return self ;
}

-(UIButton *)addBtn{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH - JN_HH(69), JN_HH(14), JN_HH(50), JN_HH(20));
    [btn setTitle:@"完成" forState:0];
    [btn setTitleColor:[UIColor greenColor] forState:0];
    [btn titleLabel].font = [UIFont systemFontOfSize:JN_HH(18)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)showWithSelTimePickView:(selPickView)selPickerView
{
    [self.riqiPickView showWithSelPickView:selPickerView];
    [UIView animateWithDuration:0.2 animations:^{
        [self setY:0];
    }];
}

-(void)BtnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(didDataView:wanchengBtn:)] ) {
        [_delegate didDataView:self wanchengBtn:btn];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self setY:SCREEN_HEIGHT];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
