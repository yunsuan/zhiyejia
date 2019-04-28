//
//  AgentCustomImgCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentCustomImgCollCell.h"

@implementation AgentCustomImgCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:self.bounds];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
}

@end
