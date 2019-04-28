//
//  DemandTakeCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandTakeCollCell.h"

@implementation DemandTakeCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13 *SIZE];
    _titleL.text = @"近期的带看计划";
    [self.contentView addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(14 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-65 *SIZE);
    }];
}

@end
