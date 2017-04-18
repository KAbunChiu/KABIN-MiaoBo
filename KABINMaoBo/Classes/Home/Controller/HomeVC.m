//
//  HomeVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "HomeVC.h"
#import "HomeVC.h"
#import "KTagsButton.h"
#import "UIView+Extension.h"
#import "KContentVC.h"
#import <Masonry.h>

@interface HomeVC ()<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *titlesArrM;

//滑动条
@property(nonatomic,weak) UIView *slideView;
@property(nonatomic,strong) KTagsButton *tagsButton;
@property(nonatomic,weak) UIScrollView *tagsView;
@property(nonatomic,strong) NSMutableArray *urlArrM;
@property(nonatomic,weak) UIScrollView *contentView;
@property(nonatomic,weak) UIView *contentV;
@end

@implementation HomeVC

-(NSMutableArray *)titlesArrM{
    if (!_titlesArrM) {
        _titlesArrM=[@[@"主页",@"才艺",@"最新",@"附近",@"关注",@"海外",@"官方"]mutableCopy];
    }
    return _titlesArrM;
}


-(NSMutableArray *)urlArrM{
    if (!_urlArrM) {
        _urlArrM=[@[@"GetHotLive_v2?page=1&type=1",
                            @"GetHotLive_v2?page=1&type=3",
                            @"GetNewRoomOnline?page=1",
                            @"GetSameCity?page=1&type=2",
                            @"GetHotLive_v2?page=1&type=11",
                            @"GetHotLive_v2?page=1&type=8",
                            @"GetHotLive_v2?page=1&type=10"]mutableCopy];
    }
    return _urlArrM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTagsView];
    [self addChildVC];
    [self setupContentView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

-(void)setupTagsView{
    UIView *backgroundView=[UIView new];
    [self.view addSubview:backgroundView];
   
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).offset(0);
        make.height.mas_offset(30);
    }];
    
    
    UIScrollView *tagsView=[UIScrollView new];
    tagsView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    tagsView.delegate=self;
    tagsView.showsVerticalScrollIndicator=NO;
    tagsView.showsHorizontalScrollIndicator=NO;
    tagsView.bounces=NO;
    tagsView.frame=CGRectMake(0, 0, KScrennWidth, 30);
    tagsView.contentSize=CGSizeMake(70*self.titlesArrM.count, 0);
    [backgroundView addSubview:tagsView];
     tagsView.panGestureRecognizer.delaysTouchesBegan=YES;
    self.tagsView=tagsView;

    
    UIView *slideView=[UIView new];
    slideView.backgroundColor=KColor(215, 42, 144);
    slideView.layer.cornerRadius=2;
    self.slideView=slideView;
   
    
    for (NSInteger i=0; i<self.titlesArrM.count; i++) {
        KTagsButton *button=[self setupTagsButtonTitle:self.titlesArrM[i] andCount:i];
        if (i==0) {
            button.selected=YES;
            self.tagsButton=button;
            [button.titleLabel sizeToFit];
            self.slideView.height=2;
            self.slideView.y=button.y+28;
            self.slideView.width=button.titleLabel.frame.size.width;
            self.slideView.centerX=button.centerX;
            [self.slideView sizeToFit];
        }
    }
   
    [self.tagsView addSubview:slideView];
    
}


-(KTagsButton*)setupTagsButtonTitle:(NSString *)title andCount:(NSInteger)count{
    KTagsButton *btn=[KTagsButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame=CGRectMake(count*70, 0, 50, 30);
    [btn addTarget:self action:@selector(tagsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tagsView addSubview:btn];
    return btn;
}

-(void)tagsBtnClick:(KTagsButton*)button{
    self.tagsButton.selected=NO;
    button.selected=YES;
    self.tagsButton=button;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.slideView.height=2;
        self.slideView.y=button.y+28;
        self.slideView.width=button.titleLabel.frame.size.width;
        self.slideView.centerX=button.centerX;
        [self.slideView sizeToFit];
    }];

    int index = (int)[self.tagsView.subviews indexOfObject:button];
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:YES];
    
}

-(void)setupContentView{
    
    UIView *view=[UIView new];
    [self.view addSubview:view];
   
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.slideView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-55);
    }];
    self.contentV=view;
    
    UIScrollView *contentView=[UIScrollView new];
//    contentView.backgroundColor=[UIColor whiteColor];
    contentView.delegate=self;
    contentView.contentSize=CGSizeMake(KScrennWidth*self.urlArrM.count, 0);
    contentView.showsVerticalScrollIndicator=NO;
    contentView.showsHorizontalScrollIndicator=NO;
    contentView.panGestureRecognizer.delaysTouchesBegan=YES;
    contentView.bounces=NO;
    contentView.pagingEnabled=YES;
    [view addSubview:contentView];
    

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view).offset(0);
        make.top.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
    }];

    
    self.contentView =contentView;
    [self switchControllerIndex:0];
}



-(void)addChildVC{
    for (int i=0; i<self.urlArrM.count; i++) {
        [self setupOneChildViewControllerType:self.titlesArrM[i] andURL:self.urlArrM[i]];
    }
}

-(void)switchControllerIndex:(int)index{
    KContentVC *contentVC=self.childViewControllers[index];
    contentVC.view.y=0;
    contentVC.view.width=self.contentView.width;
    contentVC.view.height=self.contentView.height;
    contentVC.view.x=contentVC.view.width*index;
    [self.contentView addSubview:contentVC.view];
}

-(void)setupOneChildViewControllerType:(NSString *)type andURL:(NSString *)URLSTR{
    KContentVC *contentView=[KContentVC new];
    contentView.typee=type;
    contentView.urlStr=URLSTR;
    [self addChildViewController:contentView];
}

- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView{
    if (scrollView==self.contentView) {
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        [self tagsBtnClick:self.tagsView.subviews[index]];
        [self switchControllerIndex:index];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView{
    if (scrollView==self.contentView) {
        [self switchControllerIndex:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
    }
}


@end
