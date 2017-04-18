//
//  KCatEarVIew.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/22.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KCatEarVIew.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface KCatEarVIew()

@property (weak, nonatomic) IBOutlet UIView *playerView;
/**播放器*/
@property(nonatomic,strong) IJKFFMoviePlayerController *moviePlayer;

@end

@implementation KCatEarVIew

+(instancetype)catEarView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.playerView.layer.cornerRadius=self.playerView.height*0.5;
    self.playerView.layer.masksToBounds=YES;
}


-(void)setModel:(list *)model{
    _model=model;
 
    IJKFFOptions *option=[IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    //硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    IJKFFMoviePlayerController *moviePlayer=[[IJKFFMoviePlayerController alloc]initWithContentURLString:model.flv withOptions:option];
    moviePlayer.view.frame=self.playerView.bounds;
    moviePlayer.scalingMode=IJKMPMovieScalingModeAspectFill;
    moviePlayer.shouldAutoplay=YES;
    [self.playerView addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    self.moviePlayer=moviePlayer;
}

-(void)setListModel:(NewList *)listModel{
    _listModel=listModel;
    IJKFFOptions *option=[IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    //硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    IJKFFMoviePlayerController *moviePlayer=[[IJKFFMoviePlayerController alloc]initWithContentURLString:listModel.flv withOptions:option];
    moviePlayer.view.frame=self.playerView.bounds;
    moviePlayer.scalingMode=IJKMPMovieScalingModeAspectFill;
    moviePlayer.shouldAutoplay=YES;
    [self.playerView addSubview:moviePlayer.view];
    [moviePlayer prepareToPlay];
    self.moviePlayer=moviePlayer;
}

-(void)removeFromSuperview{
    if (_moviePlayer) {
        
        [self.moviePlayer pause];
        [self.moviePlayer stop];
        [self.moviePlayer shutdown];
        [self.moviePlayer.view removeFromSuperview];
        self.moviePlayer = nil;
        
    }
    [super removeFromSuperview];
}

@end
