//
//  CandyView.m
//  YB-YH
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "CandyView.h"

@interface CandyView()


@property(nonatomic,assign)int num;

@property(nonatomic,retain)UILabel * titleLabel;

@property(nonatomic,retain)UILabel * numLabel;

@property(nonatomic,retain)UIImageView * imageView;

@end


@implementation CandyView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        return self;
    }
    return nil;
}


+(void)showWithnum:(int)num delegate:(id<JNBaseViewDelegate>)delegate
{
   CandyView * view =  [[CandyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   view.num = num;
    view.delegate = delegate;
   [view show];
}

-(void)show
{

    UIView * wView = JnUIView(CGRectMake(self.width *0.5 - JN_HH(100), self.height *0.5 - JN_HH(100), JN_HH(200), JN_HH(200)),COLOR_WHITE);
    [self addSubview:wView];
    JNViewStyle(wView, JN_HH(10), nil, 0);

    [wView addSubview:JnButtonImageTag(CGRectMake(JN_HH(160), JN_HH(0), JN_HH(40), JN_HH(40)), MYimageNamed(@""), self, @selector(close), 0)];

    _imageView = JnImageView(CGRectMake(JN_HH(70), JN_HH(20), JN_HH(60), JN_HH(60)), MYimageNamed(@"sy_wlqtgg"));
    [wView addSubview:_imageView];

    _titleLabel = JnLabel(CGRectMake(0, JN_HH(90), JN_HH(200), JN_HH(20)), [NSString stringWithFormat:@"您尚未领取%@糖果",BI_A0], JN_HH(13.5), COLOR_A2, 1);
    [wView addSubview:_titleLabel];

    _numLabel = JnLabel(CGRectMake(0, JN_HH(115), JN_HH(200), JN_HH(25)), [NSString stringWithFormat:@"%d枚",_num], JN_HH(15.5), COLOR_A1, 1);
    [wView addSubview:_numLabel];

    UIButton * btn = JnButtonTextType(CGRectMake(JN_HH(60), JN_HH(150), JN_HH(80), JN_HH(30)), @"领取", 0, self, @selector(btnClick:));
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    JNViewStyle(btn, JN_HH(15), nil, 0);
    [wView addSubview:btn];

    [[UIViewController getCurrentVC].view.window addSubview:self];
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.selected) {
        [self removeFromSuperview];
    }else {
        [MyNetworkingManager POST:@"/user/Assets/receiveSuger" withparameters:@{@"cost":[NSString stringWithFormat:@"%d",_num]} progress:^(NSProgress * _Nonnull progress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self->_imageView removeFromSuperview];
            self->_titleLabel.text = @"领取成功";
            [self->_numLabel removeFromSuperview];
            btn.selected = YES;
            if ([self->_delegate respondsToSelector:@selector(didView:)]) {
                [self->_delegate didView:self];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //  [MYAlertController  showTitltle:@"领取失败"];
        }];
    }
}


-(void)close
{
    [self removeFromSuperview];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self removeFromSuperview];
//}

@end
