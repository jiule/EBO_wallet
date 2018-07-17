//
//  MIPickerView.m
//  duwen
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 duwen. All rights reserved.
//

#import "MIPickerView.h"

@interface MIPickerView ()

@property(nonatomic,assign)MIView_TYPE type;

@property(nonatomic,copy)selectPickerImage MIPickerimage;

@property(nonatomic,assign)float timer;
@end

@implementation MIPickerView

+(instancetype)showWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage timer:(float)timer
{
    return [[MIPickerView alloc]initWithType:type MIPickerimage:MIPickerimage timer:timer];
}

+(instancetype)showWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage
{
    return [self showWithType:type MIPickerimage:MIPickerimage timer:MIView_timer];
}

-(instancetype)initWithType:(MIView_TYPE)type MIPickerimage:(selectPickerImage)MIPickerimage timer:(float)timer
{
    _type = type;   _MIPickerimage = MIPickerimage;   _timer = timer;
    if (self = [ super initWithFrame:MIFrameWithMIType(type) BgColor:[[UIColor blackColor]colorWithAlphaComponent:0.5 ]])
    {
        [self createView];
        [self show];
    }
    return self ;
}

-(void)createView
{
    NSArray * array = @[@"相册",@"拍照"];
    for (int i = 0 ; i < array.count; i++) {
        
        UIButton * btn = JNButtonIndexSize(CGRectMake(13, JN_HHH(SCREEN_HEIGHT) - 50 * ( 4- i) + 45, SCREEN_JNWIDTH - 26, 50), array[i], 18, [UIColor blackColor], [UIColor whiteColor], 1, self,  @selector(BtnClick:));
     //   UIViewSetStyle(btn, 22, [UIColor redColor], 1);
        btn.tag = 100 + i;
        [self addSubview:btn];
        [btn setX:0];
        [btn setW:SCREEN_WIDTH];
        if (i == 0) {
            [btn addSubview:JnUIView(CGRectMake(0, JN_HH(50) - 1, SCREEN_WIDTH, 1),DIVIDER_COLOR )];
        }
    }
    
    UIButton * btn = JNButtonIndexSize(CGRectMake(13, JN_HHH(SCREEN_HEIGHT) - 50 , SCREEN_JNWIDTH - 26, 50), @"取消", 18, [UIColor blackColor], [UIColor whiteColor], 1, self,  @selector(BtnClick:));
  //  UIViewSetStyle(btn, 22, [UIColor redColor], 1);
    btn.tag = 100 + array.count;
    [self addSubview:btn];
    [btn setX:0];
    [btn setW:SCREEN_WIDTH];
    
    [[UIViewController getCurrentVC].view addSubview:self];
}

-(void)show
{
    [UIView animateWithDuration:_timer animations:^{
        [self setX:0];
        [self setY:0];
    }];
}

-(void)BtnClick:(UIButton *)btn
{
    if  (btn.tag == 102)
    {
        [self removeFromSuperview];
    }else {
        JNWeakSelf(self);
        [[MIPickerimage sharedInstance]PickerpushWithscurceType:btn.tag - 100 MIPickerimage:^(UIImage * _Nonnull image) {
            weakself.MIPickerimage(image);
            [self removeFromSuperview];
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self removeFromSuperview];
}



@end
