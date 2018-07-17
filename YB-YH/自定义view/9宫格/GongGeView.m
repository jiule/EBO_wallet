//
//  GongGeView.m
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import "GongGeView.h"

typedef void (^didGongGeView)(GongGeView * View,int index);

@interface GongGeView()
{
    int _num;
    didGongGeView _gonggeblock;

    BOOL  _is_url;
}

@property(nonatomic,retain)NSArray * textArrays;

@property(nonatomic,retain)NSArray * imageArrays;

@end

@implementation GongGeView

-(instancetype)initWithFrame:(CGRect)frame imageArrays:(NSArray *)imageArrays number:(int)number
{
    return  [self initWithFrame:frame imageArrays:imageArrays textArrays:imageArrays number:number];
}
-(instancetype)initWithFrame:(CGRect)frame imageArrays:(NSArray *)imageArrays textArrays:(NSArray *)textArrays number:(int)number
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textArrays = textArrays;
        self.imageArrays = imageArrays;
        if ( number <=0 ||self.textArrays.count != self.imageArrays.count || self.textArrays.count % number !=0) {
            NSLog(@"参数错误");
            return nil;
        }
        _num = number;
        [self createView];
        return self;
    }
    return nil;
}
-(instancetype)initWithFrame:(CGRect)frame imageUrlArrays:(NSArray *)imageUrlArrays textArrays:(NSArray *)textArrays  number:(int)number
{
    _is_url = YES;
    return  [self initWithFrame:frame imageArrays:imageUrlArrays textArrays:textArrays number:number];
}

-(void)createView
{
    int w = (int)self.textArrays.count / _num;
    int btn_w = self.width / _num;
    int btn_h = self.height / w;
    int image_h = btn_h * 0.8;

    for (int j = 0 ; j < w; j++) {
        for (int i = 0 ; i < _num; i++) {
            int index = i + j *_num;
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * btn_w, j * btn_h, btn_w, btn_h);
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100 + index ;
            [self addSubview:btn];
            if (_is_url) {
                UIImageView * imageView =JnImageView(CGRectMake(btn_w * 0.5 - image_h * 0.3 , image_h * 0.25, image_h *0.5, image_h *0.5), nil);
                [imageView setimage:nil withurl:self.imageArrays[index]];
                [btn addSubview:imageView];
            }else {
                [btn addSubview:JnImageView(CGRectMake(btn_w * 0.5 - image_h * 0.3 , image_h * 0.2, image_h * 0.6, image_h*0.6), MYimageNamed(self.imageArrays[index]))];
            }
            [btn addSubview:JnLabelType(CGRectMake(0, image_h * 0.95, btn_w, btn_h - image_h * 0.95 - 10), GongGeView_LABEL_TYPE, self.textArrays[index], 1)];
        }
    }
}

-(void)BtnClick:(UIButton *)btn
{
    if (_gonggeblock) {
        _gonggeblock(self,(int)btn.tag - 100);
    }
}
-(void)didBtnsuccess:(void (^)(GongGeView * view,int index))btnsuccess
{
    _gonggeblock = btnsuccess;
}

@end
