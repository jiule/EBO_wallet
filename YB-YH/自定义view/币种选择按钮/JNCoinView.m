//
//  JNCoinView.m
//  YB-YH
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "JNCoinView.h"


@interface JNCoinView()

@end


@implementation JNCoinView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self show];
        return self;
    }
    return nil;
}

-(void)show{

    _titleLabel = JnLabel(CGRectMake(0, 0, self.width - 28, self.height), BI_A0, 15.5, COLOR_WHITE, 2);
    [self addSubview:_titleLabel];

    _imageView = JnImageView(CGRectMake(self.width - 24 , self.height / 2 - 4.5, 16, 9), MYimageNamed(@"sy_xiajiantou"));
    [self addSubview:_imageView];

    [self addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        if ([self.delegate respondsToSelector:@selector(didView:)]) {
            [self.delegate didView:self];
        }
    }];
}



@end
