//
//  MainNavigationVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "MainNavigationVC.h"
#import "UIBarButtonItem+KABIN.h"
@interface MainNavigationVC ()

@end

@implementation MainNavigationVC

+(void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed=YES;
    
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:@"back_9x16" highlightImage:nil targer:self action:@selector(back)];
   
        __weak typeof(viewController)WeakSelf=viewController;
        self.interactivePopGestureRecognizer.delegate=(id)WeakSelf;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

@end
