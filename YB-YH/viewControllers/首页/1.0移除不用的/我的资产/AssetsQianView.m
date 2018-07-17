//
//  AssetsQianView.m
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "AssetsQianView.h"

@interface AssetsQianView()
{
    NSString * _text;
    NSString * _imageName;
    UILabel * _titleLabel;
    UILabel * _qianLabel;
}
@end

@implementation AssetsQianView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text imageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    self.backgroundColor = COLOR_WHITE;
    JNViewStyle(self, 5, nil, 0);
    if (self) {
        _text = text;
        _imageName = imageName;
        [self show];
        return self;
    }
    return nil;
}

-(void)show
{
    [ self addSubview:JnImageView(CGRectMake(JN_HH(10), JN_HH(10), self.height - JN_HH(20), self.height - JN_HH(20)), MYimageNamed(_imageName))];
    [self addSubview:JnLabel(CGRectMake(self.height, 0, JN_HH(150), self.height), _text, JN_HH(40), COLOR_H1, 0)];

    _titleLabel = JnLabel(CGRectMake(self.width - JN_HH(150), JN_HH(10), JN_HH(135), JN_HH(30)), @"0", JN_HH(25), COLOR_A1, 2);
    [self addSubview:_titleLabel];

    _qianLabel =  JnLabel(CGRectMake(self.width - JN_HH(150), JN_HH(40), JN_HH(135), JN_HH(20)), [NSString stringWithFormat:@"%@%@00.00",FUHAO_YUEDENGYU,FUHAO_RENMINGBI], JN_HH(15.5), COLOR_H1, 2);
    [self addSubview:_qianLabel];
}

-(void)addLabelText:(NSString *)text
{

}

@end



/*
 *   --------------------------------------------华丽的分割线---------------------------
 *   -------------------------------------------- 最近记录  ----------------------------
 *   --------------------------------------------华丽的分割线---------------------------
 */

@interface AssetsjiluView()
{
    UILabel * _textLabel;
    UILabel * _titleLabel;
    UILabel * _timerLbael;
}
@end    

@implementation AssetsjiluView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        return self;
    }
    return nil;
}

-(void)createView
{
    _textLabel = JnLabelType(CGRectMake(JN_HH(10), JN_HH(10), JN_HH(120), JN_HH(20)), UILABEL_5, @"暂无记录", 0);
    [self addSubview:_textLabel];

    _timerLbael = JnLabelType(CGRectMake(JN_HH(10), JN_HH(30), JN_HH(120), JN_HH(20)), UILABEL_2, @"1990-01-01", 0);
    _timerLbael.font = [UIFont systemFontOfSize:13.5];
//    [self addSubview:_timerLbael];

    _titleLabel = JnLabel(CGRectMake(self.width * 0.5, JN_HH(10), self.width * 0.5 - JN_HH(10), JN_HH(30)), @"+0.02", JN_HH(18.5), COLOR_A1, 2);
//    [self addSubview:_titleLabel];
}

-(void)showWithText:(NSString *)text timer:(NSString *)timer title:(NSString *)title
{
    [_timerLbael removeFromSuperview];
    [_titleLabel removeFromSuperview];
    [self addSubview:_timerLbael];
    [self addSubview:_titleLabel];
    _textLabel.text = text;
    _timerLbael.text = timer;
    _titleLabel.text = title;
}

@end
