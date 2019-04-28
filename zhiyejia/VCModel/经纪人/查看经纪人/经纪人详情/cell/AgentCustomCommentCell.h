//
//  AgentCustomCommentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentCustomCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *scoreImg;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UICollectionViewFlowLayout *tagLayout;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UICollectionViewFlowLayout *imgLayout;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *line;
@end

NS_ASSUME_NONNULL_END
