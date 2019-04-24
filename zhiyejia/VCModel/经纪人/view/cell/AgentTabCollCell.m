//
//  AgentTabCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentTabCollCell.h"

@implementation AgentTabCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 14 *SIZE, SCREEN_Width / 2, 13 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(76 *SIZE, 38 *SIZE, 28 *SIZE, 2 *SIZE)];
    _line.backgroundColor = COLOR(27, 152, 255, 1);
    _line.hidden = YES;
    [self.contentView addSubview:_line];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = CLTitleLabColor;
        _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
        _line.hidden = NO;
    }else{
        
        _titleL.textColor = CLTitleLabColor;
        _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
        _line.hidden = YES;
    }
}

@end
