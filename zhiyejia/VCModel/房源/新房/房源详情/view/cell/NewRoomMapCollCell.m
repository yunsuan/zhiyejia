//
//  NewRoomMapCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomMapCollCell.h"

@implementation NewRoomMapCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.layer.cornerRadius = 2 *SIZE;
    self.contentView.clipsToBounds = YES;
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(0, 7 *SIZE, 60 *SIZE, 13 *SIZE)];
    _titleL.textColor = CLContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-7 *SIZE);
    }];
}

@end
