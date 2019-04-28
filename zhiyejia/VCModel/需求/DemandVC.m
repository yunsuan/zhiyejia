//
//  DemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandVC.h"

#import "DemandListVC.h"

#import "HouseDemandVC.h"
#import "OfficeDemandVC.h"
#import "StoreDemandVC.h"

//租房
#import "RentHouseDemandVC.h"
#import "RentStoreDemandVC.h"
#import "RentOfficeDemandVC.h"

#import "DemandTypeHeader.h"
#import "DemandTakeCollCell.h"
#import "DemandTypeCollCell.h"

@interface DemandVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;
@end

@implementation DemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeZero;
    }else{
        
        return CGSizeMake(SCREEN_Width, 41 *SIZE);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    DemandTypeHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DemandTypeHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[DemandTypeHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 41 *SIZE)];
    }
    
    return header;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (@available(iOS 10.0, *)) {
//
//        return UICollectionViewFlowLayoutAutomaticSize;
//    } else {
//
//        if (indexPath.section == 0) {
//
//
//        }
//    }
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        DemandTakeCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemandTakeCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[DemandTakeCollCell alloc] initWithFrame:CGRectMake(0, 0, 333 *SIZE, 93 *SIZE)];
        }
        
        return cell;
    }else{
        
        DemandTypeCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemandTypeCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[DemandTypeCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 67 *SIZE)];
        }
        
        cell.tag = indexPath.item;
        cell.demandTypeCollCellBlock = ^(NSInteger idx) {
          
            if (idx == 0) {
                
                HouseDemandVC *nextVC = [[HouseDemandVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if (idx == 1){
                
                RentStoreDemandVC *nextVC = [[RentStoreDemandVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                OfficeDemandVC *nextVC = [[OfficeDemandVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        
    }else{
        
        DemandListVC *nextVC = [[DemandListVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"需求";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (@available(iOS 10.0, *)) {
        _flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    } else {
        // Fallback on earlier versions
    }
    _flowLayout.estimatedItemSize = CGSizeMake(333 *SIZE, 93 *SIZE);
    _flowLayout.sectionInset =UIEdgeInsetsMake(5 *SIZE, 13 *SIZE, 5 *SIZE, 13 *SIZE);
    
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLLineColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[DemandTakeCollCell class] forCellWithReuseIdentifier:@"DemandTakeCollCell"];
    [_coll registerClass:[DemandTypeCollCell class] forCellWithReuseIdentifier:@"DemandTypeCollCell"];
    [_coll registerClass:[DemandTypeHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DemandTypeHeader"];
    [self.view addSubview:_coll];
}


@end
