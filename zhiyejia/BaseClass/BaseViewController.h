//
//  BaseViewController.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

//Nav背景
@property (nonatomic, strong)UIView *navBackgroundView;
//Nav标题
@property (nonatomic, strong)UILabel *titleLabel;
//返回按钮
@property (nonatomic, strong)UIButton *leftButton;

//给返回按钮蒙上一层 使其好点击
@property (nonatomic, strong)UIButton *maskButton;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong) UIView *line;

//返回按钮；
- (void)ActionMaskBtn:(UIButton *)btn;

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack;

- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithDefaultBlack:(void(^)(void))defaultBlack;

//没有点击效果的弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1;

//图片压缩至希望的大小
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//拍照后对图片进行处理
- (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str;

- (void)showContent:(NSString *)str;

- (BOOL)isEmpty:(NSString *)str;

- (void)GotoLogin;

@end

NS_ASSUME_NONNULL_END
