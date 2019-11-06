//
//  FBHRichScanController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHRichScanController.h"

@interface FBHRichScanController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic)UIView * NavView;

/** 扫描器 */
@property (nonatomic, strong) SWScannerView *scannerView;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation FBHRichScanController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self resumeScanning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.scannerView sw_setFlashlightOn:NO];
    [self.scannerView sw_hideFlashlightWithAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
    [self createUI];
    //    self.navigationItem.title = [SWQRCodeManager sw_navigationItemTitleWithType:self.codeConfig.scannerType];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = UIColorFromRGBA(0x000000, 0.35);
    //    NavView.backgroundColor = [UIColor clearColor];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 160, 44)];
    navLabel.text = @"扫一扫";
    navLabel.textColor = UIColorFromRGB(0xFFFFFF);
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.font = NavTitleFont;
    navLabel.centerX = NavView.centerX;
    [NavView addSubview:navLabel];
    
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW-85, STATUS_BAR_HEIGHT, 80, 44)];
    [leftbutton setTitle:@"券码验证" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    //    self.navigationItem.rightBarButtonItem=rightitem;
    
    UIButton *righbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 60, 44)];
    //    [righbutton setTitle:@"返回" forState:UIControlStateNormal];
    [righbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [righbutton setImage:[UIImage imageNamed:@"icn_nav_back_white_normal"] forState:UIControlStateNormal];
    righbutton.layer.cornerRadius = 14;
    [righbutton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    [NavView addSubview:righbutton];
    [NavView addSubview:leftbutton];
    [self.view addSubview:NavView];
    
}
-(void)RighAction{
    [self.navigationController pushViewController:[FBHbondViewController new] animated:NO];
}
-(void)leftAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.scannerView];
    
    // 校验相机权限
    [SWQRCodeManager sw_checkCameraAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupScanner];
            });
        }
    }];
    
    
    UIView *bomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH - (kIs_iPhoneX ? 200:140), ScreenW, 160)];
    bomView.backgroundColor = UIColorFromRGBA(0x000000, 0.35);
    [self.view addSubview:bomView];
    FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(0, 15, bomView.width/2, bomView.height/2);
    [thirdBtn setImage:[UIImage imageNamed:@"icn_san_openalbum"] forState:UIControlStateNormal];
    [thirdBtn setTitle:[NSString stringWithFormat:@"相册"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    //样式
    thirdBtn.status = FLAlignmentStatusTop;
    thirdBtn.fl_padding = 10;
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bomView addSubview:thirdBtn];
    [thirdBtn addTarget:self action:@selector(showAlbum) forControlEvents:UIControlEventTouchUpInside];
    
    
    FL_Button *thirdBtn1 = [FL_Button buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(bomView.width/2, 15, bomView.width/2, bomView.height/2);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_san_openflash"] forState:UIControlStateNormal];
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_san_openflash_pressed"] forState:UIControlStateSelected];
    [thirdBtn1 setTitle:[NSString stringWithFormat:@"闪光灯"] forState:UIControlStateNormal];
    [thirdBtn1 setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    //样式
    thirdBtn1.status = FLAlignmentStatusTop;
    thirdBtn1.fl_padding = 10;
    thirdBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [bomView addSubview:thirdBtn1];
    [thirdBtn1 addTarget:self action:@selector(FlashlightOn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupNav];
    
}
/** 开关手电筒*/
-(void)FlashlightOn:(UIButton *)Btn{
    Btn.selected = !Btn.selected;
    if (Btn.selected == YES) {
        [self.scannerView sw_setFlashlightOn:YES];
    }else{
        [self.scannerView sw_setFlashlightOn:NO];
    }
    
}
/** 创建扫描器 */
- (void)setupScanner {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if (self.codeConfig.scannerArea == SWScannerAreaDefault) {
        metadataOutput.rectOfInterest = CGRectMake([self.scannerView scanner_y]/self.view.frame.size.height, [self.scannerView scanner_x]/self.view.frame.size.width, [self.scannerView scanner_width]/self.view.frame.size.height, [self.scannerView scanner_width]/self.view.frame.size.width);
    }
    
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:deviceInput]) {
        [self.session addInput:deviceInput];
    }
    if ([self.session canAddOutput:metadataOutput]) {
        [self.session addOutput:metadataOutput];
    }
    if ([self.session canAddOutput:videoDataOutput]) {
        [self.session addOutput:videoDataOutput];
    }
    
    
    
    metadataOutput.metadataObjectTypes = [SWQRCodeManager sw_metadataObjectTypesWithType:self.codeConfig.scannerType];
    
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    videoPreviewLayer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:videoPreviewLayer atIndex:0];
    
    [self.session startRunning];
}
#pragma mark -- AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // 获取扫一扫结果
    if (metadataObjects && metadataObjects.count > 0) {
        
        [self pauseScanning];
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *stringValue = metadataObject.stringValue;
        
        [self sw_handleWithValue:stringValue];
    }
}
#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
/** 此方法会实时监听亮度值 */
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    
    // 亮度值
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    if (![self.scannerView sw_flashlightOn]) {
        if (brightnessValue < -4.0) {
            [self.scannerView sw_showFlashlightWithAnimated:YES];
        }else
        {
            [self.scannerView sw_hideFlashlightWithAnimated:YES];
        }
    }
}
- (void)showAlbum {
    // 校验相册权限
    [SWQRCodeManager sw_checkAlbumAuthorizationStatusWithGrand:^(BOOL granted) {
        if (granted) {
            [self imagePicker];
        }
    }];
}

#pragma mark -- 跳转相册
- (void)imagePicker {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    // 获取选择图片中识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(pickImage)]];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (features.count > 0) {
            CIQRCodeFeature *feature = features[0];
            NSString *stringValue = feature.messageString;
            [self sw_handleWithValue:stringValue];
        }
        else {
            [self sw_didReadFromAlbumFailed];
        }
    }];
}

#pragma mark -- App 从后台进入前台
- (void)appDidBecomeActive:(NSNotification *)notify {
    [self resumeScanning];
}
#pragma mark -- App 从前台进入后台
- (void)appWillResignActive:(NSNotification *)notify {
    [self pauseScanning];
}

/** 恢复扫一扫功能 */
- (void)resumeScanning {
    if (self.session) {
        [self.session startRunning];
        [self.scannerView sw_addScannerLineAnimation];
    }
}


/** 暂停扫一扫功能 */
- (void)pauseScanning {
    if (self.session) {
        [self.session stopRunning];
        [self.scannerView sw_pauseScannerLineAnimation];
    }
}
#pragma mark -- 扫一扫API
/**
 处理扫一扫结果
 @param value 扫描结果
 */
- (void)sw_handleWithValue:(NSString *)value {
    NSLog(@"sw_handleWithValue === %@", value);
    
    
    NSLog(@"扫描后得到的结果。 === %@",value);
    [self use_order_code:value];
}

/**
 相册选取图片无法读取数据
 */
- (void)sw_didReadFromAlbumFailed {
    NSLog(@"sw_didReadFromAlbumFailed");
}


#pragma mark - 请求扫描后的结果
-(void)use_order_code:(NSString *)parameter{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]use_order_code:model.merchant_id andstore_id:model.store_id andparameter:parameter Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1){
            
            NSString *order_idString = [NSString stringWithFormat:@"%@",resDic[@"data"][@"order_id"]];
            
            bondPromptView *tipView = [[NSBundle mainBundle] loadNibNamed:@"bondPromptView" owner:self options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            //    tipView.promptImage.image = [UIImage imageNamed:@"icn_failure"];
            //    tipView.proptLabel.text = @"验证失败";
            [self.view.window addSubview:tipView];
            
            tipView.bondBlock = ^{
               FBHaccomplishController *VC = [FBHaccomplishController new];
                VC.order_id = order_idString;
                [self.navigationController pushViewController:VC animated:NO];
            };
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            [self resumeScanning];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
    
}


#pragma mark --- 懒加载 ---
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SWScannerView *)scannerView
{
    if (!_scannerView) {
        
        _scannerView = [[SWScannerView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) config:_codeConfig];
        //扫描线
        _scannerView.scannerLine.image = [UIImage imageNamed:@"icn_scan_flash"];
        
    }
    return _scannerView;
}

@end
