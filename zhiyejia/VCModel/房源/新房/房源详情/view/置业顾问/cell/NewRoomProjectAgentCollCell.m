//
//  NewRoomProjectAgentCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentCollCell.h"

@implementation NewRoomProjectAgentCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20 *SIZE, 10 *SIZE, 60 *SIZE, 60 *SIZE)];
    _headImg.layer.cornerRadius = 30 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(5 *SIZE, 80 *SIZE, 90 *SIZE, 15 *SIZE)];
    _nameL.textAlignment = NSTextAlignmentCenter;
    _nameL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_nameL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_phoneBtn];
//    _phoneBtn.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

@end
