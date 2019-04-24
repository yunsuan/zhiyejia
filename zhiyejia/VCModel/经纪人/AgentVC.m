//
//  AgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentVC.h"

#import "CheckAgentVC.h"
#import "CheckStoreVC.h"

#import "AgentTabCollCell.h"

@interface AgentVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic , strong) UIView *headerView;

@property (nonatomic, strong) UIView *searchBar;

@property (nonatomic, strong) CheckAgentVC *checkAgentVC;

@property (nonatomic, strong) CheckStoreVC *checkStoreVC;

@end

@implementation AgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"查看经纪人",@"查看门店"];
}

- (void)ActionSearchBtn:(UIButton *)btn{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentTabCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentTabCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AgentTabCollCell alloc] initWithFrame:CGRectMake(0, 0, 179 *SIZE, 40 *SIZE)];
    }
    
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_Width * indexPath.item, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_Width;
    [_coll selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}



- (void)initUI{
    
    self.navBackgroundView.hidden = YES;
    
    _headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, 360 *SIZE , 46*SIZE + STATUS_BAR_HEIGHT)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    
    _searchBar = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE + STATUS_BAR_HEIGHT, 340 *SIZE, 33 *SIZE)];
    _searchBar.backgroundColor = CLLineColor;
    [self.headerView addSubview:_searchBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(11 *SIZE, 11 *SIZE, 100 *SIZE, 12 *SIZE)];
    label.textColor = COLOR(147, 147, 147, 1);
    label.text = @"小区/楼盘/商铺";
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    [_searchBar addSubview:label];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(267 *SIZE, 8 *SIZE, 17 *SIZE, 17 *SIZE)];
    rightImg.image = [UIImage imageNamed:@"search_2"];
    [_searchBar addSubview:rightImg];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = _searchBar.bounds;
    [searchBtn addTarget:self action:@selector(ActionSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:searchBtn];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(179 *SIZE, 40 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46 *SIZE + STATUS_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLBackColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AgentTabCollCell class] forCellWithReuseIdentifier:@"AgentTabCollCell"];
    [self.view addSubview:_coll];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  STATUS_BAR_HEIGHT + 86 *SIZE, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - STATUS_BAR_HEIGHT - 86 *SIZE)];
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height - STATUS_BAR_HEIGHT - 86 *SIZE);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 创建控制器
    _checkAgentVC = [[CheckAgentVC alloc] init];
    _checkStoreVC = [[CheckStoreVC alloc] init];

    // 添加为self的子控制器
    [self addChildViewController:_checkAgentVC];
    [self addChildViewController:_checkStoreVC];
    
    _checkAgentVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    _checkStoreVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 1, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));

    [self.scrollView addSubview:_checkAgentVC.view];
    [self.scrollView addSubview:_checkStoreVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

@end
