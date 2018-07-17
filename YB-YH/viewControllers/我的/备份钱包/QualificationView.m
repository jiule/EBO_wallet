//
//  QualificationView.m
//  YB-YH
//
//  Created by Apple on 2018/7/17.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "QualificationView.h"
#import "CurrencyManager.h"

@interface QualificationView()

@end

@implementation QualificationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
            if ([self->_delegate respondsToSelector:@selector(didView:)]) {
                [self->_delegate didView:self];
            }
        }];
        return self;
    }
    return nil;
}



-(void)showWithspecies:(NSString *)species
{
    ZiCurrencyModel * curModel  = [CurrencyManager readZiModelWithSpecies:species];  //获取用户币种信息
    CurrencyModel * encyModel = [CurrencyManager readCurModelWithSpecies:species];   //获取币种图标信息




}

@end
