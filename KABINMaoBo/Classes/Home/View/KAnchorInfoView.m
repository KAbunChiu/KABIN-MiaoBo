//
//  KAnchorInfoView.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/18.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KAnchorInfoView.h"
#import <UIImageView+WebCache.h>
#import "KABINTool.h"
@interface KAnchorInfoView()
@property (weak, nonatomic) IBOutlet UIView *iconBGView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *giftView;
@property (weak, nonatomic) IBOutlet UIScrollView *peoplesScrollView;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property(nonatomic,strong) NSTimer *timer;
/**新窗口*/
@property(nonatomic,strong) UIWindow *window;
@end

@implementation KAnchorInfoView

+(instancetype)anchorInfoView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupView];
}

-(void)setupView{
    [self maskViewToBounds:self.iconBGView];
    [self maskViewToBounds:self.iconImageView];
    [self maskViewToBounds:self.giftView];
    [self maskViewToBounds:self.careButton];
    self.giftView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.3];
    self.iconBGView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.3];
    self.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    self.iconImageView.layer.borderWidth=1;
    self.iconImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    
    [self.careButton setBackgroundImage:[UIImage imageWithColor:KBasicColor size:self.careButton.size] forState:UIControlStateNormal];
    [self.careButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.careButton.size] forState:UIControlStateSelected];
    [self.careButton addTarget:self action:@selector(careClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)maskViewToBounds:(UIView *)view{
    view.layer.cornerRadius=view.height*0.5;
    view.layer.masksToBounds=YES;
}

//造假数据
static int randomNum = 0;

-(void)setModel:(list *)model{
    _model=model;
    UIColor *randomColor=KColor(arc4random()%256, arc4random()%256, arc4random()%256);
    self.nameLabel.textColor=randomColor;
    self.roomNumLabel.textColor=randomColor;
    self.numLabel.textColor=randomColor;
    [self.giftView setTitleColor:randomColor forState:UIControlStateNormal];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:nil];
    self.nameLabel.text=model.myname;
    self.numLabel.text=[NSString stringWithFormat:@"%@人",model.allnum];
    self.roomNumLabel.text=[NSString stringWithFormat:@"房间号：%@",model.roomid];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    self.iconImageView.userInteractionEnabled = YES;
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderView:)]];
}

-(void)setListModel:(NewList *)listModel{
    _listModel=listModel;
    UIColor *randomColor=KColor(arc4random()%256, arc4random()%256, arc4random()%256);
    self.nameLabel.textColor=randomColor;
    self.roomNumLabel.textColor=randomColor;
    self.numLabel.textColor=randomColor;
    [self.giftView setTitleColor:randomColor forState:UIControlStateNormal];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:listModel.photo] placeholderImage:nil];
    self.nameLabel.text=listModel.nickname;
    self.numLabel.text=[NSString stringWithFormat:@"%@人",listModel.allnum];
    self.roomNumLabel.text=[NSString stringWithFormat:@"房间号：%@",listModel.roomid];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    self.iconImageView.userInteractionEnabled = YES;
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderView:)]];
}

- (void)updateNum
{
    randomNum += arc4random_uniform(5);
    if (![self.type isEqualToString:@"最新"]) {
        self.numLabel.text = [NSString stringWithFormat:@"%ld人", [self.model.allnum integerValue] + randomNum];
        [self.giftView setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 199045 + randomNum,  124593+randomNum] forState:UIControlStateNormal];
    }else{
        self.numLabel.text = [NSString stringWithFormat:@"%ld人", [self.listModel.allnum integerValue] + randomNum];
        [self.giftView setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 199045 + randomNum,  124593+randomNum] forState:UIControlStateNormal];
    }
    
}

-(void)setFunsModel:(NSArray *)funsModel{
    _funsModel=funsModel;
    CGFloat margin=10;
    if (![self.type isEqualToString:@"最新"]) {
        self.peoplesScrollView.contentSize=CGSizeMake((50+margin)*funsModel.count, 0);
        if (self.peoplesScrollView.contentSize.width<KScrennWidth) {
            self.peoplesScrollView.contentSize=CGSizeMake(KScrennWidth, 0);
        }
        
        self.peoplesScrollView.showsVerticalScrollIndicator = NO;
        self.peoplesScrollView.showsHorizontalScrollIndicator =  NO;
        
        CGFloat x = 0;
        
        for (int i=0; i<funsModel.count; i++) {
            x=0+(margin+50)*i;
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x, 5, 50,50)];
            btn.layer.cornerRadius=50*0.5;
            btn.layer.masksToBounds=YES;
            
            //旋转
            CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            basic.toValue=@(M_PI*2);
            basic.duration=7;
            basic.repeatCount=MAXFLOAT;
            [btn.layer addAnimation:basic forKey:nil];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:[funsModel[i] bigpic]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:[UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1] forState:UIControlStateNormal];
                });
                
            }];
            
            btn.tag=i;
            [self.peoplesScrollView addSubview:btn];
        }

    }else{
        self.peoplesScrollView.contentSize=CGSizeMake((50+margin)*funsModel.count, 0);
        if (self.peoplesScrollView.contentSize.width<KScrennWidth) {
            self.peoplesScrollView.contentSize=CGSizeMake(KScrennWidth, 0);
        }
        
        self.peoplesScrollView.showsVerticalScrollIndicator = NO;
        self.peoplesScrollView.showsHorizontalScrollIndicator =  NO;
        
        CGFloat x = 0;
        
        for (int i=0; i<funsModel.count; i++) {
            x=0+(margin+50)*i;
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x, 5, 50,50)];
            btn.layer.cornerRadius=50*0.5;
            btn.layer.masksToBounds=YES;
            
            //旋转
            CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            basic.toValue=@(M_PI*2);
            basic.duration=7;
            basic.repeatCount=MAXFLOAT;
            [btn.layer addAnimation:basic forKey:nil];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:[funsModel[i] photo]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:[UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1] forState:UIControlStateNormal];
                });
                
            }];
            
            btn.tag=i;
            [self.peoplesScrollView addSubview:btn];
        }

    }
}

-(void)careClick:(UIButton *)btn{
    [KABINTool showMsg:@"关注不了哦，恐怕你看了假直播"];
}

-(void)clickHeaderView:(UITapGestureRecognizer *)tap{
    self.window=[[UIApplication sharedApplication] keyWindow];
    self.window.windowLevel=UIWindowLevelAlert;
    UIImageView *bigImg=[UIImageView new];
    [UIView animateWithDuration:1 animations:^{
        bigImg.frame=CGRectMake(0, 0, KScrennWidth, KScrennHeight);
        bigImg.image=self.iconImageView.image;
    }];
    bigImg.contentMode=UIViewContentModeScaleAspectFit;
    [self.window addSubview:bigImg];
    bigImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *hideImg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageTap:)];
    [bigImg addGestureRecognizer:hideImg];
}

-(void)hideImageTap:(UITapGestureRecognizer *)tap{
    UIImageView *image=(UIImageView*)tap.view;
    [UIView animateWithDuration:0.2 animations:^{
        [image removeFromSuperview];
    }];
}

-(void)clickBtn:(UIButton *)btn{
    self.selected(self.funsModel[btn.tag]);
}
@end
