//
//  HouseDemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseDemandVC.h"

#import "DropDownBtn.h"
#import "RightTextField.h"

#import "TTRangeSlider.h"

#import "GZQFlowLayout.h"

#import "BaseColorHeader.h"
#import "TitleBaseHeader.h"
#import "TagCollCell.h"

@interface HouseDemandVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseColorHeader *titleHeader;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) DropDownBtn *areaBtn;

@property (nonatomic, strong) UIView *areaLine;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) RightTextField *addressTF;

@property (nonatomic, strong) UIView *addressLine;

@property (nonatomic, strong) TitleBaseHeader *typeHeader;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *typeColl;

@property (nonatomic, strong) TitleBaseHeader *priceHeader;

@property (strong, nonatomic) TTRangeSlider *priceSlider;

@property (nonatomic, strong) TitleBaseHeader *areaHeader;

@property (strong, nonatomic) TTRangeSlider *areaSlider;

@property (nonatomic, strong) TitleBaseHeader *houseHeader;

@property (nonatomic, strong) UICollectionView *houseColl;

@property (nonatomic, strong) UIView *useView;

@property (nonatomic, strong) UILabel *buyUseL;

@property (nonatomic, strong) DropDownBtn *buyUseBtn;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation HouseDemandVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.font = FONT(12 *SIZE);
    cell.contentL.text = @"住宅";
    cell.contentView.backgroundColor = CLLineColor;
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"需求发布";
    
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLLineColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_contentView];
    
    _titleHeader = [[BaseColorHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleHeader.contentView.backgroundColor = CLLineColor;
    _titleHeader.titleL.text = @"新房-住宅";
    [_contentView addSubview:_titleHeader];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:13 *SIZE];
    _areaL.text = @"城市区域";
    [_contentView addSubview:_areaL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    _addressL.text = @"详细地址";
    [_contentView addSubview:_addressL];
    
    _areaBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 42 *SIZE)];
    _areaBtn.content.text = @"成都市青羊区";
    [_contentView addSubview:_areaBtn];
    
    _addressTF = [[RightTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 42 *SIZE)];
    _addressTF.textfield.placeholder = @"可输入详细说明  例：二环内";
    _addressTF.textfield.textAlignment = NSTextAlignmentRight;
    _addressTF.userInteractionEnabled = YES;
    _addressTF.textfield.delegate = self;
    _addressTF.textfield.userInteractionEnabled = YES;
    [_contentView addSubview:_addressTF];
 
    for (int i = 0; i < 2; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        if (i == 0) {
            
            _areaLine = line;
            [_contentView addSubview:_areaLine];
        }else{
            
            _addressLine = line;
            [_contentView addSubview:_addressLine];
        }
    }
    
    _typeHeader = [[TitleBaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _typeHeader.titleL.text = @"住宅类型";
    _typeHeader.lineView.hidden = YES;
    [_contentView addSubview:_typeHeader];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:9 *SIZE];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.sectionInset = UIEdgeInsetsMake(4 *SIZE, 10 *SIZE, 4 *SIZE, 10 *SIZE);
    
    _typeColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _typeColl.backgroundColor = CLWhiteColor;
    _typeColl.delegate = self;
    _typeColl.dataSource = self;
    [_typeColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [_contentView addSubview:_typeColl];
    
    _priceHeader = [[TitleBaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _priceHeader.titleL.text = @"意向总价";
    _priceHeader.lineView.hidden = YES;
    [_contentView addSubview:_priceHeader];
    
    _priceSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 40 *SIZE)];
    _priceSlider.minValue = 0;
    _priceSlider.maxValue = 1000;
    NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
    customFormatter.positiveSuffix = @"万";
    _priceSlider.maxFormatter = customFormatter;
    _priceSlider.minFormatter = customFormatter;
    [_contentView addSubview:_priceSlider];
    
    _areaHeader = [[TitleBaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _areaHeader.titleL.text = @"意向面积";
    _areaHeader.lineView.hidden = YES;
    [_contentView addSubview:_areaHeader];
    
    _areaSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 40 *SIZE)];
    _areaSlider.minValue = 0;
    _areaSlider.maxValue = 1000;
    NSNumberFormatter *customFormatter1 = [[NSNumberFormatter alloc] init];
    customFormatter1.positiveSuffix = @"㎡";
    _areaSlider.maxFormatter = customFormatter1;
    _areaSlider.minFormatter = customFormatter1;
    [_contentView addSubview:_areaSlider];
    
    _houseHeader = [[TitleBaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _houseHeader.titleL.text = @"意向户型";
    _houseHeader.lineView.hidden = YES;
    [_contentView addSubview:_houseHeader];
    
    _houseColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _houseColl.backgroundColor = CLWhiteColor;
    _houseColl.delegate = self;
    _houseColl.dataSource = self;
    [_houseColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [_contentView addSubview:_houseColl];
    
    _useView = [[UIView alloc] init];
    _useView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_useView];
    
    _buyUseL = [[UILabel alloc] init];
    _buyUseL.textColor = CLTitleLabColor;
    _buyUseL.font = [UIFont systemFontOfSize:13 *SIZE];
    _buyUseL.text = @"购买用途";
    [_useView addSubview:_buyUseL];
    
    _buyUseBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 42 *SIZE)];
    _buyUseBtn.content.text = @"自住";
    [_useView addSubview:_buyUseBtn];
    
    _markTV = [[UITextView alloc] init];
    [_scrollView addSubview:_markTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"发 布" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 20 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_scrollView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleHeader.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_titleHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(42 *SIZE);
    }];
    
    [_areaLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_areaBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaLine.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_areaLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(42 *SIZE);
    }];
    
    [_addressLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_addressTF.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
    }];
    
    [_typeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_typeColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_typeHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(self->_typeColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_priceHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_typeColl.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_priceSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_areaHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_priceSlider.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_areaSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_houseHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_areaSlider.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_houseColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_houseHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(self->_houseColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_contentView).offset(-26 *SIZE);
    }];
    
    [_useView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_contentView.mas_bottom).offset(5 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
//        make.bottom.equalTo(self->_scrollView).offset(-26 *SIZE);
    }];
    
    [_buyUseL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_useView).offset(10 *SIZE);
        make.top.equalTo(self->_useView).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buyUseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_useView).offset(80 *SIZE);
        make.top.equalTo(self->_useView).offset(0 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(42 *SIZE);
        make.bottom.equalTo(self->_useView.mas_bottom).offset(0 *SIZE);
    }];
    
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_useView.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scrollView).offset(20 *SIZE);
        make.top.equalTo(self->_markTV.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-35 *SIZE);
    }];
}

@end
