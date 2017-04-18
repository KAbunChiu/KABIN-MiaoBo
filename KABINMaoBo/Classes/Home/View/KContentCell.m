//
//  KContentCell.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/16.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KContentCell.h"
#import <UIImageView+WebCache.h>

@interface KContentCell()
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
@implementation KContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

-(void)setModel:(list *)model{
    _model=model;
    self.roomLabel.text=model.familyName;
    self.nameLabel.text=model.myname;
    self.countLabel.text=[NSString stringWithFormat:@"%@人",model.allnum];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"200.png"]];
}

@end
