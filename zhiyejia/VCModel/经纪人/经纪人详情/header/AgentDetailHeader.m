//
//  AgentDetailHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailHeader.h"

#import "AgentDetailAttentCell.h"
#import "TagCollCell.h"

@interface AgentDetailHeader ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_tagArr;
    NSMutableArray *_addressArr;
    NSMutableArray *_headImgArr;
}
@end

@implementation AgentDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _tagArr = [@[] mutableCopy];
    _addressArr = [@[] mutableCopy];
    _headImgArr = [@[] mutableCopy];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
          
            self->_headImg.image = IMAGE_WITH_NAME(@"def_head");
        }
        
    }];
    
    _titleL.text = dataDic[@"agent_name"];
    
    _sexImg.image = [dataDic[@"sex"] integerValue]?[dataDic[@"sex"] integerValue] == 1?IMAGE_WITH_NAME(@"man"):IMAGE_WITH_NAME(@"girl"):IMAGE_WITH_NAME(@"");
    _companyL.text = dataDic[@"company_name"];
    _typeL.text = dataDic[@"agent_type"];
    _takeNumL.text = [NSString stringWithFormat:@"带看量：%@",dataDic[@"take_push_num"]];
    _dealL.text = [NSString stringWithFormat:@"成交量：%@",dataDic[@"deal_num"]];
    _scoreL.text = [NSString stringWithFormat:@"评分：%@分",dataDic[@"grade"]];
    _attentL.text = [NSString stringWithFormat:@"%@人关注 %@人浏览",dataDic[@"focus_info"][@"focus_num"],dataDic[@"browse_num"]];
    _descL.text = [NSString stringWithFormat:@"%@",dataDic[@"self_desc"]];
    if ([dataDic[@"is_focus"] integerValue] == 1) {
        
        [_attentBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    }else{
        
        [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
    _phoneL.text = [NSString stringWithFormat:@"%@",dataDic[@"tel"]];
    _wxL.text = [NSString stringWithFormat:@"%@",[dataDic[@"wx_code"] length]?dataDic[@"wx_code"]:@"无"];
    _shareL.text = @"分享名片";
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _tagArr = [NSMutableArray arrayWithArray:dataArr[0]];
    _addressArr = [NSMutableArray arrayWithArray:dataArr[1]];
    _headImgArr = [NSMutableArray arrayWithArray:dataArr[2]];
    
    [_addressColl reloadData];
    [_coll reloadData];
    [_attentColl reloadData];
    [self.contentView reloadInputViews];
    [_coll mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_addressColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_addressColl.collectionViewLayout.collectionViewContentSize.height);
    }];
}


- (void)ActionBtn:(UIButton *)btn{
    
    if (self.agentDetailHeaderBlock) {
        
        self.agentDetailHeaderBlock(btn.tag);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _addressColl) {
        
        return _addressArr.count;
    }else if (collectionView == _coll) {
        
        return _tagArr.count;
    }else{
        
        return _headImgArr.count > 4 ? 4:_headImgArr.count;
    }
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (collectionView == _attentColl) {
//        
//        return CGSizeMake(30 *SIZE, 30 *SIZE);
//    }else if (collectionView == _addressColl){
//        
//        return CGSizeMake(340 *SIZE, 37 *SIZE);
//    }else{
//        
//        return CGSizeMake(100 *SIZE, 37 *SIZE);
//    }
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _addressColl) {
        
        TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addressColl" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 37 *SIZE)];
        }
        cell.tag = indexPath.item;
        
        [cell setStyleByType:@"0" lab:_addressArr[indexPath.item]];
        return cell;
    }else if (collectionView == _attentColl){
        
        AgentDetailAttentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentDetailAttentCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[AgentDetailAttentCell alloc] initWithFrame:CGRectMake(0, 0, 30 *SIZE, 30 *SIZE)];
        }
        cell.tag = indexPath.item;
        
        if ([_headImgArr[indexPath.item] containsString:@"http"]) {
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_headImgArr[indexPath.item]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.headImg.image = IMAGE_WITH_NAME(@"def_head");
                }
                
            }];
        }else{
            
         
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_headImgArr[indexPath.item]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.headImg.image = IMAGE_WITH_NAME(@"def_head");
                }
                
            }];
        }
        
        return cell;
    }else{
        
        TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 37 *SIZE)];
        }
        cell.tag = indexPath.item;
        
        [cell setStyleByType:@"0" lab:_tagArr[indexPath.item]];
        
        return cell;
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _backView = [[UIView alloc] init];;
    _backView.backgroundColor = CLWhiteColor;
    
    _backView.layer.cornerRadius = 8 *SIZE;
    _backView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6].CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,1);
    _backView.layer.shadowOpacity = 0.5;
    [self.contentView addSubview:_backView];
    
    _headImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(20 *SIZE, 20 *SIZE, 64 *SIZE, 64 *SIZE)];
    _headImg.layer.cornerRadius = 23.5 *SIZE;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [_backView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor blackColor];
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_backView addSubview:_titleL];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.textColor = CL98Color;
    _scoreL.font = [UIFont systemFontOfSize:11 *SIZE];
    [_backView addSubview:_scoreL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CL98Color;
    _companyL.font = [UIFont systemFontOfSize:11 *SIZE];
    [_backView addSubview:_companyL];
    
    _descL = [[UILabel alloc] init];
    _descL.textColor = [UIColor blackColor];
    _descL.font = [UIFont systemFontOfSize:13 *SIZE];
    _descL.numberOfLines = 0;
    [self.contentView addSubview:_descL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CL98Color;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:_typeL];
    
    _takeNumL = [[UILabel alloc] init];
    _takeNumL.textColor = CL98Color;
    _takeNumL.font = [UIFont systemFontOfSize:11 *SIZE];
    _takeNumL.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:_takeNumL];
    
    _dealL = [[UILabel alloc] init];
    _dealL.textColor = CL98Color;
    _dealL.font = [UIFont systemFontOfSize:11 *SIZE];
    _dealL.textAlignment = NSTextAlignmentRight;
    [_backView addSubview:_dealL];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:2 *SIZE];
    _layout.itemSize = CGSizeMake(100 *SIZE, 37 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [_backView addSubview:_coll];
    
    _regionL = [[UILabel alloc] init];
    _regionL.textColor = CLContentLabColor;
    _regionL.font = [UIFont systemFontOfSize:11 *SIZE];
    _regionL.text = @"服务区域";
    [self.contentView addSubview:_regionL];
    
    _addressLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:2 *SIZE];
    _addressLayout.itemSize = CGSizeMake(340 *SIZE, 37 *SIZE);
    
    _addressColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_addressLayout];
    _addressColl.backgroundColor = [UIColor whiteColor];
    _addressColl.delegate = self;
    _addressColl.dataSource = self;
    [_addressColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"addressColl"];
    [_backView addSubview:_addressColl];
    
    _blueView = [[UIView alloc] init];;
    _blueView.backgroundColor = CLBlueBtnColor;
    _blueView.layer.cornerRadius = 8 *SIZE;
    _blueView.clipsToBounds = YES;
    [self.contentView addSubview:_blueView];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn.tag = 1;
    [_phoneBtn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(40 *SIZE, 10 *SIZE, 20 *SIZE, 20 *SIZE)];
    img.image = IMAGE_WITH_NAME(@"phone");
    [_phoneBtn addSubview:img];
    [_blueView addSubview:_phoneBtn];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE, 80 *SIZE, 14 *SIZE)];
    _phoneL.textColor = CLWhiteColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
    _phoneL.textAlignment = NSTextAlignmentCenter;
    [_phoneBtn addSubview:_phoneL];
    
    _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wxBtn.tag = 2;
    [_wxBtn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(37.5 *SIZE, 10 *SIZE, 25 *SIZE, 20 *SIZE)];
    img1.image = IMAGE_WITH_NAME(@"wx");
    [_wxBtn addSubview:img1];
    [_blueView addSubview:_wxBtn];
    
    _wxL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE, 80 *SIZE, 14 *SIZE)];
    _wxL.textColor = CLWhiteColor;
    _wxL.font = [UIFont systemFontOfSize:11 *SIZE];
    _wxL.textAlignment = NSTextAlignmentCenter;
    [_wxBtn addSubview:_wxL];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.tag = 3;
    [_shareBtn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(40 *SIZE, 10 *SIZE, 20 *SIZE, 20 *SIZE)];
    img2.image = IMAGE_WITH_NAME(@"share");
    [_shareBtn addSubview:img2];
    [_blueView addSubview:_shareBtn];
    
    _shareL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 40 *SIZE, 80 *SIZE, 14 *SIZE)];
    _shareL.textColor = CLWhiteColor;
    _shareL.font = [UIFont systemFontOfSize:11 *SIZE];
    _shareL.textAlignment = NSTextAlignmentCenter;
    [_shareBtn addSubview:_shareL];
    
    _attentLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:-10*SIZE];
    _attentLayout.itemSize = CGSizeMake(30 *SIZE, 30 *SIZE);
//    _attentLayout.minimumInteritemSpacing = -10 *SIZE;
//    _attentLayout.minimumLineSpacing = - 10 *SIZE;
    _attentLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _attentColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_attentLayout];
    _attentColl.userInteractionEnabled = NO;
    _attentColl.backgroundColor = CLLineColor;
    _attentColl.delegate = self;
    _attentColl.dataSource = self;
    [_attentColl registerClass:[AgentDetailAttentCell class] forCellWithReuseIdentifier:@"AgentDetailAttentCell"];
    [self.contentView addSubview:_attentColl];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = CLContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_attentL];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentBtn setBackgroundColor:CLBlueBtnColor];
    [_attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    _attentBtn.tag = 4;
    _attentBtn.titleLabel.font = FONT(12 *SIZE);
    [_attentBtn addTarget:self action:@selector(ActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    _attentBtn.layer.cornerRadius = 15 *SIZE;
    _attentBtn.clipsToBounds = YES;
    [self.contentView addSubview:_attentBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.mas_equalTo(342 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_backView).offset(28 *SIZE);
        make.top.equalTo(self->_backView).offset(25 *SIZE);
        make.width.height.mas_equalTo(47 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(91 *SIZE);
        make.top.equalTo(self->_backView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(140 *SIZE);
    }];
    
    [_sexImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_titleL.mas_right).offset(7 *SIZE);
        make.top.equalTo(self->_backView).offset(15 *SIZE);
        make.width.height.mas_equalTo(14 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_backView).offset(-26 *SIZE);
        make.top.equalTo(self->_backView).offset(18 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_takeNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_backView).offset(-26 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_dealL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self->_backView).offset(-26 *SIZE);
        make.top.equalTo(self->_takeNumL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(91 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.width.mas_lessThanOrEqualTo(140 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(91 *SIZE);
        make.top.equalTo(self->_scoreL.mas_bottom).offset(9 *SIZE);
        make.width.mas_lessThanOrEqualTo(160 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_backView).offset(91 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(340 *SIZE);
    }];
    
    [_addressColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_backView).offset(10 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
        make.height.mas_equalTo(_addressColl.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self->_backView.mas_bottom).offset(-10 *SIZE);
    }];
    
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self->_backView.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(340 *SIZE);
    }];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_descL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(342 *SIZE);
//        make.height.mas_equalTo(50 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_blueView).offset(10 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
        make.bottom.equalTo(self->_blueView).offset(-10 *SIZE);
    }];
    
    [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_blueView).offset(120 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_blueView).offset(240 *SIZE);
        make.top.equalTo(self->_blueView).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(116 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(20 *SIZE);
        make.width.mas_lessThanOrEqualTo(340 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_attentColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_blueView.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
