//
//  SecHouseSaleDemandServerCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandServerCell.h"

@implementation SecHouseSaleDemandServerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.numberOfLines = 0;
    _contentL.textColor = CLTitleLabColor;
    _contentL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-80 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

@end
