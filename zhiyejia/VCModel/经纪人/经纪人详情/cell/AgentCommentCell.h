//
//  AgentCommentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagCollCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentCommentCellBlock)(void);

typedef void(^AgentCommentCellLabelBlock)(void);

@interface AgentCommentCell : UITableViewCell

@property (nonatomic, copy) AgentCommentCellBlock agentCommentCellBlock;

@property (nonatomic, copy) AgentCommentCellLabelBlock agentCommentCellLabelBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

//@property (nonatomic, strong) UITextView *contentL;

@property (nonatomic, strong) GZQFlowLayout *contentLayout;

@property (nonatomic, strong) UICollectionView *contentColl;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
