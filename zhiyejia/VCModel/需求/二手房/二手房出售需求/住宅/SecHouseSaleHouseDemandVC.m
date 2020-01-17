//
//  SecHouseSaleHouseDemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleHouseDemandVC.h"

#import "DropDownBtn.h"
#import "RightTextField.h"
#import "BorderTextField.h"
#import "SinglePickView.h"

#import "AddNumeralCodeColl.h"
#import "AddNumeralCodeCollCell.h"

#import "BaseColorHeader.h"


@interface SecHouseSaleHouseDemandVC ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSString *_type;
    NSString *_property;
    NSString *_project_id;
    
    NSMutableArray *_projectArr;
    NSMutableArray *_containArr;
    NSMutableArray *_cityArr;
    NSMutableArray *_districtArr;
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

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) BorderTextField *projectBtn;

@property (nonatomic, strong) UIView *projectLine;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) BorderTextField *buildTF;

@property (nonatomic, strong) UIView *buildlLine;

@property (nonatomic, strong) UILabel *priceHeader;

@property (nonatomic, strong) BorderTextField *minPriceTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *maxPriceTF;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) AddNumeralCodeColl *coll;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation SecHouseSaleHouseDemandVC

- (instancetype)initWithType:(NSString *)type property:(NSString *)property
{
    self = [super init];
    if (self) {
        
        _type = type;
        _property = property;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    
    _cityArr = [@[] mutableCopy];
    _districtArr = [@[] mutableCopy];
    _containArr = [@[] mutableCopy];
    _projectArr = [@[] mutableCopy];
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
                [self RequestProject];
            };
            view.cancelBlock = ^{
                
                [self RequestProject];
            };
            [self.view addSubview:view];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)RequestProject{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[self->_areaBtn->str componentsSeparatedByString:@","][0] forKey:@"city"];
    if ([[self->_areaBtn->str componentsSeparatedByString:@","] count] > 1) {
        
        if ([[self->_areaBtn->str componentsSeparatedByString:@","][1] integerValue] != 0) {
            
            [dic setValue:[self->_areaBtn->str componentsSeparatedByString:@","][1] forKey:@"district"];
        }
    }
    
    [BaseRequest GET:NeedHouseProjectList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_projectArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionUseBtn:(UIButton *)btn{
    
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if ([[_areaBtn->str componentsSeparatedByString:@","] count] < 2) {
        
        [self showContent:@"请选择城市区域"];
        return;
    }
    
    if (!_minPriceTF.textfield.text.length) {
        
        [self showContent:@"请输入最低价格"];
        return;
    }
    
    if (!_maxPriceTF.textfield.text.length) {
        
        [self showContent:@"请输入最高价格"];
        return;
    }
    if (!_projectBtn.textfield.text.length) {
        
        [self showContent:@"请选择项目"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[_areaBtn->str componentsSeparatedByString:@","][0] forKey:@"recommend_city"];
    [dic setValue:[_areaBtn->str componentsSeparatedByString:@","][1] forKey:@"recommend_district"];
    [dic setValue:_type forKey:@"type"];
    [dic setValue:_property forKey:@"property_type"];
    [dic setValue:_project_id forKey:@"project_id"];
    [dic setValue:_projectBtn.textfield.text forKey:@"project_name"];
    [dic setValue:[NSString stringWithFormat:@"%@",_minPriceTF.textfield.text] forKey:@"price_min"];
    [dic setValue:[NSString stringWithFormat:@"%@",_maxPriceTF.textfield.text] forKey:@"price_max"];
    if (_addressTF.textfield.text.length) {
        
        [dic setValue:_addressTF.textfield.text forKey:@"need_address"];
    }
    if (_buildTF.textfield.text.length) {
        
        [dic setValue:_buildTF.textfield.text forKey:@"house_info"];
    }
    if (_markTV.text.length) {
        
        [dic setValue:_addressTF.textfield.text forKey:@"comment"];
    }
    if (_markTV.text.length) {
        
        [dic setValue:_markTV.text forKey:@"comment"];
    }
    
    [BaseRequest POST:NeedSaleAdd_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self showContent:@"发布成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.secHouseSaleHouseDemandVCBlock) {
                    
                    self.secHouseSaleHouseDemandVCBlock();
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

- (void)TextFieldDidChange{
    
    _project_id = @"0";
    _coll.hidden = YES;
    [_containArr removeAllObjects];
    NSMutableArray *tempArr = [@[] mutableCopy];
    
    for (int i = 0; i < _projectArr.count; i++) {
        
        if ([[NSString stringWithFormat:@"%@",_projectArr[i][@"project_name"]] containsString:_projectBtn.textfield.text]) {
            
            [_containArr addObject:_projectArr[i]];
        }
    }
    
    [_coll reloadData];
    if (_containArr.count) {
        
        _coll.hidden = NO;
        [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_scrollView).offset(80 *SIZE);
            make.top.equalTo(_projectBtn.mas_bottom).offset(5 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(132 *SIZE);
        }];
    }else{
        
        _coll.hidden = YES;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _containArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddNumeralCodeCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddNumeralCodeCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AddNumeralCodeCollCell alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    }
    
    cell.titleL.text = [NSString stringWithFormat:@"%@",_containArr[indexPath.item][@"project_name"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [_infoDic setObject:[NSString stringWithFormat:@"%@",_collArr[indexPath.item][@"row_code"]] forKey:@"row_code"];
//    _addNumeralInfoView.dataDic = _infoDic;
    _projectBtn.textfield.text = [NSString stringWithFormat:@"%@",_containArr[indexPath.item][@"project_name"]];
    _project_id = [NSString stringWithFormat:@"%@",_containArr[indexPath.item][@"project_id"]];
    collectionView.hidden = YES;
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
//    _titleHeader.titleL.text = @"新房-商铺";
//    if ([_type integerValue] == 0) {
//
//        _titleHeader.titleL.text = @"新房";
//    }else{
        
        _titleHeader.titleL.text = @"二手房";
//    }
    if ([_property integerValue] == 1) {
        
        _titleHeader.titleL.text = [NSString stringWithFormat:@"%@-住宅",_titleHeader.titleL.text];
    }else if ([_property integerValue] == 2) {
        
        _titleHeader.titleL.text = [NSString stringWithFormat:@"%@-商铺",_titleHeader.titleL.text];
    }else{
        
        _titleHeader.titleL.text = [NSString stringWithFormat:@"%@-写字楼",_titleHeader.titleL.text];
    }
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
 
    for (int i = 0; i < 4; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        if (i == 0) {
            
            _areaLine = line;
            [_contentView addSubview:_areaLine];
        }else if (i == 1){
            
            _projectLine = line;
            [_contentView addSubview:_projectLine];
        }else if (i == 2){
            
            _buildlLine = line;
            [_contentView addSubview:_buildlLine];
        }else{
            
            _addressLine = line;
            [_contentView addSubview:_addressLine];
        }
    }
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = CLTitleLabColor;
    _projectL.font = [UIFont systemFontOfSize:13 *SIZE];
    _projectL.text = @"项目名称";
    [_contentView addSubview:_projectL];
    
    _projectBtn = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 258 *SIZE, 33 *SIZE)];
    _projectBtn.textfield.delegate = self;
    [_projectBtn.textfield addTarget:self action:@selector(TextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:_projectBtn];
    
    _buildL = [[UILabel alloc] init];
    _buildL.textColor = CLTitleLabColor;
    _buildL.font = [UIFont systemFontOfSize:13 *SIZE];
    _buildL.text = @"楼栋房号";
    [_contentView addSubview:_buildL];
    
    _buildTF = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 0, 258 *SIZE, 33 *SIZE)];
    _buildTF.textfield.delegate = self;
    [_contentView addSubview:_buildTF];
    
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
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.text = @"至";
    [_contentView addSubview:_priceL];
    
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
    
    _layout = [[GZQFlowLayout alloc] initWithType:1 betweenOfCell:0 *SIZE];
    _layout.itemSize = CGSizeMake(258 *SIZE, 33 *SIZE);
    
    _coll = [[AddNumeralCodeColl alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[AddNumeralCodeCollCell class] forCellWithReuseIdentifier:@"AddNumeralCodeCollCell"];
    _coll.hidden = YES;
    _coll.layer.cornerRadius = 5 *SIZE;
    _coll.clipsToBounds = YES;
    _coll.layer.borderColor = CLLineColor.CGColor;
    _coll.layer.borderWidth = SIZE;
    [_scrollView addSubview:_coll];
    
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
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_projectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_addressLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_projectLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_projectBtn.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(0 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_projectLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_buildTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_projectLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_buildlLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(0 *SIZE);
        make.top.equalTo(self->_buildTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(0 *SIZE);
    }];
    
    [_priceHeader mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(10 *SIZE);
        make.top.equalTo(self->_buildlLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];

    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(80 *SIZE);
        make.top.equalTo(self->_buildlLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_contentView).offset(-26 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(209 *SIZE);
        make.top.equalTo(self->_buildlLine.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
    }];
    
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_contentView).offset(230 *SIZE);
        make.top.equalTo(self->_buildlLine.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(80 *SIZE);
        make.top.equalTo(_projectBtn.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(132 *SIZE);
    }];
    
    [_markTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_contentView.mas_bottom).offset(5 *SIZE);
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
