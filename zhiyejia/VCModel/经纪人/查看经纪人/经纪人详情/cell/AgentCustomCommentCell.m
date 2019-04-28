//
//  AgentCustomCommentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentCustomCommentCell.h"

#import "AgentCustomCollCell.h"
#import "AgentCustomImgCollCell.h"

@interface AgentCustomCommentCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_tagArr;
    NSMutableArray *_imgArr;
}
@end

@implementation AgentCustomCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _tagArr = [@[] mutableCopy];
    _imgArr = [@[] mutableCopy];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _tagColl) {
        
        return _tagArr.count;
    }
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _tagColl) {
        
        AgentCustomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentCustomCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[AgentCustomCollCell alloc] initWithFrame:CGRectMake(0, 0, 53 *SIZE, 10 *SIZE)];
        }
        
        return cell;
    }else{
        
        AgentCustomImgCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentCustomImgCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[AgentCustomImgCollCell alloc] initWithFrame:CGRectMake(0, 0, 73 *SIZE, 67 *SIZE)];
        }
        
        return cell;
    }
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.text = @"张三";
    [self.contentView addSubview:_nameL];
    
    _scoreImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_scoreImg];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.textColor = CLContentLabColor;
    _scoreL.font = [UIFont systemFontOfSize:11 *SIZE];
    _scoreL.text = @"93分";
    [self.contentView addSubview:_scoreL];
    
    _tagLayout = [[UICollectionViewFlowLayout alloc] init];
    _tagLayout.itemSize = CGSizeMake(53 *SIZE, 10 *SIZE);
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_tagLayout];
    _tagColl.backgroundColor = self.contentView.backgroundColor;
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    [_tagColl registerClass:[AgentCustomCollCell class] forCellWithReuseIdentifier:@"AgentCustomCollCell"];
    [self.contentView addSubview:_tagColl];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.text = @"这个经纪人不错，服务很热情";
    [self.contentView addSubview:_contentL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.text = @"2016-06-02";
    [self.contentView addSubview:_timeL];
    
    
    _imgLayout = [[UICollectionViewFlowLayout alloc] init];
    _imgLayout.itemSize = CGSizeMake(73 *SIZE, 67 *SIZE);
    
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_imgLayout];
    _imgColl.backgroundColor = self.contentView.backgroundColor;
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    [_imgColl registerClass:[AgentCustomImgCollCell class] forCellWithReuseIdentifier:@"AgentCustomImgCollCell"];
    [self.contentView addSubview:_imgColl];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.height.mas_equalTo(33 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(54 *SIZE);
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
    }];
    
//    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(120 *SIZE);
//    }];

    [_tagColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self->_tagColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_tagColl.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_imgColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self->_imgColl.collectionViewLayout.collectionViewContentSize.height);
    }];

    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_imgColl.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
