//
//  KNewCell.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/17.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KNewCell.h"
#import <UIImageView+WebCache.h>

@interface KNewCell()
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconLabel;


@end

@implementation KNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NewList *)model{
    _model=model;
    [self.iconLabel sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    self.adressLabel.text=model.position;
    self.nameLabel.text=model.nickname;
}

@end
