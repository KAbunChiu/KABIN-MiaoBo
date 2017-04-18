//
//  MainTabBarVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/12.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "MainTabBarVC.h"
#import "MainNavigationVC.h"
#import "HomeVC.h"
#import "LiveVC.h"
#import "MeVC.h"

@interface MainTabBarVC ()<UITabBarControllerDelegate>

@property(nonatomic,strong) NSMutableArray *ImageArrM;

@property(nonatomic,strong) NSMutableArray *selectedArrM;

@property(nonatomic,strong) NSMutableArray *classArrM;

@property(nonatomic,strong) NSMutableArray *titleArrM;

@end

@implementation MainTabBarVC

-(NSMutableArray *)ImageArrM{
    if (!_ImageArrM) {
        _ImageArrM=[@[@"toolbar_home",@"toolbar_live",@"toolbar_me"]mutableCopy];
    }
    return _ImageArrM;
}

-(NSMutableArray *)selectedArrM{
    if (!_selectedArrM) {
        _selectedArrM=[@[@"toolbar_home_sel",@"",@"toolbar_me_sel"]mutableCopy];
    }
    return _selectedArrM;
}

-(NSMutableArray *)classArrM{
    if (!_classArrM) {
        _classArrM=[@[[HomeVC new],[[LiveVC alloc]init],[MeVC new]]mutableCopy];
    }
    return _classArrM;
}

-(NSMutableArray *)titleArrM{
    if (!_titleArrM) {
        _titleArrM=[@[@"个人中心",@"",@"我的"]mutableCopy];
    }
    return _titleArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    [self setupChildVC];
}


-(void)setupChildVC{
    for (int i=0; i<3; i++) {
        [self setupOneChildViewController:self.classArrM[i] title:self.titleArrM[i] image:self.ImageArrM[i] selectedImage:self.selectedArrM[i] indexNum:i];
    }
}


- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage indexNum:(int)indexNum{
    if (indexNum==1) {
        vc.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    }
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MainNavigationVC *nvc=[[MainNavigationVC alloc]initWithRootViewController:vc];
    nvc.navigationBar.translucent=NO;
    [self addChildViewController:nvc];
}
@end
