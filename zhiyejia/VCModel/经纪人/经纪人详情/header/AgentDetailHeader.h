//
//  AgentDetailHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailHeaderBlock)(NSInteger idx);

@interface AgentDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) AgentDetailHeaderBlock agentDetailHeaderBlock;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *descL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) GZQFlowLayout *attentLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionView *addressColl;

@property (nonatomic, strong) UICollectionView *attentColl;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *wxBtn;

@property (nonatomic, strong) UILabel *wxL;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UILabel *shareL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) NSArray *dataArr;

//@property (nonatomic, strong) NSArray *addressArr;

@property (nonatomic, strong) NSDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
