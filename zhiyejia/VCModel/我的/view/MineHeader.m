//
//  MineHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineHeader.h"

@implementation MineHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionImg{
    
    if (self.mineHeaderImgBlock) {
        
        self.mineHeaderImgBlock();
    }
}

- (void)ActionName{
    
    if (self.mineHeaderNameBlock) {
        
        self.mineHeaderNameBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.contentMode = UIViewContentModeScaleAspectFill;
    _headerImg.clipsToBounds = YES;
    _headerImg.layer.cornerRadius = 29 *SIZE;
    _headerImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImg)];
    [_headerImg addGestureRecognizer:imgTap];
    [self.contentView addSubview:_headerImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont boldSystemFontOfSize:19 *SIZE];
    _nameL.text = @"登录/注册";
    _nameL.userInteractionEnabled = YES;
    UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionName)];
    [_nameL addGestureRecognizer:nameTap];
    [self.contentView addSubview:_nameL];
    
    _backView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 77 *SIZE)];
//    _backView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_backView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(47 *SIZE);
        make.width.height.mas_equalTo(58 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(76 *SIZE);
        make.top.equalTo(self.contentView).offset(64 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(70 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(130 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-25 *SIZE);
    }];
}

@end
