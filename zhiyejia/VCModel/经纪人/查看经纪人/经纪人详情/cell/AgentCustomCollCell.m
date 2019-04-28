//
//  AgentCustomCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentCustomCollCell.h"

@implementation AgentCustomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _titleL.textColor = CLContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.layer.cornerRadius = 2 *SIZE;
    _titleL.layer.borderColor = CL181Color.CGColor;
    _titleL.layer.borderWidth = SIZE;
    [self.contentView addSubview:_titleL];
}

@end
