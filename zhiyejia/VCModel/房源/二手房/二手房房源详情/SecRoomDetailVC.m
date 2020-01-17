//
//  SecRoomHouseDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/17.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecRoomDetailVC.h"

#import "SecRoomHouseDetailVC.h"
#import "SecRoomStoreDetailVC.h"
#import "SecRoomOfficeDetailVC.h"
#import "SecAllRoomAnalyzeVC.h"
#import "SearchResultVC.h"

#import "RoomDetailCollCell.h"

@interface SecRoomDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    
    NSArray *_titleArr;
    NSString *_houseId;
    NSString *_city;
}
@property (nonatomic, strong) UICollectionView *segmentColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SecRoomHouseDetailVC *secRoomHouseDetailVC;

@property (nonatomic, strong) SecRoomStoreDetailVC *secRoomStoreDetailVC;

@property (nonatomic, strong) SecRoomOfficeDetailVC *secRoomOfficeDetailVC;

@property (nonatomic, strong) SecAllRoomAnalyzeVC *roomAnalyzeVC;

@end

@implementation SecRoomDetailVC

- (instancetype)initWithHouseId:(NSString *)houseId city:(NSString *)city
{
    self = [super init];
    if (self) {
        
        _houseId = houseId;
        _city = city;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES]; //设置隐藏
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)ActionMaskBtn:(UIButton *)btn{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SearchResultVC class]]) {
            
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
}

- (void)initDataSource{
    
    _titleArr = @[@"房源",@"分析"];
}

- (void)ActionLeftBtn:(UIButton *)btn{
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mapViewDismiss" object:nil];
}


#pragma mark -- collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomDetailCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[RoomDetailCollCell alloc] initWithFrame:CGRectMake(0, 0, 66 *SIZE, 44)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_segmentColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}

- (void)ActionRightBtn:(UIButton *)btn{
    

}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.maskButton addTarget:self action:@selector(ActionLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBtn.hidden = YES;
//    [self.rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
//    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(66 *SIZE, 44);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _segmentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(114 *SIZE, STATUS_BAR_HEIGHT, 132 *SIZE, 44) collectionViewLayout:_flowLayout];
    _segmentColl.backgroundColor = [UIColor whiteColor];
    _segmentColl.delegate = self;
    _segmentColl.dataSource = self;
    _segmentColl.showsHorizontalScrollIndicator = NO;
    _segmentColl.bounces = NO;
    [_segmentColl registerClass:[RoomDetailCollCell class] forCellWithReuseIdentifier:@"RoomDetailCollCell"];
    [self.navBackgroundView addSubview:_segmentColl];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height - NAVIGATION_BAR_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    if (self.type == 1) {
        
        _secRoomHouseDetailVC = [[SecRoomHouseDetailVC alloc] initWithHouseId:_houseId city:_city];
//        _roomProjectVC.type =
        [self addChildViewController:_secRoomHouseDetailVC];
        
        _roomAnalyzeVC = [[SecAllRoomAnalyzeVC alloc] initWithHouseId:_houseId type:1];
    }else if (self.type == 2){
        
        _secRoomStoreDetailVC = [[SecRoomStoreDetailVC alloc] initWithHouseId:_houseId city:_city];
        [self addChildViewController:_secRoomStoreDetailVC];
        
        _roomAnalyzeVC = [[SecAllRoomAnalyzeVC alloc] initWithHouseId:_houseId type:2];
    }else{
        
        _secRoomOfficeDetailVC = [[SecRoomOfficeDetailVC alloc] initWithHouseId:_houseId city:_city];
        [self addChildViewController:_secRoomOfficeDetailVC];
        
        _roomAnalyzeVC = [[SecAllRoomAnalyzeVC alloc] initWithHouseId:_houseId type:3];
    }
    [self addChildViewController:_roomAnalyzeVC];
    
     _roomAnalyzeVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    if (self.type == 1) {
        
        _secRoomHouseDetailVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));

        [self.scrollView addSubview:_secRoomHouseDetailVC.view];
    }else if (self.type == 2){
        
        _secRoomStoreDetailVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
        
        [self.scrollView addSubview:_secRoomStoreDetailVC.view];
    }else{
        
        _secRoomOfficeDetailVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:_secRoomOfficeDetailVC.view];
    }

    [self.scrollView addSubview:_roomAnalyzeVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
