//
//  HeaderImgCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HeaderImgCollCell.h"

@implementation HeaderImgCollCell

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
    self.contentView.backgroundColor = COLOR(229, 229, 229, 1);
    
    _contentL = [[UILabel alloc] initWithFrame:CGRectMake(0, 7 *SIZE, self.bounds.size.width, 11 *SIZE)];
    _contentL.textColor = COLOR(86, 86, 86, 1);
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentL];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _contentL.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = CLBlueBtnColor;
    }else{
        
        _contentL.textColor = COLOR(86, 86, 86, 1);
        self.contentView.backgroundColor = COLOR(229, 229, 229, 1);
    }
}

@end
