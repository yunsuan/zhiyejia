//
//  SecHouseBuyOfficeDemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/2/11.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyOfficeDemandVC.h"

#import "DropDownBtn.h"
#import "DropDownBtn2.h"
#import "BorderTextField.h"
#import "RightTextField.h"
#import "SinglePickView.h"

#import "BaseColorHeader.h"

@interface SecHouseBuyOfficeDemandVC ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    
    NSMutableArray *_cityArr;
    NSMutableArray *_districtArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseColorHeader *titleHeader;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) DropDownBtn2 *areaBtn;

@property (nonatomic, strong) UIView *areaLine;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) RightTextField *addressTF;

@property (nonatomic, strong) UIView *addressLine;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *priceHeader;

@property (nonatomic, strong) BorderTextField *minPriceTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *maxPriceTF;

@property (nonatomic, strong) UILabel *areaHeader;

@property (nonatomic, strong) BorderTextField *minAreaTF;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) BorderTextField *maxAreaTF;

@property (nonatomic, strong) UILabel *buyUseL;

@property (nonatomic, strong) DropDownBtn *buyUseBtn;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) DropDownBtn *yearBtn;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation SecHouseBuyOfficeDemandVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _cityArr = [@[] mutableCopy];
    _districtArr = [@[] mutableCopy];
}

- (void)ActionCityBtn:(UIButton *)btn{
    
    if (!self->_cityArr.count) {
    
        [BaseRequest GET:ForunOpenCityList_URL parameters:@{} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                    
                    [self->_cityArr addObject:@{@"param":resposeObject[@"data"][i][@"city_name"],@"id":resposeObject[@"data"][i][@"city_code"]}];
                }
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_cityArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {

                    self->_areaBtn.content.text = @"";
                    self->_areaBtn->str = @"";
                    self->_areaBtn.content.text = [NSString stringWithFormat:@"%@不限",MC];
                    self->_areaBtn->str = [NSString stringWithFormat:@"%@",ID];
                    [self DistrictRequest:[NSString stringWithFormat:@"%@",ID]];
                    self->_areaBtn->str = [NSString stringWithFormat:@"%@,0",ID];
                };
                [self.view addSubview:view];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_cityArr];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {

            self->_areaBtn.content.text = @"";
            self->_areaBtn->str = @"";
            self->_areaBtn.content.text = [NSString stringWithFormat:@"%@不限",MC];
            self->_areaBtn->str = [NSString stringWithFormat:@"%@",ID];
            [self DistrictRequest:[NSString stringWithFormat:@"%@",ID]];
            self->_areaBtn->str = [NSString stringWithFormat:@"%@,0",ID];
        };
        [self.view addSubview:view];
    }
}

- (void)DistrictRequest:(NSString *)str{
    
    [BaseRequest GET:ForumOpenDistrictList_URL parameters:@{@"city":self->_areaBtn->str} success:^(id resposeObject) {
        
        [self->_districtArr removeAllObjects];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_districtArr addObject:@{@"param":resposeObject[@"data"][i][@"name"],@"id":resposeObject[@"data"][i][@"code"]}];
            }
            [self->_districtArr insertObject:@{@"param":@"不限",@"id":@"0"} atIndex:0];
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_districtArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_areaBtn.content.text = [NSString stringWithFormat:@"%@%@",[self->_areaBtn.content.text substringToIndex:self->_areaBtn.content.text.length - 2],MC];
                self->_areaBtn->str = [NSString stringWithFormat:@"%@,%@",[self->_areaBtn->str componentsSeparatedByString:@","][0],ID];
            };
            [self.view addSubview:view];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionUseBtn:(UIButton *)btn{
    
    
}

- (void)ActionDecorateBtn:(UIButton *)btn{
    
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if ([[_areaBtn->str componentsSeparatedByString:@","] count] < 2) {
        
        [self showContent:@"请选择城市区域"];
        return;
    }
    
//    if (!_minPriceTF.textfield.text.length) {
//
//        [self showContent:@"请输入最低价格"];
//        return;
//    }
//
//    if (!_maxPriceTF.textfield.text.length) {
//
//        [self showContent:@"请输入最高价格"];
//        return;
//    }
//
//    if (!_minAreaTF.textfield.text.length) {
//
//        [self showContent:@"请输入最低面积"];
//        return;
//    }
//
//    if (!_maxAreaTF.textfield.text.length) {
//
//        [self showContent:@"请输入最大价格"];
//        return;
//    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[_areaBtn->str componentsSeparatedByString:@","][0] forKey:@"recommend_city"];
    [dic setValue:[_areaBtn->str componentsSeparatedByString:@","][1] forKey:@"recommend_district"];
    [dic setValue:@"1" forKey:@"type"];
    [dic setValue:@"3" forKey:@"property_type"];
    if (_minPriceTF.textfield.text.length) {
        
        [dic setValue:[NSString stringWithFormat:@"%@",_minPriceTF.textfield.text] forKey:@"price_min"];
    }else{
        
        [dic setValue:@" " forKey:@"price_min"];
    }
    
    if (_maxPriceTF.textfield.text.length) {
        
        [dic setValue:[NSString stringWithFormat:@"%@",_maxPriceTF.textfield.text] forKey:@"price_max"];
    }else{
        
        [dic setValue:@" " forKey:@"price_max"];
    }
    
    if (_minAreaTF.textfield.text.length) {
        
        [dic setValue:[NSString stringWithFormat:@"%@",_minAreaTF.textfield.text] forKey:@"area_min"];
    }else{
        
        [dic setValue:@" " forKey:@"area_min"];
    }
    
    if (_maxAreaTF.textfield.text.length) {
        
        [dic setValue:[NSString stringWithFormat:@"%@",_maxAreaTF.textfield.text] forKey:@"area_max"];
    }else{
        
        [dic setValue:@" " forKey:@"area_max"];
    }
    if (_addressTF.textfield.text.length) {
        
        [dic setValue:_addressTF.textfield.text forKey:@"need_address"];
    }
    if (_markTV.text.length) {
        
        [dic setValue:_markTV.text forKey:@"comment"];
    }
    
    [BaseRequest POST:NeedBuyAdd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self showContent:@"发布成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.secHouseBuyOfficeDemandVCBlock) {
                    
                    self.secHouseBuyOfficeDemandVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _markL.hidden = YES;
    }else{
        
        _markL.hidden = NO;
    }
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
    _titleHeader.titleL.text = @"二手房";
    _titleHeader.titleL.text = [NSString stringWithFormat:@"%@-写字楼",_titleHeader.titleL.text];
    [_contentView addSubview:_titleHeader];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:13 *SIZE];
    _areaL.text = @"意向区域";
    [_contentView addSubview:_areaL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLTitleLabColor;
    _addressL.font = [UIFont systemFontOfSize:13 *SIZE];
    _addressL.text = @"详细地址";
    [_contentView addSubview:_addressL];
    
    _areaBtn = [[DropDownBtn2 alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 42 *SIZE)];
    [_areaBtn addTarget:self action:@selector(ActionCityBtn:) forControlEvents:UIControlEventTouchUpInside];
//    _areaBtn.content.text = @"成都市青羊区";
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
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:9 *SIZE];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.sectionInset = UIEdgeInsetsMake(4 *SIZE, 10 *SIZE, 4 *SIZE, 10 *SIZE);
    
//    _priceHeader = [[TitleBaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
//    _priceHeader.titleL.text = @"意向总价";
//    _priceHeader.lineView.hidden = YES;
    _priceHeader = [[UILabel alloc] init];
    _priceHeader.textColor = CLTitleLabColor;
    _priceHeader.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceHeader.text = @"意向总价";
    [_contentView addSubview:_priceHeader];
    
    _minPriceTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
    _minPriceTF.textfield.delegate = self;
    _minPriceTF.unitL.text = @"万";
    _minPriceTF.textfield.textAlignment = NSTextAlignmentLeft;
    _minPriceTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
    [_contentView addSubview:_minPriceTF];
    
    _maxPriceTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
    _maxPriceTF.textfield.delegate = self;
    _maxPriceTF.unitL.text = @"万";
    _maxPriceTF.textfield.textAlignment = NSTextAlignmentLeft;
    _maxPriceTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
    [_contentView addSubview:_maxPriceTF];
    
    
    _minAreaTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
    _minAreaTF.textfield.delegate = self;
    _minAreaTF.unitL.text = @"㎡";
    _minAreaTF.textfield.textAlignment = NSTextAlignmentLeft;
    _minAreaTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
    [_contentView addSubview:_minAreaTF];
    
    
    _maxAreaTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 33 *SIZE)];
    _maxAreaTF.textfield.delegate = self;
    _maxAreaTF.unitL.text = @"㎡";
    _maxAreaTF.textfield.textAlignment = NSTextAlignmentLeft;
    _maxAreaTF.textfield.keyboardType = UIKeyboardTypeNumberPad;
    [_contentView addSubview:_maxAreaTF];
    
    _areaHeader = [[UILabel alloc] init];
    _areaHeader.textColor = CLTitleLabColor;
    _areaHeader.font = [UIFont systemFontOfSize:13 *SIZE];
    _areaHeader.text = @"意向面积";
    [_contentView addSubview:_areaHeader];
    
    _buyUseL = [[UILabel alloc] init];
    _buyUseL.textColor = CLTitleLabColor;
    _buyUseL.font = [UIFont systemFontOfSize:13 *SIZE];
    _buyUseL.text = @"购买用途";
    [_contentView addSubview:_buyUseL];

    _buyUseBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 33 *SIZE)];
    [_buyUseBtn addTarget:self action:@selector(ActionUseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_buyUseBtn];
    
    _yearL = [[UILabel alloc] init];
    _yearL.textColor = CLTitleLabColor;
    _yearL.font = [UIFont systemFontOfSize:13 *SIZE];
    _yearL.text = @"已使用年限";
    [_contentView addSubview:_yearL];

    _yearBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 270 *SIZE, 33 *SIZE)];
    [_yearBtn addTarget:self action:@selector(ActionDecorateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_yearBtn];
    
    _markTV = [[UITextView alloc] init];
    _markTV.delegate = self;
    [_scrollView addSubview:_markTV];
    
    _markL = [[UILabel alloc] init];
    _markL.textColor = CLContentLabColor;
    _markL.font = [UIFont systemFontOfSize:13 *SIZE];
    _markL.text = @"补充说明";
    [_markTV addSubview:_markL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.text = @"至";
    [_contentView addSubview:_priceL];
    
    _placeL = [[UILabel alloc] init];
    _placeL.textColor = CLTitleLabColor;
    _placeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _placeL.text = @"至";
    [_contentView addSubview:_placeL];
    
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
    
    
    [_priceHeader mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(209 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
    }];
    
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(230 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_minPriceTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_minAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_minPriceTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_placeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(209 *SIZE);
        make.top.equalTo(self->_minPriceTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
    }];
    
    [_maxAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(230 *SIZE);
        make.top.equalTo(self->_minPriceTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];

    [_buyUseL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_minAreaTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_buyUseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_minAreaTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_buyUseBtn.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_buyUseBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_contentView).offset(-26 *SIZE);
    }];
    
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_contentView.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_markTV).offset(5 *SIZE);
        make.top.equalTo(self->_markTV).offset(7 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
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
