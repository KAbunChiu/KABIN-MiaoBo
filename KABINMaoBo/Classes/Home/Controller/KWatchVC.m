//
//  KWatchVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/20.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KWatchVC.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "KAnchorInfoView.h"
#import "BarrageRenderer.h"
#import "NSSafeObject.h"
#import <SVProgressHUD.h>
#import "KCatEarVIew.h"

@interface KWatchVC (){
     BarrageRenderer *_renderer;
}
/**播放器*/
@property(nonatomic,strong) IJKFFMoviePlayerController *moviePlayer;
/**粒子动画*/
@property(nonatomic,weak) CAEmitterLayer *emitterLayer;
/**关闭*/
@property(nonatomic,weak) UIButton *btn;
/**播放器View*/
@property(nonatomic,weak) UIView *playerView;
/**顶部视图*/
@property(nonatomic,weak)KAnchorInfoView *anchorInfoView;
/**定时器*/
@property(nonatomic,strong) NSTimer *timer;
/**小窗口*/
@property(nonatomic,strong) KCatEarVIew *catEarView;
@end

@implementation KWatchVC

-(KAnchorInfoView *)anchorInfoView{
    if (!_anchorInfoView) {
        _anchorInfoView=[KAnchorInfoView anchorInfoView];
        _anchorInfoView.frame=CGRectMake(0, 0, KScrennWidth, 190);
        [self.view addSubview:_anchorInfoView];
       
        __weak typeof(self) weakSelf = self;
       
        [_anchorInfoView setSelected:^(list *selectedModel) {
            
          
            
            [weakSelf.moviePlayer pause];
            [weakSelf.moviePlayer shutdown];
            [weakSelf.moviePlayer stop];
           
            [weakSelf.moviePlayer.view removeFromSuperview];
            weakSelf.moviePlayer=nil;
            
            [weakSelf.playerView removeFromSuperview];
            weakSelf.playerView=nil;
          
            [weakSelf setModel:selectedModel];
            weakSelf.URL=selectedModel.flv;
            [weakSelf setupMoviePlayer];
        }];
    }
    return _anchorInfoView;
}

-(KCatEarVIew *)catEarView{
    if (!_catEarView) {
        _catEarView=[KCatEarVIew catEarView];
        _catEarView.frame=CGRectMake(30, KScrennHeight-250, 100, 100);
        [self.view addSubview:_catEarView];
    }
    return _catEarView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupMoviePlayer];

}

-(void)setModel:(list *)model{
    _model=model;
    self.anchorInfoView.model=model;
    NSMutableArray *arr=[NSMutableArray new];
    for (list *listModel in self.funsArrM) {
         if (![listModel isEqual:model]) {
             [arr addObject:listModel];
        }
    }
    NSInteger num=arc4random()%arr.count;
    self.catEarView.model=arr[num];
    self.anchorInfoView.funsModel=arr;
}

-(void)setListModel:(NewList *)listModel{
    _listModel=listModel;
    self.anchorInfoView.listModel=listModel;
    self.anchorInfoView.type=@"最新";
    NSMutableArray *arr=[NSMutableArray new];
    for (list *NlistModel in self.funsArrM) {
        if (![NlistModel isEqual:listModel]) {
            [arr addObject:NlistModel];
        }
    }
    NSInteger num=arc4random()%arr.count;
    self.catEarView.listModel=arr[num];
    self.anchorInfoView.funsModel=arr;
}

-(void)setupMoviePlayer{
    [self.moviePlayer shutdown];
    self.moviePlayer=nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    IJKFFOptions *options=[IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    self.moviePlayer=[[IJKFFMoviePlayerController alloc]initWithContentURLString:self.URL withOptions:options];
    self.moviePlayer.view.frame=self.view.bounds;
    self.moviePlayer.scalingMode=IJKMPMovieScalingModeAspectFit;
    self.moviePlayer.shouldAutoplay=NO;
    
    UIView *view=[self.moviePlayer view];
    [self.view insertSubview:view atIndex:1];
    [self.moviePlayer prepareToPlay];
    self.playerView=view;
    [self initObserver];
    [self setupRenderer];
    [self setupBackBtn];
    [self setupEmitterLayer];
}



-(void)setupBackBtn{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(KScrennWidth/2-30, KScrennHeight-70, 60, 60);
    [button setImage:[UIImage imageNamed:@"user_close_15x15_"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.btn=button;
}

- (void)setupEmitterLayer{
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
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30_", i]];
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
        [self.moviePlayer.view.layer insertSublayer:emitterLayer atIndex:1];
        self.emitterLayer = emitterLayer;
}


-(void)setupRenderer{
    if (!_renderer) {
        _renderer=[[BarrageRenderer alloc]init];
        _renderer.canvasMargin=UIEdgeInsetsMake(KScrennWidth*0.5, 10, 10, 10);
        [self.view addSubview:_renderer.view];
        
        NSSafeObject *safeObj=[[NSSafeObject alloc]initWithObject:self withSelector:@selector(autoSendBarrage)];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(excute) userInfo:nil repeats:YES];
        [_renderer start];
    }
}

- (void)autoSendBarrage
{
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
    if (spriteNumber <= 50) { // 限制屏幕上的弹幕量
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L]];
    }
}

- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = self.danMuText[arc4random_uniform((uint32_t)self.danMuText.count)];
    descriptor.params[@"textColor"] = KColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"clickAction"] = ^{
        
        [SVProgressHUD showSuccessWithStatus:@"被点击了"];
        
    };
    return descriptor;
}

- (NSArray *)danMuText
{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"danmu.plist" ofType:nil]];
}

- (void)initObserver
{
    [self.moviePlayer play];
    
    //    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

-(void)didFinish{
    
}

-(void)stateDidChange{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK)!=0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
        }
    }
}

-(void)click:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.moviePlayer pause];
    [self.moviePlayer shutdown];
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer=nil;
    [_renderer stop];
    [self.timer invalidate];
    self.timer=nil;
    [self.catEarView removeFromSuperview];
    self.catEarView=nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
