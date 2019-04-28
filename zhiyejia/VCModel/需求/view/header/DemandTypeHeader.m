//
//  DemandTypeHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandTypeHeader.h"

@implementation DemandTypeHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(13 *SIZE, 13 *SIZE, 100 *SIZE, 15 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.text = @"新房";
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self addSubview:_titleL];
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(247 *SIZE, 16 *SIZE, 100 *SIZE, 10 *SIZE)];
    _contentL.textColor = CL170Color;
    _contentL.font = [UIFont systemFontOfSize:10 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    _contentL.text = @"成交记录：12条";
    [self addSubview:_contentL];
}

@end
