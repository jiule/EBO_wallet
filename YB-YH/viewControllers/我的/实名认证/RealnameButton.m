//
//  RealnameView.m
//  YB-YH
//
//  Created by Apple on 2018/6/13.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RealnameButton.h"

@interface RealnameButton()
{
    NSString * _imageStr;
    NSString * _selimageStr;
    NSString * _title;
    NSString * _text;
    NSString * _describe;

    UILabel * _titleLabel;
    UILabel * _nameLabel;
    UILabel * _describeLabel;
    UILabel * _renzhenLabel;
    UIImageView * _imageView;
    UIImageView * _selImageView;

    int _style;
}


@end

@implementation RealnameButton

-(instancetype)initWithFrame:(CGRect)frame image:(NSString *)imageName selImage:(NSString *)selimageName title:(NSString *)title  describe:(NSString *)describe
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageStr = imageName;
        _selimageStr = selimageName;
        _title = title;
        _describe = describe;
        _style = 0 ;
        [self show];
        return self;
    }
    return  nil;
}

//默认style == 0  ，  实名认证 style = 1
-(void)setStyle:(int)style
{
    _style = style;
    if (_style == 0) {
        [_nameLabel removeFromSuperview];
     //   _describeLabel.textColor = COLOR_BL_5;
        _describeLabel.font = [UIFont systemFontOfSize:JN_HH(10)];
    }else {
        [self addSubview:_nameLabel];
      //  _describeLabel.textColor = COLOR_BL_5;
    }
    _describeLabel.frame = CGRectMake(JN_HH(15), self.height - JN_HH(30), self.width - JN_HH(5), JN_HH(20));
    _renzhenLabel.frame = CGRectMake(JN_HH(15), self.height - JN_HH(40), self.width - JN_HH(15) * 2, JN_HH(20));
}
// style = 1 这个方法才有用
-(void)setText:(NSString *)text
{
    if (_style != 1) {
        return ;
    }
    _text = text;
    _nameLabel.text = text;

}

-(void)show
{
    JNViewStyle(self, 5, nil, 0);
    float x = JN_HH(15);
   self.backgroundColor = COLOR_WHITE;
    _imageView = JnImageView(CGRectMake(JN_HH(5), JN_HH(5), JN_HH(44), JN_HH(44)), MYimageNamed(_imageStr));
    [self addSubview:_imageView];

    _titleLabel = JnLabelType(CGRectMake(JN_HH(49), JN_HH(5), 200, JN_HH(44)), UILABEL_5, _title, 0);
    [self addSubview:_titleLabel];

    _nameLabel = JnLabel(CGRectMake(x, JN_HH(50), 200, JN_HH(30)), _text, JN_HH(25.5), SXRGB16Color(0x4D4D4D), 0);
    [self addSubview:_nameLabel];

    _describeLabel = JnLabelType(CGRectMake(x, self.height - JN_HH(30), self.width - x, JN_HH(20)), UILABEL_5, _describe, 0);
    _describeLabel.font = [UIFont systemFontOfSize:JN_HH(10)];
    [self addSubview:_describeLabel];

    _renzhenLabel = JnLabelType(CGRectMake(x, self.height - JN_HH(40), self.width - x * 2, JN_HH(20)), 5, @"立即认证 〉", 2);
    _renzhenLabel.font = [UIFont systemFontOfSize:JN_HH(11)];
    _renzhenLabel.textColor = COLOR_A1;
    [self addSubview:_renzhenLabel];

    _selImageView = JnImageView(CGRectMake(self.width - JN_HH(36), 0, JN_HH(36), JN_HH(36)), MYimageNamed(@"wd_rzrzwc"));
    [self addSubview:_selImageView];
    self.selected = NO;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [_renzhenLabel removeFromSuperview];
        [self addSubview: _selImageView];
        _imageView.image = MYimageNamed(_selimageStr);
        _titleLabel.textColor = COLOR_BL_2;
    }else {
        [self addSubview:_renzhenLabel];
        [_selImageView removeFromSuperview];
        _imageView.image = MYimageNamed(_imageStr);
        _titleLabel.textColor = COLOR_BL_3;
    }
}


@end
