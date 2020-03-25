//
//  BuyDemandCompleteVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BuyDemandCompleteVC.h"

#import "PlaceImgDropDownBtn.h"

@interface BuyDemandCompleteVC ()

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) UILabel *demandL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) GZQFlowLayout *typeLayout;

@property (nonatomic, strong) UICollectionView *typeColl;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) PlaceImgDropDownBtn *areaBtn;

@property (nonatomic, strong) UILabel *pricePL;

//@property (nonatomic, strong) BorderTextField *maxPriceTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaPL;

@property (nonatomic, strong) UILabel *areaL;

//@property (nonatomic, strong) BorderTextField *maxPriceTF;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation BuyDemandCompleteVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)initUI{
    
    self.titleLabel.text = @"发布需求";
    
    _backImg = [[UIImageView alloc] init];
    _backImg.image = IMAGE_WITH_NAME(@"");
    [self.view addSubview:_backImg];
    
    _typeL = [[UILabel alloc] init];
    _typeL.text = @"你想购买什么类型的房产？";
}

@end
