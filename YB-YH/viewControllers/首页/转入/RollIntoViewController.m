//
//  RollIntoViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/19.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RollIntoViewController.h"
#import "JNCoinView.h"
#import "JNCoinTriangleView.h"
#import <CoreImage/CoreImage.h>

@interface RollIntoViewController ()<JNBaseViewDelegate>
{
    UIImageView * _erImageView;
    UIImageView * _erImageView1;
    UILabel * _erLabel;
    UILabel * _dizhiLabel;
    JNCoinView * _conView;  //切换
    NSString * _address;
}
@end

@implementation RollIntoViewController

-(void)Initialize
{
    [super Initialize ];
 //   NSString * str = [NSString stringWithFormat:@"%@",self.curManager.selcurrencyModel.coin_species];
    _address = [CurrencyManager readAddressWithSpecies:[NSString stringWithFormat:@"%@",self.curManager.selcurrencyModel.coin_species]];
}

-(void)createNavView
{
    [super createNavView];
    [self.navView setcolorStyle:1];
    [self.navView removeDividingLine];

    _conView = [[JNCoinView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, CGNavView_20h(), 60, 44)];
    [self.navView addSubview:_conView];
    _conView.titleLabel.text = self.curManager.selcurrencyModel.coin_name;

    [_conView addtapGestureRecognizer:^(UIView * _Nonnull view, UIGestureRecognizer * _Nonnull tap) {
        JNCoinTriangleView * coinview =  [[JNCoinTriangleView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, self.nav_h, 90, 60)  selTitle:self.curManager.selcurrencyModel.coin_name type:2];
        coinview.delegate = self;
        [self.view.window addSubview:coinview];
    }];
}

-(void)createView
{

    [self.view addSubview:JnUIView(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), COLOR_A1)];

    UIView * wirteView = JnUIView(CGRectMake(JN_HH(15), self.nav_h + JN_HH(30), SCREEN_WIDTH - JN_HH(30), SCREEN_WIDTH +JN_HH(80)), COLOR_WHITE);
    JNViewStyle(wirteView, 10, nil, 0);
    [self.view addSubview:wirteView];
    _dizhiLabel = JnLabelType(CGRectMake(0, JN_HH(5), wirteView.width, JN_HH(25)), UILABEL_2, [NSString stringWithFormat:@"%@地址",self.curManager.selcurrencyModel.coin_name], 1);
    [wirteView addSubview:_dizhiLabel];

    _erImageView = JnImageView(CGRectMake(JN_HH(35), JN_HH(35), wirteView.width - JN_HH(70), wirteView.width - JN_HH(70)), MYimageNamed(@""));
    _erImageView.backgroundColor = COLOR_RED;
    [wirteView addSubview:_erImageView];

    _erImageView1 = JnImageView(CGRectMake(_erImageView.width / 2 - 30, _erImageView.height /2 -30, 60, 60), MYimageNamed(@"二维码G"));
    JNViewStyle(_erImageView1, 5, nil, 0);
    [_erImageView addSubview:_erImageView1];

    _erLabel = JnLabelType(CGRectMake(JN_HH(35), wirteView.width - JN_HH(35), wirteView.width - JN_HH(70), JN_HH(60)), UILABEL_2, _address, 1);
    _erLabel.numberOfLines = 0;
    [wirteView addSubview:_erLabel];

    UIButton * loginBtn = JnButtonColorIndexSize(CGRectMake(JNVIEW_X0, SCREEN_WIDTH + JN_HH(30), wirteView.width - JNVIEW_W(0), JN_HH(35)), @"复制", JN_HH(15.5), COLOR_A1, COLOR_WHITE, 1, self, @selector(fuzhiClick), 2);
    JNViewStyle(loginBtn, JN_HH(17.5), COLOR_A1, 1);
    [wirteView addSubview:loginBtn];
    [self addfilter];
}

-(void)fuzhiClick
{
    [_erLabel.text pasteboard];
    if ([[NSString readpasteboard] isEqualToString:_erLabel.text]) {
        [MYAlertController showNavViewWith:@"复制成功"];
    }
}

-(void)addfilter
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据
    NSString *string = _address;
    //将NSString格式转化成NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
   // [filter setValue:@(20) forKey:@"inputRadius"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];

    //将获取到的二维码添加到imageview上
    UIImage * imagea = [UIImage imageWithCIImage:image];
    _erImageView.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:_erImageView.size.width];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceRGB颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];

    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);

    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    return outputImage;
}


-(void)didView:(UIView *)view text:(NSString *)text
{
    if ([[view class] isEqual:[JNCoinTriangleView class]]) {
        if ( [[CurrencyManager sharedInstance] setSelBiText:text vc:self]) {
            _conView.titleLabel.text = text;
            _dizhiLabel.text = [NSString stringWithFormat:@"%@地址",self.curManager.selcurrencyModel.coin_name];
            _address = [CurrencyManager readAddressWithSpecies:[NSString stringWithFormat:@"%@",self.curManager.selcurrencyModel.coin_species]];
            _erLabel.text = _address;
            [self addfilter];
        }
    }
}

@end
