//
//  SecRoomStoreDetailHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomStoreDetailHeader.h"

#import "HeaderImgCollCell.h"

@interface SecRoomStoreDetailHeader()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    
}

@end

@implementation SecRoomStoreDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


#pragma  mark -- 点击事件 --

- (void)ActionImgBtn{
    
    //    if (self.secAllRoomDetailTableHeaderImgBlock) {
    //
    //        if (_imgArr.count) {
    //
    //            self.secAllRoomDetailTableHeaderImgBlock(_nowNum, _imgArr);
    //
    //        }
    //    }
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    
}

#pragma mark -- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeaderImgCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderImgCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[HeaderImgCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"type"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            if ([_imgArr[i][@"list"] count]) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                count = count + 1;
            }
        }
    }
    [_imgScroll setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    //    _imgScroll.backgroundColor = [UIColor blackColor];
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE, SCREEN_Width, 40 *SIZE)];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.2;
    [self.contentView addSubview:_alphaView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 17 *SIZE;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE , SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = [UIColor clearColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    
    [_imgColl registerClass:[HeaderImgCollCell class] forCellWithReuseIdentifier:@"HeaderImgCollCell"];
    [self.contentView addSubview:_imgColl];
    
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 144 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = CLTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor blackColor];
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = COLOR(64, 169, 255, 1);
    _propertyL.font = [UIFont systemFontOfSize:10 *SIZE];
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.backgroundColor = COLOR(213, 242, 255, 1);
    [self.contentView addSubview:_propertyL];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = CLContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:10 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    
    _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 249 *SIZE, SCREEN_Width, 67 *SIZE)];
    _moreView.backgroundColor = [UIColor whiteColor];
    //    NSArray *titleArr = @[@"售价",@"房型",@"产权面积"];
    NSArray *titleArr = @[@"售价",@"户型",@"产权面积"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = CLBackColor;
        if (i != 0) {
            
            [_moreView addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 13 *SIZE)];
        label.textColor = CLBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 0:
            {
                _priceL = label;
                [_moreView addSubview:_priceL];
                break;
            }
            case 1:
            {
                _typeL = label;
                [_moreView addSubview:_typeL];
                break;
            }
            case 2:
            {
                _areaL = label;
                [_moreView addSubview:_areaL];
                break;
            }
            default:
                break;
        }
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 11 *SIZE)];
        label1.textColor = CL86Color;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        switch (i) {
            case 0:
            {
                _priceTL = label1;
                [_moreView addSubview:_priceTL];
                break;
            }
            case 1:
            {
                _typeTL = label1;
                [_moreView addSubview:_typeTL];
                break;
            }
            case 2:
            {
                _areaTL = label1;
                [_moreView addSubview:_areaTL];
                break;
            }
            default:
                break;
        }
        //        [_moreView addSubview:label1];
    }
    _statusImg = [[UIImageView alloc] initWithFrame:CGRectMake(76 *SIZE, 42 *SIZE, 10 *SIZE, 10 *SIZE)];
    //    _statusImg.image = [UIImage imageNamed:@"rising"];
    [_moreView addSubview:_statusImg];
    
    [self.contentView addSubview:_moreView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(216.5 *SIZE);
        make.right.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self.contentView).offset(213.5 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        //        make.width.mas_equalTo(_attentL.mj_textWith + 6 *SIZE);
    }];
    
    [_moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_attentL.mas_bottom).offset(6 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(67 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
