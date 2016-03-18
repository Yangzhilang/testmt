//
//  MTCodeController.m
//  testmt
//
//  Created by yzl on 16/3/14.
//  Copyright © 2016年 gaowen. All rights reserved.
//

#import "MTCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface MTCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)UIImageView *scanLine;
@property(nonatomic,strong)UIImageView *borderView;

@end

@implementation MTCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn addTarget:self action:@selector(onBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [self.view addSubview:btn];

    [self initScanUI];
//    [self loadBgView];
    [self performSelector:@selector(loadScanUI) withObject:nil afterDelay:.5];
    [self loadDevice];
}

- (void)initScanUI{

    CGFloat w = kScreenWidth;
    __weak typeof(self) weakSelf = self;
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w/2, w/2));
        make.center.equalTo(weakSelf.view);
    }];

    [self.scanLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w/2, 2));
        make.top.equalTo(weakSelf.borderView);
        make.left.equalTo(weakSelf.borderView);
    }];
    self.scanLine.top = self.borderView.top;
    self.scanLine.left = self.borderView.left;

    UIImage *border = [UIImage imageNamed:@"scan_border"];
    self.borderView.image = [border resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];

    UIImage *line = [UIImage imageNamed:@"scanLine"];
    self.scanLine.image = line;
}

- (void)loadBgView{
    __weak typeof(self) weakSelf = self;

    UIImage *image =[UIImage imageWithColor:UIColorRGBA(100, 100, 100, 100)];
    image = [image imageByBlurSoft];
    UIImageView *imageV1 = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.borderView.mas_top);
        make.top.mas_equalTo(0);
    }];
//    UIImageView *imageV2 = [[UIImageView alloc] initWithImage:image];
//    UIImageView *imageV3 = [[UIImageView alloc] initWithImage:image];
//    UIImageView *imageV4 = [[UIImageView alloc] initWithImage:image];

}

- (void)loadScanUI{
//    __weak typeof(self) weakSelf = self;
//    [self.view layoutIfNeeded];
//    [UIView animateWithDuration:6 animations:^{
//        [self.scanLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(150, 2));
//            make.left.equalTo(weakSelf.borderView);
//            make.top.equalTo(weakSelf.borderView.mas_bottom).with.offset(-2);
//        }];
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        if (finished) {
//            DDLogDebug(@"finished");
//        }
//    }];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.duration= 3;
    anim.autoreverses = YES;
    anim.byValue = @(kScreenWidth/2-2);
    anim.repeatCount = MAXFLOAT;
    [self.scanLine.layer addAnimation:anim forKey:@"scan"];
}

- (void)loadDevice{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        DDLogError(@"%@",error);
        return;
    }
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session addInput:input];
    [self.session addOutput:output];
    output.rectOfInterest = CGRectMake(.5, 0, .5, 1);
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];

    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)test{
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    view1.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view1];
//
//    CGRect frame = view1.frame;
//    frame.origin.y += 150;
//    [UIView animateWithDuration:3 animations:^{
//        view1.frame = frame;
//    }];
//}

- (void)onBtnTouched{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (!metadataObjects.count) {
        return;
    }

    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
    //输出扫描字符串
    DDLogDebug(@"%@",metadataObject.stringValue);
    [self.session stopRunning];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView*)scanLine{
    if (!_scanLine) {
        _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 2)];
        [self.view addSubview:_scanLine];
    }
    return _scanLine;
}

- (UIImageView*)borderView{
    if (!_borderView) {
        _borderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [self.view addSubview:_borderView];
    }
    return _borderView;
}

@end
