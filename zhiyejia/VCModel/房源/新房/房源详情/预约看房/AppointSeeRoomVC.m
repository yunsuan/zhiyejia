//
//  AppointSeeRoomVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AppointSeeRoomVC.h"

#import "AppointSeeRoomSuccessView.h"

@interface AppointSeeRoomVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *publishBtn;

@end

@implementation AppointSeeRoomVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionPublishBtn:(UIButton *)btn{
    
    NSLog(@"1111");
    AppointSeeRoomSuccessView *view = [[AppointSeeRoomSuccessView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"预约看房";
    self.view.backgroundColor = CLLineColor;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 127 *SIZE)];
    whiteView.backgroundColor = CLWhiteColor;
    [self.view addSubview:whiteView];
    
    NSArray *titleArr = @[@"称呼",@"手机号码",@"预约时间"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE + i * 42 *SIZE, 60 *SIZE, 13 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        [whiteView addSubview:label];
        
        if (i != 0) {
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 42 *SIZE * i, SCREEN_Width, SIZE)];
            line.backgroundColor = CLLineColor;
            [whiteView addSubview:line];
            
        }
        if (i < 2) {
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(70 *SIZE, 0 + 42 *SIZE * i, 265 *SIZE, 42 *SIZE)];
            tf.textAlignment = NSTextAlignmentRight;
            if (i == 0) {
                
                _nameTF = tf;
                [whiteView addSubview:_nameTF];
            }else{
                
                _phoneTF = tf;
                [whiteView addSubview:_phoneTF];
            }
        }
    }
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 10 *SIZE, 100 *SIZE, 12 *SIZE)];
    _placeL.textColor = CLContentLabColor;
    _placeL.text = @"其他要求";
    _placeL.font = [UIFont systemFontOfSize:13 *SIZE];
    
    _markTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 5 *SIZE + CGRectGetMaxY(whiteView.frame), SCREEN_Width, 100 *SIZE)];
    _markTV.delegate = self;
    _markTV.contentInset = UIEdgeInsetsMake(5 *SIZE, 5 *SIZE, 5 *SIZE, 5 *SIZE);
    [self.view addSubview:_markTV];
    
    [_markTV addSubview:_placeL];
    
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishBtn.frame = CGRectMake(20 *SIZE, SCREEN_Height - 85 *SIZE, 317 *SIZE, 40 *SIZE);
    _publishBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_publishBtn addTarget:self action:@selector(ActionPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
    _publishBtn.layer.cornerRadius = 20 *SIZE;
    _publishBtn.clipsToBounds = YES;
    
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 20 *SIZE;
    gradientLayer0.frame = _publishBtn.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:28.0f/255.0f green:151.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:8.0f/255.0f green:182.0f/255.0f blue:251.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
    [_publishBtn.layer addSublayer:gradientLayer0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 13 *SIZE, 317 *SIZE, 14 *SIZE)];
    label.textColor = CLWhiteColor;
    label.text = @"发布";
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    [_publishBtn addSubview:label];
//    [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.view addSubview:_publishBtn];
}

@end
