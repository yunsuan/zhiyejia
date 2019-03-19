//
//  DynamicListCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DynamicListCell.h"

@implementation DynamicListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
//    if (self.cellBtnBlock) {
//
//        self.cellBtnBlock(self.tag);
//    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(11 *SIZE, 16 *SIZE, 280 *SIZE, 17 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 330 *SIZE, 11 *SIZE)];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];//WithFrame:CGRectMake(12 *SIZE, 72 *SIZE, 337 *SIZE, 40 *SIZE)];
    _contentL.numberOfLines = 2;
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contentL];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(280 *SIZE, 120 *SIZE, 80 *SIZE, 21 *SIZE);
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setTitle:@"阅读全文 >>" forState:UIControlStateNormal];
    [moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:moreBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 149 *SIZE, SCREEN_Width, SIZE)];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
}

- (void)MasonryUI{
    
    
}

@end
