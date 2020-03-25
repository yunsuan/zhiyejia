//
//  PublishDemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "PublishDemandVC.h"

//二手房
#import "SecHouseBuyHouseDemandVC.h"
#import "SecHouseBuyStoreDemandVC.h"
#import "SecHouseBuyOfficeDemandVC.h"

#import "SecHouseSaleHouseDemandVC.h"

#import "SinglePickView.h"

@interface PublishDemandVC ()

@property (nonatomic, strong) UIButton *sellBtn;

@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation PublishDemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)ActionSellBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[/*@{@"param":@"新房-住宅",@"id":@"1"},@{@"param":@"新房-商铺",@"id":@"2"},@{@"param":@"新房-写字楼",@"id":@"3"},*/@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                
                switch ([ID integerValue]) {
                    case 1:
                    {
                        NSString *type;
                        NSString *property;
    //            if ([ID integerValue] < 4) {
    //
    //                type = @"0";
    //                property = ID;
    //            }else{
                    
                        type = @"1";
                        property = ID;
    //                property = [NSString stringWithFormat:@"%ld",[ID integerValue] - 3];
    //            }
                        SecHouseBuyHouseDemandVC *nextVC = [[SecHouseBuyHouseDemandVC alloc] initWithType:type property:property];
                        nextVC.secHouseBuyHouseDemandVCBlock = ^{
                  
//                            [self RequestMethod];
                        };
                        [self.navigationController pushViewController:nextVC animated:YES];
                        break;
                    }
                    case 2:
                    {
                        SecHouseBuyStoreDemandVC *nextVC = [[SecHouseBuyStoreDemandVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                        break;
                    }
                    case 3:
                    {
                        SecHouseBuyOfficeDemandVC *nextVC = [[SecHouseBuyOfficeDemandVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                        break;
                    }
    //                case 4:
    //                {
    //                    SecHouseDemandVC *nextVC = [[SecHouseDemandVC alloc] init];
    //                    [self.navigationController pushViewController:nextVC animated:YES];
    //                    break;
    //                }
    //                case 5:
    //                {
    //                    SecStoreDemandVC *nextVC = [[SecStoreDemandVC alloc] init];
    //                    [self.navigationController pushViewController:nextVC animated:YES];
    //                    break;
    //                }
    //                case 6:
    //                {
    //                    SecOfficeDemandVC *nextVC = [[SecOfficeDemandVC alloc] init];
    //                    [self.navigationController pushViewController:nextVC animated:YES];
    //                    break;
    //                }
                    default:
                        break;
                }
            };
            [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)ActionBuyBtn:(UIButton *)btn{
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
        NSString *type;
        NSString *property;
        
        type = @"1";
        property = ID;
        
        SecHouseSaleHouseDemandVC *nextVC = [[SecHouseSaleHouseDemandVC alloc] initWithType:type property:property];
        nextVC.secHouseSaleHouseDemandVCBlock = ^{
        
//            [self SaleRequest];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)initUI{
    
    self.titleLabel.text = @"发布需求";
    
    _sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sellBtn.frame = CGRectMake(16 *SIZE, 85 *SIZE + NAVIGATION_BAR_HEIGHT, 329 *SIZE, 161 *SIZE);
    _sellBtn.layer.borderWidth = SIZE;
    _sellBtn.layer.borderColor = COLOR(231, 231, 231, 1).CGColor;
    _sellBtn.layer.cornerRadius = 26 *SIZE;
    _sellBtn.clipsToBounds = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 42 *SIZE, 50 *SIZE, 55 *SIZE)];
    label.numberOfLines = 2;
    label.text = @"我想卖房";
    label.font = FONT(23 *SIZE);
    [_sellBtn addSubview:label];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    img.image = IMAGE_WITH_NAME(@"");
    [_sellBtn addSubview:img];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 133 *SIZE, 329 *SIZE, SIZE)];
    line.backgroundColor = CLNewLineColor;
    [_sellBtn addSubview:line];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 141 *SIZE, 309 *SIZE, 13 *SIZE)];
    label2.text = @"一键发布";
    label2.textColor = CLNewBlueColor;
    label2.font = FONT(13 *SIZE);
    label2.textAlignment = NSTextAlignmentCenter;
    [_sellBtn addSubview:label2];
    
    [_sellBtn addTarget:self action:@selector(ActionSellBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sellBtn];
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.frame = CGRectMake(16 *SIZE, 272 *SIZE + NAVIGATION_BAR_HEIGHT, 329 *SIZE, 161 *SIZE);
    _buyBtn.layer.borderWidth = SIZE;
    _buyBtn.layer.borderColor = COLOR(231, 231, 231, 1).CGColor;
    _buyBtn.layer.cornerRadius = 26 *SIZE;
    _buyBtn.clipsToBounds = YES;
    UILabel *blabel = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 42 *SIZE, 50 *SIZE, 55 *SIZE)];
    blabel.font = FONT(23 *SIZE);
    blabel.numberOfLines = 2;
    blabel.text = @"我想买房";
    [_buyBtn addSubview:blabel];
    
    UIImageView *bimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    bimg.image = IMAGE_WITH_NAME(@"");
    [_buyBtn addSubview:bimg];
    
    UIView *bline = [[UIView alloc] initWithFrame:CGRectMake(0, 133 *SIZE, 329 *SIZE, SIZE)];
    bline.backgroundColor = CLNewLineColor;
    [_buyBtn addSubview:bline];
    
    UILabel *blabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 141 *SIZE, 309 *SIZE, 13 *SIZE)];
    blabel2.text = @"立即找房";
    blabel2.textColor = CLNewBlueColor;
    blabel2.font = FONT(13 *SIZE);
    blabel2.textAlignment = NSTextAlignmentCenter;
    [_buyBtn addSubview:blabel2];
    
    [_buyBtn addTarget:self action:@selector(ActionBuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buyBtn];
}

@end
