//
//  NewRoomProjectDetailFooter.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectDetailFooter.h"

@implementation NewRoomProjectDetailFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:(NSString *)reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = CLLineColor;
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_backView];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.width.mas_equalTo(5 *SIZE);
    }];
}

@end
