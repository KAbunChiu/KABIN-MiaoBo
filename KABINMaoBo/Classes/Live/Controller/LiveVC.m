//
//  LiveVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/4/17.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "LiveVC.h"
#import "UIDevice+Extension.h"
#import "KABINTool.h"
#import <LFLiveKit.h>

@interface LiveVC ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beautiBtn;
@property (weak, nonatomic) IBOutlet UIButton *livingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)switchBtn:(id)sender;

- (IBAction)beginLive:(id)sender;

- (IBAction)close:(id)sender;

- (IBAction)beautiBtn:(id)sender;
/** RTMP地址 */
@property (nonatomic, copy) NSString *rtmpUrl;
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, weak) UIView *livingPreView;

@end

@implementation LiveVC

- (UIView *)livingPreView
{
    if (_livingPreView == nil) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}

- (LFLiveSession *)session
{
    if (_session == nil){
        
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration liveType:LFLiveRTMP];
         */
        
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
        
    }
    return _session;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
}


-(void)setupBasic{

    self.beautiBtn.layer.cornerRadius = self.beautiBtn.height * 0.5;
    self.beautiBtn.layer.masksToBounds = YES;
    
    self.livingBtn.backgroundColor = KBasicColor;
    self.livingBtn.layer.cornerRadius = self.livingBtn.height * 0.5;
    self.livingBtn.layer.masksToBounds = YES;
    
    self.statusLabel.numberOfLines = 0;
    
    // 默认开启前置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    
}


- (IBAction)switchBtn:(UIButton *)sender {
    
    if (![self beginClick]) return;
    
    sender.selected = !sender.selected;
    
    if (sender.selected){
        
        self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    }else{
        
        self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    }
}

- (IBAction)beginLive:(id)sender {
    if (![self beginClick]) return;
    
    self.livingBtn.selected = !self.livingBtn.selected;
    if (self.livingBtn.selected) { // 开始直播
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        
        stream.url = @"rtmp://172.100.50.106/rtmplive/room";
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    }else{ // 结束直播
        [self.session stopLive];
        self.statusLabel.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
    }
}

- (IBAction)close:(id)sender {
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)beautiBtn:(UIButton *)sender {
    if (![self beginClick]) {
        return;
    }
    sender.selected=!sender.selected;
    self.session.beautyFace=!self.session.beautyFace;
}

#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.rtmpUrl];
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}

- (BOOL)beginClick
{
    // 判断是否是模拟器
    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
        
        [KABINTool showMsg:@"请用真机进行测试, 此模块不支持模拟器测试"];
        
        return NO;
    }
    
    // 判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        [KABINTool showMsg:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
        return NO;
    }
    
    // 判断是否有摄像头权限
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        
        [KABINTool showMsg:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
        
        return NO;
    }
    
    // 开启麦克风权限
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                return YES;
            }
            else {
                [KABINTool showMsg:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                return NO;
            }
        }];
    }
    
    return YES;
}

@end

