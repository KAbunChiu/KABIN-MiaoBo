//
//  KPlayVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KPlayVC.h"
#import "KAnchorInfoView.h"
#import "KBottomToolView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "BarrageRenderer.h"
#import "NSSafeObject.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIViewController+Extension.h"
#import "KABINNetworkTool.h"
@interface KPlayVC (){
     BarrageRenderer *_renderer;
}

/**播放器*/
@property(nonatomic,strong) IJKFFMoviePlayerController *moviePlayer;
/**顶部*/
@property(nonatomic,weak) KAnchorInfoView *anchorInfoView;
/**底部*/
@property(nonatomic,weak) KBottomToolView *kBottomToolView;
/**直播前的占位图片*/
@property(nonatomic,weak) UIImageView *placeHolderView;
/**粒子动画*/
@property(nonatomic,weak) CAEmitterLayer *emitterLayer;
/**计时器*/
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,assign)BOOL Hidden;

@end

@implementation KPlayVC

-(instancetype)init{
    if (self==[super init]) {
        self.kBottomToolView.hidden=NO;
        _renderer=[[BarrageRenderer alloc]init];
        _renderer.canvasMargin=UIEdgeInsetsMake(KScrennWidth*0.3, 10, 10, 10);
        [self.view addSubview:_renderer.view];
        
        NSSafeObject    *safeObj=[[NSSafeObject alloc]initWithObject:self withSelector:@selector(autoSendBarrage)];
        
        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(excute) userInfo:nil repeats:YES];
    }
    return self;
}

-(KAnchorInfoView *)anchorInfoView{
    if (!_anchorInfoView) {
        KAnchorInfoView  *anchorView=[KAnchorInfoView anchorInfoView];
        [self.view insertSubview:anchorView aboveSubview:self.placeHolderView];
              _anchorInfoView=anchorView;
        [self.anchorInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).offset(0);
            make.height.mas_offset(190);
            make.top.equalTo(self.view).offset(0);
        }];
    }
    return _anchorInfoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  

   
}

- (void)setAllModels:(NSArray *)allModels
{
    _allModels = allModels;
    
    self.anchorInfoView.funsModel = allModels;
}

-(UIImageView *)placeHolderView{
    if (!_placeHolderView) {
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.frame=self.view.bounds;
        imageView.image=[UIImage imageNamed:@"profile_user_414x414"];
        [self.view addSubview:imageView];
        [self showGifLoding:nil inView:imageView];
        _placeHolderView=imageView;
        //强制布局
        [_placeHolderView layoutIfNeeded];
    }
    return _placeHolderView;
}

- (KBottomToolView *)kBottomToolView
{
    if (!_kBottomToolView) {
        
        self.Hidden = NO;
        
        KBottomToolView *bottomToolView = [[KBottomToolView alloc] init];
        
        __weak typeof(self) weakSekf = self;
        [bottomToolView setClickToolBlock:^(NSInteger tag) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"开启字母将会导致画面和声音不同步" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否隐藏旋转主播列表" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否向该主播送100万美金" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否隐藏猫耳窗口" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                weakSekf.Hidden = !weakSekf.Hidden;
                weakSekf.Hidden ? [_renderer start] : [_renderer stop];
                
                
            }];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                for (UIView *view in weakSekf.anchorInfoView.subviews) {
                    
                    if ([view isKindOfClass:[UIScrollView class]]){
                        
                        [UIView animateWithDuration:1 animations:^{
                            
                            view.alpha = 0;
                        }];
                        
                    }
                }
                
                
            }];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
//                [MBProgressHUD showSuccess:@"已从你账号中扣除"];
                
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [UIView animateWithDuration:1 animations:^{
                    
//                    weakSekf.catEarView.alpha = 0;
                }];
                
                
            }];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                return;
            }];
            
            [alert addAction:cancle];
            [alert addAction:action];
            [alert1 addAction:cancle];
            [alert1 addAction:action1];
            [alert2 addAction:cancle];
            [alert2 addAction:action2];
            [alert3 addAction:cancle];
            [alert3 addAction:action3];
            
            switch (tag) {
                case 0:
                    
                    if (self.Hidden){
                        
                        self.Hidden = !self.Hidden;
                        [_renderer stop];
                        
                        return;
                    }
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    break;
                case 1:
                    
                    
                    for (UIView *view in weakSekf.anchorInfoView.subviews) {
                        
                        if ([view isKindOfClass:[UIScrollView class]]){
                            
                            if (view.alpha == 0){
                                
                                [UIView animateWithDuration:1 animations:^{
                                    
                                    
                                    view.alpha = 1;
                                    
                                }];
                                
                                return;
                            }
                        }
                    }
                    
                    
                    [self presentViewController:alert1 animated:YES completion:nil];
                    break;
                    
                case 2:
                    
                    [self presentViewController:alert2 animated:YES completion:nil];
                    break;
                    
                case 3:
                    
//                    if (self.catEarView.alpha == 0){
//                        
//                        [UIView animateWithDuration:1 animations:^{
//                            
//                            self.catEarView.alpha = 1;
//                        }];
//                        
//                        return;
//                    }
//                    
//                    [self presentViewController:alert3 animated:YES completion:nil];
                    break;
                case 4:
                    
//                    [self shareMethod];
                    break;
                    
                case 5:
                    
//                    [self quit];
                    
                    break;
                default:
                    break;
            }
        }];
        
        [self.kBottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).offset(0);
            make.height.mas_offset(40);
            make.bottom.equalTo(self.view).offset(-10);
        }];

        
        [self.view insertSubview:bottomToolView aboveSubview:self.placeHolderView];
        
              _kBottomToolView = bottomToolView;
    }
    return _kBottomToolView;
}



- (CAEmitterLayer *)emitterLayer
{
    
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<10; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        [self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.anchorInfoView.layer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}


-(void)setModel:(list *)model{
    _model=model;
    self.anchorInfoView.model=model;
    
}

-(void)plarFLV:(NSString *)flv placeHolderURL:(NSString *)placeHolderURL{
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.view insertSubview:self.placeHolderView aboveSubview:self.moviePlayer.view];
        }
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer=nil;
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
        [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:placeHolderURL] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak typeof(self) weakSelf = self;
                
                if(image){
                    [weakSelf showGifLoding:nil inView:weakSelf.placeHolderView];
                    weakSelf.placeHolderView.image = [UIImage blurImage:image blur:0.8];
                }
            });

        }];
    IJKFFOptions *options=[IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviePlayer=[[IJKFFMoviePlayerController alloc]initWithContentURLString:flv withOptions:options];
//    moviePlayer.view.frame=self.view.bounds;
    [moviePlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.view).offset(0);
    }];
   
    //填充fill
    moviePlayer.scalingMode=IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay=NO;
    [self.view insertSubview:moviePlayer.view atIndex:0];
    
    [moviePlayer prepareToPlay];
    self.moviePlayer=moviePlayer;
    
    //设置监听
    [self initObserver];
    
    //开始来访动画
    [self.emitterLayer setHidden:NO];
}


- (void)initObserver
{
    [self.moviePlayer play];
    
    //    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        
        if (!self.moviePlayer.isPlaying) {
            
            [self hideGufLoding];
            
            //            [_renderer start];
            
            [self.moviePlayer play];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __weak typeof(self) weakSelf = self;
                
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                    [weakSelf.moviePlayer.view addSubview:_renderer.view];
                    
                    //显示猫耳朵
//                    weakSelf.catEarView.hidden = NO;
                }
            });
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self showGifLoding:nil inView:self.moviePlayer.view];
    }
    
    
    // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
    if (self.gifView.isAnimating) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideGufLoding];
        });
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.gifView) {
        [self showGifLoding:nil inView:self.moviePlayer.view];
        return;
    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
  
    [KABINNetworkTool GET:self.model.flv params:nil progress:nil
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      [weakSelf.moviePlayer shutdown];
                      [weakSelf.moviePlayer.view removeFromSuperview];
                      weakSelf.moviePlayer = nil;
//                      weakSelf.endView.hidden = NO;
                  } failuer:^(NSURLSessionDataTask *task, NSError *error) {
                      
                  }];
}

- (void)autoSendBarrage
{
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
    if (spriteNumber <= 50) { // 限制屏幕上的弹幕量
//        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L]];
    }
}
@end
