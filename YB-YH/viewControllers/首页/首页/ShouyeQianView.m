//
//  ShouyeQianView.m
//  YB-YH
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ShouyeQianView.h"

@implementation ShouyeQianView

-(instancetype)init{
    if (self = [super init]) {
        [self createView];
    }
    return self;
}

-(UIImageView *)imgeV{
    if (!_imgeV) {
        _imgeV = [UIKitAdditions imageViewWithImageName:@""];
    }
    return _imgeV;
}
-(UILabel *)balanceLb{
    if (!_balanceLb) {
        _balanceLb = [UIKitAdditions labelWithBlackText:@"88" fontSize:20];
        _balanceLb.textAlignment = NSTextAlignmentRight;
    }
    return _balanceLb;
}
-(UILabel *)rmbLb{
    if (!_rmbLb) {
        _rmbLb = [UIKitAdditions labelWithText:@"" textColor:[UIColor grayColor] alignment:2 fontSize:14];
    }
    return _rmbLb;
}
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [UIKitAdditions labelWithBlackText:@"" fontSize:15];
    }
    return _titleLb;
}
-(void)createView{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowRadius = 4.0f;
    self.layer.cornerRadius = 4.0f;
    self.layer.shadowOffset = CGSizeMake(-1,2);
    
    [self addSubview:self.imgeV];
    [self.imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(20);
    }];
    [self addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgeV.mas_right).offset(20);
        make.top.equalTo(self.imgeV);
    }];

    [self addSubview:self.balanceLb];
    [self.balanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.imgeV);
    }];
    [self addSubview:self.rmbLb];
    [self.rmbLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.balanceLb.mas_bottom).offset(20);
    }];
}

@end
