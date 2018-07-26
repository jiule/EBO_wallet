//
//  WodeViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "WodeViewController.h"
#import "BaseView.h"
#import "MIPickerimage.h"
#import "MIPickerView.h"
#import "RootViewController.h"

@interface WodeViewController () <JNBaseViewDelegate>
{
    NSArray * _nameArrays;
    NSArray * _imageArrays;

    UIView * _upView;
    UIView * _downView;

    NSArray * _controllerArrays;
    NSArray * _controllerTitleArrays;

    UITextField * _niceField;
    UIImageView * _niceImageView;
    UILabel * _lingquBiLabel;
    UIButton * _lingBtn;
    int _lingNum;
    UIButton * _niceBtn;

    float _downY;
}

@end

@implementation WodeViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _niceBtn.selected = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _niceField.text = self.model.nickname;

    [_niceImageView setimageWithurl:self.model.avatar];
}
-(void)Initialize
{
    [super Initialize];
    _nameArrays = @[@"邀请好友",@"实名认证",@"安全中心",@"系统消息",@"设置",@"关于我们",@"退出登录"];
    _imageArrays = @[@"wd_yaoqing",@"wd_shiming",@"wd_anquan",@"wd_xitong",@"wd_shezhi",@"wd_guanyu",@"wd_guanyu"];
    _controllerArrays = @[@"MyInvitationViewController",@"MyRealnameViewController",@"MySecurityCenterViewController",@"MyAlertsViewController",@"MySetViewController",@"MyAboutViewController"];
    _controllerTitleArrays = @[@"邀请好友",@"实名认证",@"安全中心",@"消息",@"设置",@"关于我们"];
}

-(void)createNavView
{
    [super createNavView];
    self.navView.backgroundColor = [UIColor clearColor];
    [self.navView setStyle:3];
    self.navView.titleLabel.textColor = COLOR_WHITE;

}


-(void)createView
{
    [super createView];
    float  h = JN_HH(0) + self.nav_h;
    _upView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, JN_HH(100) + h ), COLOR_A1);
    [self.view addSubview:_upView];
    [_upView addUnderscoreBottomline];
    _upView.userInteractionEnabled = YES ;

    _niceImageView = JnImageViewCornerRadius(CGRectMake(JN_HH(20), h + JN_HH(20) , JN_HH(60), JN_HH(60)), MYimageNamed(@"sy_ebog"), JN_HH(30));
   // _niceImageView.backgroundColor = COLOR_B1;
    [_niceImageView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        [self niceImageClick];
    }];
    [_upView addSubview:_niceImageView];

    _niceField = JnTextFiled(CGRectMake(JN_HH(100), h +JN_HH(30) ,SCREEN_WIDTH - JN_HH(150), JN_HH(40)), @"输入昵称", 0);
    _niceField.backgroundColor = [UIColor clearColor];
    _niceField.clearButtonMode = UITextFieldViewModeNever;
    _niceField.textColor = COLOR_WHITE;
    _niceField.font = [UIFont systemFontOfSize:18.5];
    [_upView addSubview:_niceField];
    _niceField.userInteractionEnabled = NO;

    UIButton * niceBtn = JnButtonTextType(CGRectMake(SCREEN_WIDTH - JN_HH(80), h+ JN_HH(40) , JN_HH(60), JN_HH(20)), @"修改", 0, self, @selector(niceBtnClick:));
    [niceBtn setTitle:@"确定" forState:UIControlStateSelected];
    [niceBtn setTintColor:COLOR_WHITE];
    [[niceBtn titleLabel ] setFont: [UIFont systemFontOfSize:14.5]];
    [niceBtn setBackgroundColor:COLOR_A1];
  //  JNViewStyle(niceBtn, 5, nil, 0);
    [_upView addSubview:niceBtn];
    _niceBtn = niceBtn;

    h += JN_HH(100);
    [self.view addSubview:JnUIView(CGRectMake(0, h, SCREEN_WIDTH, JN_HH(44)), COLOR_WHITE)];
    _lingquBiLabel = JnLabelType(CGRectMake(JN_HH(20), h, SCREEN_WIDTH - JN_HH(40), JN_HH(44)), UILABEL_3, @"您已领取糖果", 0);
    [self.view addSubview:_lingquBiLabel];

    _lingBtn = JnButtonColorIndexSize(CGRectMake(SCREEN_WIDTH - JN_HH(115), h + JN_HH(7), JN_HH(100), JN_HH(30)), @"现在领取", JN_HH(15.5), COLOR_A1, COLOR_WHITE, 1, self, @selector(lingBtnClick), 0);
    _lingBtn.alpha = 0;
    JNViewStyle(_lingBtn, JN_HH(15), COLOR_A1, 1);
    [self.view addSubview:_lingBtn];
    h += JN_HH(54);

    float baseView_h = JN_HH(50);
    _downY = h;
    _downView = JnUIView(CGRectMake(0, h, SCREEN_WIDTH, baseView_h * _nameArrays.count +JN_HH(10)), self.view.backgroundColor);
    [self.view addSubview:_downView];
    for (int i = 0 ; i < _nameArrays.count; i++)
    {
        BaseView * view = [[BaseView alloc]initWithFrame:CGRectMake(0,  baseView_h * i, SCREEN_WIDTH, baseView_h) leftName:_imageArrays[i] title:_nameArrays[i] rightImageName:YES];
        view.backgroundColor = COLOR_WHITE;
        view.tag = 100 + i;
        view.delegate = self;
        [view addUnderscore];
        [_downView addSubview:view];
        if ( i>= 4) {
            [view setY:[view getY] + JN_HH(10)];
        }
    }
  //  [_downView addUnderscoreWihtFrame:CGRectMake(0, baseView_h * 5, SCREEN_WIDTH, JN_HH(10))];
}



-(void)niceBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _niceField.userInteractionEnabled = YES;
        if ([_niceField canBecomeFirstResponder]) {
              [_niceField becomeFirstResponder];
        }
    }else {
        if (_niceField.text.length >= 2) {
            [Listeningkeyboard endEditing];
            _niceField.userInteractionEnabled = NO;
            [self postdownDatas:@"/user/Profile/userInfo" withdict:@{@"nickname":_niceField.text} index:1];
            self.model.nickname = _niceField.text;
        }else {
           // [MYAlertController showTitltle:@"昵称太短"];
        }
    }
}

-(void)niceImageClick
{
    [MIPickerView showWithType:0 MIPickerimage:^(UIImage * _Nonnull image) {
        [ MyNetworkingManager POST:@"user/Profile/userInfo" parameters:@{@"avatar":@"File"} image:[image scaleImagetoSize:CGSizeMake(100, 100)] progress:^(NSProgress * _Nonnull uploadProgress) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"progress is %@",uploadProgress);
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSLog(@"%@",responseObject);
            self->_niceImageView.image = image;

        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        } type:@"avatar"];
    }];
}

-(void)didView:(UIView *)view
{
    int index = (int)view.tag - 100;
    if (index < _controllerArrays.count -1)
    {
        [self popControllerwithstr:_controllerArrays[index] title:_controllerTitleArrays[index]];
    }else {
        NSLog(@"没有传入控制器值");
        [[RootViewController sharedInstance]loginOFF];
    }
}

-(void)readDowndatawithResponseDict:(NSDictionary *)responseDict index:(int)index
{
    if (index == 1) {
        [MYAlertController showTitltle:@"设置成功"];
    }else if(index == 3)
    {
        if ([responseDict[@"isreceive"] isEqualToString:@"false"]) {
            _lingNum = [responseDict[@"suger"] intValue];
            _lingBtn.alpha = 1;
            NSString * str = [NSString stringWithFormat:@"%d%@",_lingNum,BI_A0];
            [_lingquBiLabel addTextArrays:@[@"您有",str,@"尚未领取"] colorArrays:@[COLOR_BL_2,COLOR_A1,COLOR_BL_2] numArrays:@[@(15.5),@(15.5),@(15.5)] up:YES];
        }else {
            _lingBtn.alpha = 0;
            _lingquBiLabel.text = @"您已领取糖果";
        }
    }
}

-(void)downDatas
{
    [self postdownDatas:@"/user/Assets/isreceiveSuger" withdict:@{} index:3]; //获取糖果
}

-(void)lingBtnClick
{
    [MyNetworkingManager POST:@"user/Assets/receiveSuger" withparameters:@{@"cost":[NSString stringWithFormat:@"%d",_lingNum]} progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self->_lingBtn.alpha = 0;
        self->_lingquBiLabel.text = @"您已领取糖果";
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     //   [MYAlertController  showTitltle:@"领取失败"];
    }];
}


@end
