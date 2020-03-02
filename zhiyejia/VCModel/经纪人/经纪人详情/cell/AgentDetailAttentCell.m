//
//  AgentDetailAttentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailAttentCell.h"

@implementation AgentDetailAttentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImg];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.right.equalTo(self.contentView).offset(-5 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-5 *SIZE);
    }];
}

@end
