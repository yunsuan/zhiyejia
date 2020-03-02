//
//  AgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentCell.h"

#import "TagCollCell.h"

@interface AgentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
}
@end

@implementation AgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.agentCellPhoneBtnBlock) {
        
        self.agentCellPhoneBtnBlock(self.tag);
    }
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (self.agentCellAttentBtnBlock) {
        
        self.agentCellAttentBtnBlock(self.tag);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"agent_name"]];
    _yearL.text = [NSString stringWithFormat:@"%@",dataDic[@"age"]];
    _regionL.text = [NSString stringWithFormat:@"服务区域：%@",dataDic[@"service_area"]];
    _codeL.text = [NSString stringWithFormat:@"云算编号：%@",dataDic[@"account"]];
    _companyL.text = [NSString stringWithFormat:@"所属公司：%@",dataDic[@"company_name"]];
    _scoreL.text = [NSString stringWithFormat:@"评分：%@分",dataDic[@"grade"]];
    _typeL.text = [NSString stringWithFormat:@"%@",dataDic[@"agent_type"]];
    [_attentBtn setTitle:[NSString stringWithFormat:@"%@",dataDic[@"focus_num"]] forState:UIControlStateNormal];
    
    _sexImg.image = [dataDic[@"sex"] integerValue]?[dataDic[@"sex"] integerValue] == 1?IMAGE_WITH_NAME(@"man"):IMAGE_WITH_NAME(@"girl"):IMAGE_WITH_NAME(@"");
    
    if ([dataDic[@"is_focus"] integerValue] == 1) {
        
        [_attentBtn setImage:IMAGE_WITH_NAME(@"Focus_selected") forState:UIControlStateNormal];
    }else{
        
        [_attentBtn setImage:IMAGE_WITH_NAME(@"Focus") forState:UIControlStateNormal];
    }
    
    NSArray *arr;
    if ([_dataDic[@"self_tags"] length]) {
        
        arr = [_dataDic[@"self_tags"] componentsSeparatedByString:@","];
        _line1.hidden = NO;
    }else{
        
        arr = @[];
        _line1.hidden = YES;
    }
    _dataArr = [NSMutableArray arrayWithArray:arr];
    
    [_coll reloadData];
    [_coll mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 30 *SIZE)];
    }
    cell.tag = indexPath.item;
    
    cell.contentL.adjustsFontSizeToFitWidth = YES;
    [cell setStyleByType:@"0" lab:_dataArr[indexPath.item]];
    
    return cell;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    _nameL.textColor = CLTitleLabColor;
    [self.contentView addSubview:_nameL];
    
    _yearL = [[UILabel alloc] init];
    _yearL.font = FONT(11 *SIZE);
    _yearL.textColor = CLTitleLabColor;
    [self.contentView addSubview:_yearL];
    
    _regionL = [[UILabel alloc] init];
    _regionL.font = FONT(11 *SIZE);
    _regionL.textColor = CLTitleLabColor;
    _regionL.numberOfLines = 0;
    [self.contentView addSubview:_regionL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.font = FONT(11 *SIZE);
    _codeL.textColor = CLTitleLabColor;
    [self.contentView addSubview:_codeL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.font = FONT(11 *SIZE);
    _companyL.textColor = CLTitleLabColor;
    [self.contentView addSubview:_companyL];
    
    _distanceL = [[UILabel alloc] init];
    _distanceL.font = FONT(11 *SIZE);
    _distanceL.textColor = CLTitleLabColor;
    _distanceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distanceL];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.font = FONT(11 *SIZE);
    _scoreL.textColor = CLTitleLabColor;
    _scoreL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_scoreL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.font = FONT(11 *SIZE);
    _typeL.textColor = CLTitleLabColor;
    _typeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeL];
    
    _sexImg = [[UIImageView alloc] init];
    _sexImg.clipsToBounds = YES;
    _sexImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_sexImg];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"phone") forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:IMAGE_WITH_NAME(@"Focus") forState:UIControlStateNormal];
    [_attentBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    _attentBtn.titleLabel.font = FONT(13 *SIZE);
    [self.contentView addSubview:_attentBtn];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line1];
    
    _line2 = [[UIView alloc] init];
    _line2.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line2];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _layout.itemSize = CGSizeMake(80 *SIZE, 30 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 37 *SIZE) collectionViewLayout:_layout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    _coll.showsVerticalScrollIndicator = NO;
    _coll.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_coll];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.height.mas_equalTo(65 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(85 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(160 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(2 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_yearL.mas_right).offset(2 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.height.mas_equalTo(10 *SIZE);
    }];
    
    [_distanceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(85 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(180 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(85 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(180 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(85 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(270 *SIZE);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(80 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(80 *SIZE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(85 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(265 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_line1.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);;
    }];
    
    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
