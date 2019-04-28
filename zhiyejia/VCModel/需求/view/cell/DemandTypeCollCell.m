//
//  DemandTypeCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandTypeCollCell.h"

@implementation DemandTypeCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.demandTypeCollCellBlock) {
        
        self.demandTypeCollCellBlock(self.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    _titleL.text = @"住宅 3条";
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:IMAGE_WITH_NAME(@"add") forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(94 *SIZE);
        make.right.equalTo(self.contentView).offset(-3 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-39 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(39 *SIZE);
        make.top.equalTo(self.contentView).offset(38 *SIZE);
        make.width.height.mas_equalTo(21 *SIZE);
    }];
}

@end
