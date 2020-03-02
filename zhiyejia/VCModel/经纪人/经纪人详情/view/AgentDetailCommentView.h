//
//  AgentDetailCommentView.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailCommentViewBlock)(NSString *comment,NSString *score,NSString *tag);

@interface AgentDetailCommentView : UIView

@property (nonatomic, copy) AgentDetailCommentViewBlock agentDetailCommentViewBlock;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIScrollView *whiteView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *scoL;

@property (nonatomic, strong) UILabel *scoreL;

//@property (nonatomic, strong) UIProgressView *progress;

@property (nonatomic, strong) UISlider *progress;

@property (nonatomic, strong) UILabel *pressL;

@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UITextView *commentTV;

@property (nonatomic, strong) UILabel *commentL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) UIView *line5;

@property (nonatomic, strong) NSArray *tagArr;

@end

NS_ASSUME_NONNULL_END
