//
//  NewColorHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewColorHeader.h"

@implementation NewColorHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _colorView = [[UIView alloc] init];
    _colorView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_colorView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor blackColor];
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLBlueBtnColor;;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _contentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentL];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 33 *SIZE, SCREEN_Width , SIZE)];
    _lineView.backgroundColor = CLLineColor;
    _lineView.hidden = YES;
    [self.contentView addSubview:_lineView];
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(4 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(23 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
//        make.right.equalTo(self.contentView).offset(30 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-30 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(0 *SIZE);
//        make.top.equalTo(self.contentView).offset(33 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width);
//        make.height.mas_equalTo(SIZE);
//        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//    }];
}


@end
