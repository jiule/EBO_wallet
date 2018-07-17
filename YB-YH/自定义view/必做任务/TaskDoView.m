//
//  TaskDoView.m
//  YB-YH
//
//  Created by Apple on 2018/6/20.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TaskDoView.h"
#import "BaseModel.h"
#import "TaskDoBtn.h"

@interface TaskDoView()
{
    NSArray  <BaseModel *>* _textArrays; //数据模型
    NSString * _clsName;  //子类的名称

    float _time;  //定时器的时间

}

@property(nonatomic,assign)NSTimer * timer;

@property(nonatomic,retain)UIView * downView;

@property(nonatomic,assign)int index;

@end


@implementation TaskDoView

-(instancetype)initWithFrame:(CGRect)frame textArrays:(NSArray *)textArrays btnClsName:(NSString *)clsNmae
{
    self = [super initWithFrame:frame];
    _time = 3;
    _textArrays = textArrays;
    _clsName = clsNmae;
    JNViewStyle(self, 10, nil, 0);
    self.clipsToBounds = YES;
    _index = 1;
    self.backgroundColor = COLOR_WHITE;
    if (self) {
        [self show];
        return self;
    }
    return nil;
}
-(void)showWtihTextArrays:(NSArray  <BaseModel *> *)textArrays
{
    _textArrays = textArrays;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self show];
}
-(void)show
{
    if (_textArrays.count <= 4) {
        return ;
    }
    float b_w = self.width - JN_HH(20);
    UIView * downView = JnUIView(CGRectMake(JN_HH(10), JN_HH(10), self.width - JN_HH(20) - 2 ,self.height - JN_HH(20)), COLOR_WHITE);
    downView.clipsToBounds = YES;
    [self addSubview:downView];
    self.downView = JnUIView(CGRectMake(0, 0, b_w / 3 * (_textArrays.count + 4) ,downView.height), COLOR_WHITE);
    [downView addSubview:self.downView];

    for (int i = 0 ; i < _textArrays.count; i++)
    {
        Class cls = NSClassFromString(_clsName);
        TaskDoBtn * btn = [[cls alloc]initWithFrame:CGRectMake(b_w / 3 * (i + 2), 0, b_w / 3, downView.height)];
            btn.model =_textArrays[i];
        [self.downView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i + 2;
     }

    Class cls = NSClassFromString(_clsName);
    TaskDoBtn * btn = [[cls alloc]initWithFrame:CGRectMake(0, 0, b_w / 3, downView.height)];
    btn.model = _textArrays[(int)_textArrays.count - 2] ;
    [self.downView addSubview:btn];
    btn.tag = 98;

    TaskDoBtn * btn1 = [[cls alloc]initWithFrame:CGRectMake(b_w / 3, 0, b_w / 3, downView.height)];
    btn1.model = _textArrays[(int)_textArrays.count - 1] ;
    [self.downView addSubview:btn1];
    btn1.tag = 99;

    TaskDoBtn * btn2 = [[cls alloc]initWithFrame:CGRectMake(b_w / 3 * ((int)_textArrays.count + 2), 0, b_w / 3, downView.height)];
    btn2.model = _textArrays[0] ;
    [self.downView addSubview:btn2];
    btn2.tag = 100 + _textArrays.count ;

    TaskDoBtn * btn3 = [[cls alloc]initWithFrame:CGRectMake(b_w / 3 * ((int)_textArrays.count + 3), 0, b_w / 3, downView.height)];
    btn3.model = _textArrays[1] ;
    [self.downView addSubview:btn3];
    btn3.tag = 100 + _textArrays.count + 1 ;

    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateTimer
{
    [self SwipePlaceholderImageView:YES];
}

-(void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    _timer.fireDate = [NSDate distantPast];
}

-(void)endTimer
{
    _timer.fireDate = [NSDate distantFuture];
    [_timer invalidate]; // 销毁timer
    _timer = nil; // 置nil
}

-(void)SwipePlaceholderImageView:(BOOL)isLeft
{
    float b_w = (self.width - JN_HH(20)) / 3;
    int index = (int)_textArrays.count;
    if (isLeft) {
        if (_index == index + 1) {
            _index = 1;
             [ self.downView setX:-b_w * self.index];
        }
        _index ++ ;
        [UIView animateWithDuration:0.2 animations:^{
             [ self.downView setX:-b_w * self.index];
        } completion:^(BOOL finished) {
            if (self.index == index + 1) {
                self.index = 1 ;
                [ self.downView setX:-b_w * self.index];
            }
        }];
    }else {
        if (_index == 1) {
            _index = index + 1 ;
            [ self.downView setX:-b_w * self.index];
        }
        _index-- ;
        [UIView animateWithDuration:0.2 animations:^{
         [ self.downView setX:-b_w * self.index];
        } completion:^(BOOL finished) {
            if (self.index == 1) {
                self.index = index + 1 ;
                [ self.downView setX:-b_w * self.index];
            }
        }];
    }
}

-(void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector: @selector(didView:btn:)]) {
        [_delegate didView:self btn:btn];
    }
}
@end
