//
//  AssetsBtn.m
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "AssetsBtn.h"
#import "AssetModel.h"

@interface AssetsBtn()
{
    AssetModel * _assetModel;

    UILabel * _titleLabel;
    UIImageView * _imageView;
    UILabel * _numLabel;
}


@end

@implementation AssetsBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self createView];
        return self;
    }
    return  nil;
}

-(void)createView
{
    _titleLabel = JnLabel(CGRectMake(0, JN_HH(5), self.width, JN_HH(15)), @"", JN_HH(13.5), SXRGB16Color(0x373775), 1);
    [self addSubview:_titleLabel];

    _imageView = JnImageView(CGRectMake( JN_HH(10) + self.width * 0.25, self.height * 0.5 - self.width * 0.25 + JN_HH(10) , self.width * 0.5 - JN_HH(20), self.width * 0.5 - JN_HH(20)), MYimageNamed(@"11"));
    [self addSubview:_imageView];

    _numLabel = JnLabel(CGRectMake(0, self.height - JN_HH(20), self.width, JN_HH(15)), @"55555", JN_HH(13.5), COLOR_A1, 1);
   // _numLabel.backgroundColor  = COLOR_A2;
    [self addSubview:_numLabel];

    //添加一个分割线
    [self addUnderscoreWihtFrame:CGRectMake(self.width - 1, JN_HH(10), 1, self.height-JN_HH(20))];
}


-(void)setModel:(BaseModel *)model
{
    [super setModel:model];
    _assetModel = (AssetModel *)model;
    _titleLabel.text = _assetModel.title;
    _numLabel.text = [NSString stringWithFormat:@"奖励%@%@",_assetModel.num,BI_A0];
    _imageView.image = MYimageNamed(_assetModel.imageUrl);
}


-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (!selected) {
        _imageView.image = MYimageNamed(_assetModel.imageUrl);

    }else {
        NSString * str = [NSString stringWithFormat:@"%@h",_assetModel.imageUrl];
        _imageView.image = MYimageNamed(str);
        _titleLabel.textColor = COLOR_H1;
        _numLabel.textColor =  COLOR_H1;

    }
}

@end
//////////-----------------------------------------------
#pragma mark-------高级按钮
/////////--------------------------------------------------
@interface AssetsGaojiBtn()
{
    AssetGaojiModel * _assetModel;

    UILabel * _titleLabel;
    UIImageView * _imageView;
    UILabel * _numLabel;
    UILabel * _qianLabel;
    UIImageView * _qianImageView;


    UIImageView * _selImageView;


}
@end

@implementation AssetsGaojiBtn


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self createView];
        return self;
    }
    return  nil;
}

-(void)createView
{
    JNViewStyle(self, 5, nil, 0);
    self.backgroundColor = COLOR_WHITE;


    _imageView = JnImageView(CGRectMake( JN_HH(5), JN_HH(10), JN_HH(40), JN_HH(40)), MYimageNamed(@"11"));
    [self addSubview:_imageView];

    _titleLabel = JnLabel(CGRectMake(JN_HH(50), JN_HH(10), self.width, JN_HH(20)), @"", JN_HH(13.5), SXRGB16Color(0x727275), 0);
    [self addSubview:_titleLabel];

    _numLabel = JnLabel(CGRectMake(JN_HH(50),  JN_HH(35), self.width, JN_HH(15)), @"55555", JN_HH(13.5), COLOR_A1, 0);
    [self addSubview:_numLabel];

    _selImageView = JnImageView(CGRectMake(self.width - JN_HH(100), 0, JN_HH(100), self.height), MYimageNamed(@"sy_xingyongwwcrw"));
    [self addSubview:_selImageView];

    _qianImageView = JnImageView(CGRectMake(self.width - JN_HH(30),self.height * 0.5 - JN_HH(15) , JN_HH(30), JN_HH(30)), MYimageNamed(@"jiantou_W1_88"));
    [self addSubview:_qianImageView];

    _qianLabel = JnLabel(CGRectMake(self.width - JN_HH(80), self.height * 0.5 - JN_HH(10), JN_HH(60), JN_HH(20)), @"前往任务", JN_HH(13.5), COLOR_WHITE, 0);
    [self addSubview:_qianLabel];


}
-(void)setModel:(BaseModel *)model
{
    [super setModel:model];
    _assetModel = (AssetGaojiModel *)model;
    _titleLabel.text = _assetModel.title;
    _numLabel.text = [NSString stringWithFormat:@"+%@ccs",_assetModel.num];
    if ([_assetModel.selNum intValue] == 0) {
        self.selected = NO;
    }else {
        self.selected = YES;
    }
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (!selected) {
        _selImageView.image = MYimageNamed(@"sy_xingyongwwcrw");
        _qianLabel.text = @"前往任务";
        _qianLabel.textColor = COLOR_WHITE;
        _qianImageView.alpha = 1;
        _qianLabel.textAlignment = NSTextAlignmentLeft;
        _imageView.image = MYimageNamed(_assetModel.imageUrl);
        _numLabel.textColor = COLOR_H1;
    }else {
        _selImageView.image = MYimageNamed(@"sy_xingyongwcrw");
        _qianLabel.text = @"已完成";
        _qianLabel.textColor = COLOR_WHITE;
        _qianImageView.alpha = 0;
        _qianLabel.textAlignment = NSTextAlignmentCenter;
        NSString * str = [NSString stringWithFormat:@"%@h",_assetModel.imageUrl];
         _imageView.image = MYimageNamed(str);
    }
}


@end
