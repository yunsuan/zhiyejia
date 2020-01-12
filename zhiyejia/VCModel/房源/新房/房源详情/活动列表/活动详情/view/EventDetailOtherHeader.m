//
//  EventDetailOtherHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "EventDetailOtherHeader.h"

@implementation EventDetailOtherHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLTitleLabColor;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
    _contentL.font = FONT(15 *SIZE);
    [self.contentView addSubview:_contentL];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self.contentView).offset(100 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
