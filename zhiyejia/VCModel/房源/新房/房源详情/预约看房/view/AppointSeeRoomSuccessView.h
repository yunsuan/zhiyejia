//
//  AppointSeeRoomSuccessView.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AppointSeeRoomSuccessViewBlock)(void);

@interface AppointSeeRoomSuccessView : UIView

@property (nonatomic, copy) AppointSeeRoomSuccessViewBlock appointSeeRoomSuccessViewBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *appointBtn;

@end

NS_ASSUME_NONNULL_END
