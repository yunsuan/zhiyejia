//
//  SecHouseBuyDemandDetailRecommendAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/7.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendAgentCell.h"

#import "TagCollCell.h"


@interface SecHouseBuyDemandDetailRecommendAgentCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation SecHouseBuyDemandDetailRecommendAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = _dataDic[@"name"];
    _yearL.text = _dataDic[@"age"]?[NSString stringWithFormat:@"%@岁",_dataDic[@"age"]]:@"";
    _genderImg.image = [_dataDic[@"age"] integerValue] == 1? IMAGE_WITH_NAME(@"man"):[_dataDic[@"age"] integerValue] == 2? IMAGE_WITH_NAME(@"girl"):IMAGE_WITH_NAME(@"");
    _companyL.text = @"所属公司：大唐";
    _codeL.text = [NSString stringWithFormat:@"云算编号：%@",_dataDic[@"account"]];
    
    _comprehensiveGradeL.text = @"综合评分：78分";
    _serviceGradeL.text = @"服务评分：78分";
    _professionalGradeL.text = @"专业评分：78分";
    _regionL.text = @"服务区域：成都市郫都区";
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
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
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 30 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    for ( int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _yearL = label;
                _yearL.font = FONT(11 *SIZE);
                _yearL.textColor = CL86Color;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 2:
            {
                _companyL = label;
                _companyL.font = FONT(11 *SIZE);
                _companyL.textColor = CL86Color;
                [self.contentView addSubview:_companyL];
                break;
            }
            case 3:
            {
                _codeL = label;
                _codeL.font = FONT(11 *SIZE);
                _codeL.textColor = CL86Color;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 4:
            {
                _comprehensiveGradeL = label;
                _comprehensiveGradeL.font = FONT(11 *SIZE);
                _comprehensiveGradeL.textColor = CL86Color;
                _comprehensiveGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_comprehensiveGradeL];
                break;
            }
            case 5:
            {
                _professionalGradeL = label;
                _professionalGradeL.font = FONT(11 *SIZE);
                _professionalGradeL.textColor = CL86Color;
                _professionalGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_professionalGradeL];
                break;
            }
            case 6:
            {
                _serviceGradeL = label;
                _serviceGradeL.font = FONT(11 *SIZE);
                _serviceGradeL.textColor = CL86Color;
                _serviceGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_serviceGradeL];
                break;
            }
            case 7:
            {
                _regionL = label;
                _regionL.font = FONT(11 *SIZE);
                _regionL.textColor = CL86Color;
                _regionL.numberOfLines = 0;
                [self.contentView addSubview:_regionL];
                break;
            }
            default:
                break;
        }
    }
    
    _tagFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:9 *SIZE];
    _tagFlowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _tagFlowLayout.sectionInset = UIEdgeInsetsMake(4 *SIZE, 10 *SIZE, 4 *SIZE, 10 *SIZE);
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_tagFlowLayout];
    _tagColl.backgroundColor = CLWhiteColor;
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    [_tagColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_tagColl];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(60 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_nameL.mas_right).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_lessThanOrEqualTo(35 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_yearL.mas_right).offset(7 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_comprehensiveGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_professionalGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_serviceGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_tagColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(_tagColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self->_tagColl.mas_bottom).offset(14 *SIZE);
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
