//
//  AgentDetailCommentView.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailCommentView.h"

#import "TagCollCell.h"

@interface AgentDetailCommentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate>
{
    
    NSMutableArray *_dataArr;
    
    NSMutableArray *_selectArr;
}
@end

@implementation AgentDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
    _selectArr = [@[] mutableCopy];
}

- (void)setTagArr:(NSArray *)tagArr{
    
    _dataArr = [NSMutableArray arrayWithArray:tagArr];
    for (int i = 0; i < _dataArr.count; i++) {
        
        [_selectArr addObject:@(0)];
    }
    [_coll reloadData];
    [self reloadInputViews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_whiteView).offset(100 *SIZE);
            make.top.equalTo(self->_line3.mas_bottom).offset(30 *SIZE);
            make.width.mas_equalTo(SCREEN_Width - 140 *SIZE);
            make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
        }];
    });
    
}

- (void)ActionCancelBtn{
    
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.agentDetailCommentViewBlock) {
        
        NSString *str = @"";;
        for (int i =0 ;i < _dataArr.count; i++) {
            
            if ([_selectArr[i] integerValue] == 1) {
                
                if (str.length) {
                    
                    str = [NSString stringWithFormat:@"%@,%@",str,[NSString stringWithFormat:@"%@",_dataArr[i][@"id"]]];
                }else{
                    
                    str = [NSString stringWithFormat:@"%@",_dataArr[i][@"id"]];
                }
            }
        }
        self.agentDetailCommentViewBlock(_commentTV.text,_scoreL.text,str);
    }
    [self removeFromSuperview];
}

- (void)ActionSlider:(UISlider *)slider{
    
    _scoreL.text = [NSString stringWithFormat:@"%.0f",slider.value];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _commentL.hidden = YES;
    }else{
        
        _commentL.hidden = NO;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(65 *SIZE, 25 *SIZE);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    
    cell.contentL.text = _dataArr[indexPath.item][@"param"];
    if ([_selectArr[indexPath.item] integerValue] == 1) {
        
        cell.contentView.backgroundColor = CLBlueBtnColor;
        cell.contentL.textColor = CLWhiteColor;
    }else{
        
        if (indexPath.item % 3 == 0) {
            
            cell.contentView.backgroundColor = COLOR(213, 242, 255, 1);
            cell.contentL.textColor = COLOR(64, 169, 255, 1);
        }else if (indexPath.item % 3 == 1){
            
            cell.contentView.backgroundColor = COLOR(234, 242, 237, 1);
            cell.contentL.textColor = COLOR(108, 187, 166, 1);
        }else if (indexPath.item % 3 == 2){
            
            cell.contentView.backgroundColor = COLOR(208, 243, 245, 1);
            cell.contentL.textColor = COLOR(36, 185, 195, 1);
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue] == 1) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@"0"];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@"1"];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIScrollView alloc] init];
//    _whiteView.delegate = self;
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 5 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 *SIZE, 330 *SIZE, 20 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont boldSystemFontOfSize:16 *SIZE];
    label.text = @"置业顾问评价";
    label.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:label];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(10 *SIZE, 10 *SIZE, 30 *SIZE, 30 *SIZE);
    [_cancelBtn setImage: IMAGE_WITH_NAME(@"close_sdk_login_14x14_") forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_cancelBtn];
    
    for (int i = 0; i < 5; i++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        if (i == 0) {
            
            _line1 = line;
            [_whiteView addSubview:_line1];
        }else if (i == 1){
            
            _line2 = line;
            [_whiteView addSubview:_line2];
        }else if (i == 2){
            
            _line3 = line;
            [_whiteView addSubview:_line3];
        }else if (i == 3){
            
            _line4 = line;
            [_whiteView addSubview:_line4];
        }else{
            
            _line5 = line;
            [_whiteView addSubview:_line5];
        }
    }
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_nameL];
    
    _progress = [[UISlider alloc] initWithFrame:CGRectMake(0 *SIZE, 0 *SIZE, 200 *SIZE, 20 *SIZE)];
    [_progress setMaximumValue:100];
    [_progress addTarget:self action:@selector(ActionSlider:) forControlEvents:UIControlEventValueChanged];
    [_whiteView addSubview:_progress];
    
    _scoL = [[UILabel alloc] init];
    _scoL.textColor = CLTitleLabColor;
    _scoL.font = FONT(13 *SIZE);
    _scoL.text = @"专业评分：";
    [_whiteView addSubview:_scoL];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.textColor = CLContentLabColor;
    _scoreL.font = FONT(13 *SIZE);
    _scoreL.textAlignment = NSTextAlignmentRight;
    _scoreL.text = @"0";
    [_whiteView addSubview:_scoreL];
    
    _pressL = [[UILabel alloc] init];
    _pressL.textColor = CLTitleLabColor;
    _pressL.font = FONT(13 *SIZE);
    _pressL.text = @"印象评价：";
    [_whiteView addSubview:_pressL];
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:2 *SIZE];
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [_whiteView addSubview:_coll];
    
    _commentTV = [[UITextView alloc] init];
    _commentTV.backgroundColor = CLLineColor;
    _commentTV.delegate = self;
    [_whiteView addSubview:_commentTV];
    
    _commentL = [[UILabel alloc] initWithFrame:CGRectMake(4 *SIZE, 8 *SIZE, 200 *SIZE, 14 *SIZE)];
    _commentL.textColor = CLContentLabColor;
    _commentL.font = FONT(13 *SIZE);
    _commentL.text = @"请输入您对置业顾问的评价";
    [_commentTV addSubview:_commentL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 5 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.titleLabel.font = FONT(13 *SIZE);
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_confirmBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(200 *SIZE);
        make.bottom.equalTo(self).offset(0).priority(300);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(30 *SIZE);
        make.top.equalTo(self->_whiteView).offset(50 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 50 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_line1.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_scoL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_line2.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(130 *SIZE);
        make.top.equalTo(self->_line2.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 210 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(SCREEN_Width - 80 *SIZE);
        make.top.equalTo(self->_line2.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_progress.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_pressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_line3.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(100 *SIZE);
        make.top.equalTo(self->_line3.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 140 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_commentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_line4.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(60 *SIZE);
    }];
    
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_commentTV.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(40 *SIZE);
        make.top.equalTo(self->_line5.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 80 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_whiteView).offset(-20 *SIZE).priority(300);;
    }];
}

@end
