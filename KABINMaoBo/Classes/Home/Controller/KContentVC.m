//
//  KContentVC.m
//  KABINMaoBo
//
//  Created by KAbun on 17/1/16.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KContentVC.h"
#import "KHomeModel.h"
#import "KABINNetworkTool.h"
#import <MJExtension.h>
#import "KContentCell.h"
#import "KNewModel.h"
#import "KNewCell.h"
#import "KWatchVC.h"
@class list;
@interface KContentVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak)UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArrM;
@property(nonatomic,strong) NSMutableArray *NEWDataArrM;

@end

static NSString *Identifier=@"cell";

@implementation KContentVC

-(NSMutableArray *)NEWDataArrM{
    if (!_NEWDataArrM) {
        _NEWDataArrM=[NSMutableArray new];
    }
    return _NEWDataArrM;
}

-(NSMutableArray *)dataArrM{
    if (!_dataArrM) {
        _dataArrM=[NSMutableArray new];
    }
    return _dataArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupCollectionView];
    
    [self loadData];
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection=UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing=0;
    flow.minimumLineSpacing=0;
    
    UICollectionView *collection=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flow];
    collection.backgroundColor=[UIColor whiteColor];
    collection.delegate=self;
    collection.dataSource=self;
    collection.contentInset=UIEdgeInsetsMake(0, 0, 160, 0);
    [collection registerNib:[UINib nibWithNibName:@"KContentCell" bundle:nil] forCellWithReuseIdentifier:Identifier];
    [collection registerNib:[UINib nibWithNibName:@"KNewCell" bundle:nil] forCellWithReuseIdentifier:@"K"];
    [self.view addSubview:collection];
    self.collectionView=collection;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.typee isEqualToString:@"最新"]) {
        return self.NEWDataArrM.count;
    }else{
    return self.dataArrM.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typee isEqualToString:@"最新"]) {
        KNewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"K" forIndexPath:indexPath];
        cell.model=self.NEWDataArrM[indexPath.row];
        return cell;
    }else {
        KContentCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
        cell.model=self.dataArrM[indexPath.row];
        return cell;
    }
}

//4.每一个item的大小:
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.typee isEqualToString:@"最新"]) {
        return CGSizeMake(130 , 130);
    }else{
        return CGSizeMake(205, 200);
    }
}

//5.每一个item上左下右的间距:
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![self.typee isEqualToString:@"最新"]) {
        KWatchVC *playerVC=[KWatchVC new];
        playerVC.URL=[self.dataArrM[indexPath.row] flv];
        playerVC.funsArrM=self.dataArrM;
        playerVC.model=self.dataArrM[indexPath.row];
        
        [self.navigationController pushViewController:playerVC animated:YES];
    
    }else{
        KWatchVC *playerVC1=[KWatchVC new];
        playerVC1.URL=[self.NEWDataArrM[indexPath.row] flv];
        playerVC1.funsArrM=self.NEWDataArrM;
        playerVC1.listModel=self.NEWDataArrM[indexPath.row];
        [self.navigationController pushViewController:playerVC1 animated:YES];
    }
   
}
-(void)loadData{


    NSString *URL=[MBNet stringByAppendingString:self.urlStr];
    KLog(@"%@",URL);
    
    [self.dataArrM removeAllObjects];
    [self.NEWDataArrM removeAllObjects];
    [KABINNetworkTool GET:URL params:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.typee isEqualToString:@"最新"]) {
            KNewModel *model=[KNewModel mj_objectWithKeyValues:responseObject];
            for (NewList *listModel in model.data.list) {
               
                  [self.NEWDataArrM addObject:listModel];
            }
            
            }else{
                KHomeModel *model=[KHomeModel mj_objectWithKeyValues:responseObject];
                for (list *listModel in model.data.list) {
                [self.dataArrM addObject:listModel];
            }
        }
            [self.collectionView reloadData];
        
    } failuer:^(NSURLSessionDataTask *task, NSError *error) {
        
        KLog(@"error=%@",error);
    }];

}


@end
