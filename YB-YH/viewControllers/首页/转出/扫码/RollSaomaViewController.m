//
//  RollSaomaViewController.m
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "RollSaomaViewController.h"
#import "MIPickerimage.h"

@interface RollSaomaViewController ()
{
    BOOL _isrun;
}
//扫描线
@property(nonatomic,retain)UIImageView *saomiaoxian;
@property(nonatomic,retain)NSTimer *SaoTimer;

@property(nonatomic,retain)UIView *SaomiaoView;

@end

@implementation RollSaomaViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startTimer];
    [_session startRunning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_session stopRunning];
    [self stopTimer];
}

-(void)Initialize
{
    [super Initialize  ];
    _isrun = NO;
}

-(void)createNavView
{
    [super createNavView];
    [self.navView setStyle:2];
    [self.navView.rightButton setBackgroundImage:nil forState:0];
    [self.navView.rightButton setTitle:@"相册" forState:0];
    self.navView.backgroundColor = [self.navView.backgroundColor colorWithAlphaComponent:0.7];
}

-(void)createView{
    // self.view.backgroundColor=[UIColor whiteColor];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    //增加条形码扫描
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                    AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode128Code,
                                    AVMetadataObjectTypeQRCode];
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.backgroundColor=[UIColor redColor].CGColor;

    _preview.frame =CGRectMake(0, self.nav_h, SCREEN_WIDTH , SCREEN_HEIGHT - self.nav_h);
    [self.view.layer insertSublayer:_preview atIndex:0];
    CGSize size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-self.nav_h);
    CGRect cropRect = CGRectMake(80, 100, SCREEN_WIDTH-160  , SCREEN_WIDTH-160);
    CGRect cropRect1= CGRectMake(80, 100+self.nav_h, SCREEN_WIDTH- 160  , SCREEN_WIDTH-160);

    //设置扫描的范围
    _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                        cropRect.origin.x/size.width,
                                        cropRect.size.height/size.height,
                                        cropRect.size.width/size.width);

    [_session startRunning];

    //添加框框
    _SaomiaoView=[self createViewWithFrame:cropRect1];
    [self.view addSubview:_SaomiaoView];

    [self.view addSubview:JnLabel(CGRectMake(0, 130+self.nav_h +cropRect.size.width, SCREEN_WIDTH, JN_HH(20)), @"将二维码方法框内,自动扫描", JN_HH(14.5), COLOR_A3, 1)];

}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        [_SaoTimer setFireDate:[NSDate distantFuture]];
        _saomiaoxian.alpha=0;
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //长传数据
        if ([_delegate respondsToSelector:@selector(RollSaomaViewController:stringValue:)]) {
            [_delegate RollSaomaViewController:self stringValue:stringValue];
            FANHUI_JIUSHITU ; 
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView * )createViewWithFrame:(CGRect )Frame{
    UIView  *MyView=[[UIView  alloc]initWithFrame:Frame];
    JNViewStyle(MyView, 0, COLOR_A1, 1);
    MyView.backgroundColor=[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:0.1];
    //4条边
    CGFloat bian=20;  UIColor *color = COLOR_A1; CGFloat kuan=5;
    CGFloat wwww=MyView.bounds.size.width; CGFloat hhhh=MyView.bounds.size.height;
    //左上角
    [MyView addSubview:JnUIView(CGRectMake(0, 0, bian, kuan), color)];
    [MyView addSubview:JnUIView(CGRectMake(0, 0, kuan, bian), color)];
    //右上角
    [MyView addSubview:JnUIView(CGRectMake(wwww-bian, 0, bian, kuan), color)];
    [MyView addSubview:JnUIView(CGRectMake(wwww-kuan, 0, kuan, bian), color)];
    //左下角
    [MyView addSubview:JnUIView(CGRectMake(0, hhhh-kuan, bian, kuan), color)];
    [MyView addSubview:JnUIView(CGRectMake(0, hhhh-bian, kuan, bian), color)];

    //右下角
    [MyView addSubview:JnUIView(CGRectMake(wwww-bian, hhhh-kuan, bian, kuan), color)];
    [MyView addSubview:JnUIView(CGRectMake(wwww-kuan, hhhh-bian, kuan, bian), color)];


    //扫描线
    _saomiaoxian = JnImageView(CGRectMake(0, 0, wwww, 10), MYimageNamed(@"zc_saoma"));
    [MyView addSubview:_saomiaoxian];
    return MyView;
}
-(void)timer{
    CGRect Frame=_saomiaoxian.frame;
    CGFloat yidong = 5;
    if (Frame.origin.y<_SaomiaoView.bounds.size.height-yidong-Frame.size.height) {
        Frame.origin.y += yidong;
        [UIView animateWithDuration:0.09 animations:^{
            self.saomiaoxian.frame=Frame;
        }];
    }else {
        Frame.origin.y=0;
        _saomiaoxian.frame=Frame;
    }
}

-(void)clickRightButton:(UIButton *)rightBtn
{
    _isrun = YES ;
    JNWeakSelf(self);
    [[MIPickerimage sharedInstance] PickerpushWithscurceType:UIImagePickerControllerSourceTypePhotoLibrary MIPickerimage:^(UIImage * _Nonnull image) {
        if (image) {
            self->_isrun = NO;
            [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"识别中" Style:0 vc:weakself];
            if ([image codeIdentify].length > 0) {
                [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"识别中" Style:5 vc:weakself];
            }else {
                 self->_isrun = YES;
                [MyActivityIndicatorViewManager showActivityIndicatorViewWithName:@"识别中" Style:5 vc:weakself];
                [MYAlertController showTitltle:@"没有识别到图片中二维码" vc:weakself];
            }
        }
    }];
}

-(void)stopTimer
{
    [_SaoTimer invalidate]; // 销毁timer
    _SaoTimer = nil; // 置nil
}

-(void)startTimer{
    if (!_SaoTimer) {
        _SaoTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    }
    [_SaoTimer setFireDate:[NSDate distantPast]];
}



@end
