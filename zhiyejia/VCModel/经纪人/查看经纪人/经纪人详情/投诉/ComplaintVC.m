//
//  ComplaintVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ComplaintVC.h"

#import "AgentCustomImgCollCell.h"

@interface ComplaintVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UIView *agentView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UITextView *contentTV;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation ComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCustomImgCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentCustomImgCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AgentCustomImgCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 83 *SIZE)];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"投诉";
    
    _agentView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 73 *SIZE)];
    _agentView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_agentView];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 17 *SIZE, 342 *SIZE, 12 *SIZE)];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    _nameL.text = @"经纪人名称：张三";
    [_agentView addSubview:_nameL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 45 *SIZE, 342 *SIZE, 12 *SIZE)];
    _codeL.textColor = CLTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _codeL.text = @"云算编号：309450";
    [_agentView addSubview:_codeL];
    
    _contentTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_agentView.frame) + 4 *SIZE, 340*SIZE, 117 *SIZE)];
    _contentTV.layer.borderColor = CLContentLabColor.CGColor;
    _contentTV.layer.borderWidth = 0.5*SIZE;
    [self.view addSubview:_contentTV];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(100 *SIZE, 83 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentTV.frame), SCREEN_Width, SCREEN_Height - CGRectGetMaxY(_contentTV.frame) - 47 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = self.view.backgroundColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AgentCustomImgCollCell class] forCellWithReuseIdentifier:@"AgentCustomImgCollCell"];
    [self.view addSubview:_coll];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = CLBlueBtnColor;
//    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
////    gradientLayer0.cornerRadius = 20;
//    gradientLayer0.frame = _confirmBtn.bounds;
//    gradientLayer0.colors = @[
//                              (id)[UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor,
//                              (id)[UIColor colorWithRed:0.0f/255.0f green:172.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor];
//    gradientLayer0.locations = @[@0, @1];
//    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
//    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
//    [_confirmBtn.layer addSublayer:gradientLayer0];
//
    [self.view addSubview:_confirmBtn];
}

@end
