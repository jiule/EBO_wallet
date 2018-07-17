//
//  IPhoneAlectView.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "IPhoneAlectView.h"
#import "BaseView.h"

@interface IPhoneAlectView()

@property(nonatomic,copy)IPhoneAlect alect;

@property(nonatomic,retain)UITextField * yanzhengField;

@property(nonatomic,retain)UITextField  * passWordField;

@property(nonatomic,retain)UIButton * yuyinBtn;

@property(nonatomic,copy)NSString * str;

@property(nonatomic,retain)NSMutableArray * textArray;

@property(nonatomic,retain)UIView * bgView;

@end

@implementation IPhoneAlectView

+(void)showWithAlect:(IPhoneAlect)alect
{
    IPhoneAlectView * view = [[IPhoneAlectView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.alect = alect;
    [UIView animateWithDuration:0.3 animations:^{
        [view setY:0];
    }];
}

-(NSMutableArray *)textArray
{
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self show];
        return  self;
    }
    return nil;
}
-(void)show
{
    self.backgroundColor = COLOR_B(0.7);
    _str = @"";
    UIView * bgView = JnUIView(CGRectMake(0,  JN_HH(200), SCREEN_WIDTH , SCREEN_HEIGHT - JN_HH(200) ), SXRGB16Color(0xf5f5f5));
    _bgView = bgView;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];

    [bgView addSubview:JnLabelType(CGRectMake(0, 0, self.width, JN_HH(40)), UILABEL_1, @"输入交易密码", 1)];
    [bgView addSubview:JnButtonImageTag(CGRectMake(bgView.width - JN_HH(44), 0, JN_HH(40), JN_HH(40)), MYimageNamed(@"jiaoyi_x"), self, @selector(quxiaoClick), 0)];

    [bgView addUnderscoreWihtFrame:CGRectMake(0, JN_HH(40) - 1, self.width, 1)];

    UIView * mimaView = JnUIView(CGRectMake(JN_HH(15), JN_HH(70), self.width - JN_HH(30), self.width / 6 - JN_HH(5)), COLOR_WHITE);
    JNViewStyle(mimaView, 2, DIVIDER_COLOR1, 1);
    for (int i = 0 ; i <= 5; i++) {
        UIView * dianView = JnUIView(CGRectMake( mimaView.width / 12 * (1 + 2 * i ) - 5, mimaView.height/ 2 - 5, 10, 10), COLOR_BLACK);
        [mimaView addSubview:dianView];
        dianView.tag = 200 +i;
        dianView.alpha = 0;
        JNViewStyle(dianView, 5, nil, 0);
        if (i > 0) {
             [mimaView addSubview:JnUIView(CGRectMake(mimaView.width / 6 * i , 0, 1, mimaView.height), DIVIDER_COLOR1)];
        }
    }

    float h = mimaView.height + JN_HH(120) ;
    float b_h = CGSCREEN_HEIGHT()  - h -[bgView getY];

    for (int  i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            int index = j + i * 3 + 1;
            NSString * str = [NSString stringWithFormat:@"%d",index];
            if (index == 10) {
                str = @"清空";
            }else if(index == 11)
            {
                str = @"0";
            }

            UIButton * btn = JnButton_tag(CGRectMake( self.width / 3 * j, b_h / 4 * i + h, self.width / 3 , b_h / 4), COLOR_WHITE, self, @selector(BtnCLick:), 100 + index);
            if (index < 12) {
                 [btn setTitle:str forState:UIControlStateNormal];
                 [btn setTitleColor:COLOR_BLACK forState:0];
                if (index == 10) {
                    btn.backgroundColor = bgView.backgroundColor;
                    [btn setTitleColor:COLOR_BL_3 forState:0];
                    [[btn titleLabel] setFont:[UIFont systemFontOfSize:UILABEL_BZ_3]];
                }
            }else {
                btn.backgroundColor = bgView.backgroundColor;
                [btn addSubview:JnImageView(CGRectMake(btn.width * 0.5 - JN_HH(25), btn.height * 0.5 - JN_HH(18), JN_HH(50), JN_HH(36)),MYimageNamed(@"交易确认删除"))];
            }

            [bgView addSubview:btn];

            if (j != 2) {
                [btn addSubview:JnUIView(CGRectMake(btn.width - 1, 0, 1, btn.height), COLOR_B4)];
            }
            if (i < 3) {
                 [btn addSubview:JnUIView(CGRectMake(0, btn.height - 1, btn.width, 1), COLOR_B4)];
            }

        }
    }

    [bgView addSubview:mimaView];
    [[UIViewController getCurrentVC].view.window addSubview:self];
}

-(void)BtnCLick:(UIButton *)btn
{
    if (btn.tag == 110) {
        [self.textArray removeAllObjects];
    }else if(btn.tag == 112)
    {
        [self.textArray removeLastObject];
    }else {
        [self.textArray addObject:[btn titleForState:0]];
    }

    for (int i = 0 ; i < 6; i++) {
        UIView * view = [_bgView viewWithTag:200 + i];
        if (view.tag - 200 < self.textArray.count) {
            view.alpha = 1;
        }else {
            view.alpha = 0;
        }
    }


    if (self.textArray.count >= 6) {
        _str = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.textArray[0],self.textArray[1],self.textArray[2],self.textArray[3],self.textArray[4],self.textArray[5]];
        if (self.alect) {
            self.alect(YES,_str);
        }
        [self removeFromSuperview];
    }
}


-(void)quxiaoClick
{
    if (self.alect) {
        self.alect(NO,nil);
    }
    [self removeFromSuperview];
}

-(void)removeFromSuperview
{
    [UIView animateWithDuration:0.3 animations:^{
         [self setY:SCREEN_HEIGHT];
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

@end
