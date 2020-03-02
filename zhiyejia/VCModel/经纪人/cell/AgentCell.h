//
//  AgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentCellPhoneBtnBlock)(NSInteger idx);

typedef void(^AgentCellAttentBtnBlock)(NSInteger idx);

@interface AgentCell : UITableViewCell

@property (nonatomic, copy) AgentCellPhoneBtnBlock agentCellPhoneBtnBlock;

@property (nonatomic, copy) AgentCellAttentBtnBlock agentCellAttentBtnBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *distanceL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
