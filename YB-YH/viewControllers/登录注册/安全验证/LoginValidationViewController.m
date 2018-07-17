//
//  LoginValidationViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "LoginValidationViewController.h"
#import "RootViewController.h"
#import "RegisteredObj.h"

@interface LoginValidationViewController ()
{
    UIImageView * _validationimageView;
    UIImageView * _validationimageView1;
    CGPoint  _validationimageViewPoint;
    CGPoint  _validationPoint;
}

@end

@implementation LoginValidationViewController

-(void)Initialize
{
    [super Initialize];
    _validationimageViewPoint = CGPointMake( (int)rand() % (int)(SCREEN_WIDTH - JN_HH(200)) + JN_HH(100), self.nav_h + JN_HH(100) +rand() % 100 );
    _validationPoint = CGPointMake( (int)rand() % (int)(SCREEN_WIDTH - JN_HH(200)) + JN_HH(100), self.nav_h + JN_HH(300) +rand() % 200 );
}

-(void)createView
{
    [self.view addSubview:JnLabel(CGRectMake(0, self.nav_h + JN_HH(39), SCREEN_WIDTH, JN_HH(25)), @"为了你的账户安全,本次登录需要进行验证", JN_HH(13.5), COLOR_A1, 1)];
    [self.view addSubview:JnLabel(CGRectMake(0, self.nav_h + JN_HH(69), SCREEN_WIDTH, JN_HH(25)), @"请将下放的图标,移动到圆形区域内", JN_HH(13.5), COLOR_A1, 1)];

    UIImageView * imageView1 = JnImageView(CGRectMake(_validationPoint.x, _validationPoint.y, JN_HH(75), JN_HH(75)), MYimageNamed(@"dl_dongtai2"));
    JNViewStyle(imageView1, JN_HH(37.5), nil, 0);
//    imageView1.backgroundColor = COLOR_A1;
    [self.view addSubview:imageView1];
    _validationimageView1 = imageView1;

    _validationimageView = JnImageView(CGRectMake(_validationimageViewPoint.x, _validationimageViewPoint.y, JN_HH(75), JN_HH(75)), MYimageNamed(@"dl_dongtai1"));
    JNViewStyle(_validationimageView, JN_HH(37.5), nil, 0);
  //  _validationimageView.backgroundColor = COLOR_A1;
    [self.view addSubview:_validationimageView];



    [_validationimageView addpanGestureTecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)tap;
        CGPoint position =[pan translationInView:self.view];
        //通过stransform 进行平移交换
        view.transform = CGAffineTransformTranslate(view.transform, position.x, position.y);
        //将增量置为零
        [pan setTranslation:CGPointZero inView:self.view];

        if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateChanged ) {
            if (fabs(view.frame.origin.x - self->_validationPoint.x) <= 10 && (fabs(view.frame.origin.y - self->_validationPoint.y) <= 10)) {
                if (pan.state == UIGestureRecognizerStateEnded) {
                    [view removeGestureRecognizer:tap];
                    [MYAlertController showTitltle:@"验证通过" selButton:^(MYAlertController *AlertController, int index) {
                         [[RootViewController sharedInstance]loginOK];
//                             [self postdownDatas:@"/user/login/login" withdict:@{@"username":[RegisteredObj sharedInstance].iphone,@"password":[RegisteredObj sharedInstance].password,@"device_type":@"iphone",@"jpush_id":@"1234"} index:1 type:0];
                    }];
                }else {
                    self->_validationimageView1.image = MYimageNamed(@"dl_dongtai2");
                    self->_validationimageView.image = MYimageNamed(@"dl_dongtai1");
                }
            }else
            {
                self->_validationimageView1.image = MYimageNamed(@"dl_dongtai2");
                self->_validationimageView.image = MYimageNamed(@"dl_dongtai1");
            }
        }
    }];
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if  (index == 1){
        self.model = [[PersonalModel alloc]initWithDict:responseDict[@"user"]];
        [MyNetworkingModel sharedInstance].token = responseDict[@"token"];
        [[RootViewController sharedInstance]loginOK];
    }
}

@end
