//
//  DemandVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandVC.h"

//#import "DemandListVC.h"

//#import "HouseDemandVC.h"
//#import "OfficeDemandVC.h"
//#import "StoreDemandVC.h"

#import "PublishDemandVC.h"

//二手房
//#import "SecHouseBuyHouseDemandVC.h"
//#import "SecHouseBuyStoreDemandVC.h"
//#import "SecHouseBuyOfficeDemandVC.h"
//
//#import "SecHouseSaleHouseDemandVC.h"

//买
#import "SecHouseBuyDemandWaitDetailVC.h"
#import "SecHouseBuyDemandDoingDetailVC.h"
#import "SecHouseBuyDemandRecommendDetailVC.h"
#import "SecHouseBuyDemandDealDetailVC.h"

//卖
#import "SecHouseSaleDemandWaitDetailVC.h"
#import "SecHouseSaleDemandDoingDetailVC.h"
#import "SecHouseSaleDemandDetailVC.h"

//租房
//#import "RentHouseDemandVC.h"
//#import "RentStoreDemandVC.h"
//#import "RentOfficeDemandVC.h"

#import "NewColorHeader.h"
#import "DeamandSaleCell.h"
#import "DemandSaleCell.h"
#import "DemandBuyCell.h"

#import "SinglePickView.h"

@interface DemandVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_sellArr;
    NSMutableArray *_buyArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation DemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    if ([UserModel defaultModel].token.length) {
        
        [self RequestMethod];
        [self SaleRequest];
    }else{
        
        
    }
    
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RequestMethod) name:@"goHome" object:nil];
    _sellArr = [@[] mutableCopy];
    _buyArr = [@[] mutableCopy];
}

- (void)SaleRequest{
    
//    [BaseRer
}

- (void)RequestMethod{
    
    [BaseRequest GET:NeedBuyList_URL parameters:@{@"type":@"0"} success:^(id  _Nonnull resposeObject) {
        
        [self->_table.mj_header endRefreshing];
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_buyArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self->_table.mj_header endRefreshing];
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    PublishDemandVC *nextVC = [[PublishDemandVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发布需求" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction *buy = [UIAlertAction actionWithTitle:@"求购" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        if ([UserModel defaultModel].token.length) {
//
//                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[/*@{@"param":@"新房-住宅",@"id":@"1"},@{@"param":@"新房-商铺",@"id":@"2"},@{@"param":@"新房-写字楼",@"id":@"3"},*/@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
//                view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//
//                    switch ([ID integerValue]) {
//                        case 1:
//                        {
//                            NSString *type;
//                            NSString *property;
//        //            if ([ID integerValue] < 4) {
//        //
//        //                type = @"0";
//        //                property = ID;
//        //            }else{
//
//                            type = @"1";
//                            property = ID;
//        //                property = [NSString stringWithFormat:@"%ld",[ID integerValue] - 3];
//        //            }
//                            SecHouseBuyHouseDemandVC *nextVC = [[SecHouseBuyHouseDemandVC alloc] initWithType:type property:property];
//                            nextVC.secHouseBuyHouseDemandVCBlock = ^{
//
//                                [self RequestMethod];
//                            };
//                            [self.navigationController pushViewController:nextVC animated:YES];
//                            break;
//                        }
//                        case 2:
//                        {
//                            SecHouseBuyStoreDemandVC *nextVC = [[SecHouseBuyStoreDemandVC alloc] init];
//                            [self.navigationController pushViewController:nextVC animated:YES];
//                            break;
//                        }
//                        case 3:
//                        {
//                            SecHouseBuyOfficeDemandVC *nextVC = [[SecHouseBuyOfficeDemandVC alloc] init];
//                            [self.navigationController pushViewController:nextVC animated:YES];
//                            break;
//                        }
//        //                case 4:
//        //                {
//        //                    SecHouseDemandVC *nextVC = [[SecHouseDemandVC alloc] init];
//        //                    [self.navigationController pushViewController:nextVC animated:YES];
//        //                    break;
//        //                }
//        //                case 5:
//        //                {
//        //                    SecStoreDemandVC *nextVC = [[SecStoreDemandVC alloc] init];
//        //                    [self.navigationController pushViewController:nextVC animated:YES];
//        //                    break;
//        //                }
//        //                case 6:
//        //                {
//        //                    SecOfficeDemandVC *nextVC = [[SecOfficeDemandVC alloc] init];
//        //                    [self.navigationController pushViewController:nextVC animated:YES];
//        //                    break;
//        //                }
//                        default:
//                            break;
//                    }
//                };
//                [[UIApplication sharedApplication].keyWindow addSubview:view];
//            }else{
//
//                [self GotoLogin];
////                [self RequestMethod];
//            }
//    }];
//
//    UIAlertAction *sale = [UIAlertAction actionWithTitle:@"卖房" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        if ([UserModel defaultModel].token.length) {
//
//            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:@[@{@"param":@"住宅",@"id":@"1"},@{@"param":@"商铺",@"id":@"2"},@{@"param":@"写字楼",@"id":@"3"}]];
//            view.selectedBlock = ^(NSString *MC, NSString *ID) {
//
//                NSString *type;
//                NSString *property;
//
//                type = @"1";
//                property = ID;
//
//                SecHouseSaleHouseDemandVC *nextVC = [[SecHouseSaleHouseDemandVC alloc] initWithType:type property:property];
//                nextVC.secHouseSaleHouseDemandVCBlock = ^{
//
//                    [self SaleRequest];
//                };
//                [self.navigationController pushViewController:nextVC animated:YES];
//            };
//            [[UIApplication sharedApplication].keyWindow addSubview:view];
//        }else{
//
//            [self GotoLogin];
////            [self RequestMethod];
//        }
//    }];
//
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [alert addAction:sale];
//    [alert addAction:buy];
//
//    [alert addAction:cancel];
//
//    [self.navigationController presentViewController:alert animated:YES completion:^{
//
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    [tableView tableViewDisplayWitMessage:@"你还没有发布过需求~" Img:@"LOG" ifNecessaryForRowCount:(_sellArr.count + _buyArr.count)];
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _sellArr.count? 1:0;
    }else{
        
        return _buyArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 34 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NewColorHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewColorHeader"];
    if (!header) {
        
        header = [[NewColorHeader alloc] initWithReuseIdentifier:@"NewColorHeader"];
    }
    
    if (section == 0) {
        
        header.titleL.text = [NSString stringWithFormat:@"房产出售(%ld)",_sellArr.count];;
        header.colorView.backgroundColor = [UIColor blackColor];
    }else{
        
        header.titleL.text = [NSString stringWithFormat:@"房产求购(%ld)",_buyArr.count];;
        header.colorView.backgroundColor = CLBlueBtnColor;
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        DemandSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandSaleCell"];
        if (!cell) {
            
            cell = [[DemandSaleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DemandSaleCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _sellArr;
        
        cell.demandSaleCellBlock = ^(NSInteger idx) {
            
            if ([self->_sellArr[idx][@"current_state"] integerValue] == 1) {
                
                SecHouseSaleDemandWaitDetailVC *nextVC = [[SecHouseSaleDemandWaitDetailVC alloc] initWithRecomendId:self->_sellArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_sellArr[idx][@"disabled_state"]];
                nextVC.secHouseSaleDemandWaitDetailVCBlock = ^{
                    
                    [self->_sellArr removeObjectAtIndex:idx];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                SecHouseSaleDemandDoingDetailVC *nextVC = [[SecHouseSaleDemandDoingDetailVC alloc] initWithRecomendId:self->_sellArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_sellArr[idx][@"disabled_state"]];
                nextVC.secHouseSaleDemandDoingDetailVCBlock = ^{
                                       
                    [self->_sellArr removeObjectAtIndex:idx];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
//        cell.dataDic = _sellArr[indexPath.row];
        
//        cell.demandSaleCellBlock = ^{
//
//            NSString *phone = @"15983804766";
//            if (phone.length) {
//
//                //获取目标号码字符串,转换成URL
//                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
//                //调用系统方法拨号
//                [[UIApplication sharedApplication] openURL:url];
//            }else{
//
//                [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
//            }
//        };
        return cell;
    }else{
        
        DemandBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemandBuyCell"];
        if (!cell) {
            
            cell = [[DemandBuyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DemandBuyCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArr = _buyArr;
        
        cell.demandBuyCellBlock = ^(NSInteger idx) {
            
            if ([self->_buyArr[idx][@"current_state"] integerValue] == 1) {
                
                SecHouseBuyDemandWaitDetailVC *nextVC = [[SecHouseBuyDemandWaitDetailVC alloc] initWithRecomendId:self->_buyArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_buyArr[idx][@"disabled_state"]];
                nextVC.secHouseBuyDemandWaitDetailVCBlock = ^{
                    
                    [self->_buyArr removeObjectAtIndex:idx];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if ([self->_buyArr[idx][@"current_state"] integerValue] == 2){
                
                SecHouseBuyDemandWaitDetailVC *nextVC = [[SecHouseBuyDemandWaitDetailVC alloc] initWithRecomendId:self->_buyArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_buyArr[idx][@"disabled_state"]];
                nextVC.secHouseBuyDemandWaitDetailVCBlock = ^{
                    
                    [self->_buyArr removeObjectAtIndex:idx];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if ([self->_buyArr[idx][@"current_state"] integerValue] == 3){
                
                SecHouseBuyDemandRecommendDetailVC *nextVC = [[SecHouseBuyDemandRecommendDetailVC alloc] initWithRecomendId:self->_buyArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_buyArr[idx][@"disabled_state"]];
                nextVC.secHouseBuyDemandRecommendDetailVCBlock = ^{
                  
                    [self->_buyArr removeObjectAtIndex:idx];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if ([self->_buyArr[idx][@"current_state"] integerValue] == 4){
                
                SecHouseBuyDemandDealDetailVC *nextVC = [[SecHouseBuyDemandDealDetailVC alloc] initWithRecomendId:self->_buyArr[idx][@"recommend_id"]];
                nextVC.status = [NSString stringWithFormat:@"%@",self->_buyArr[idx][@"disabled_state"]];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//        
//        if ([_sellArr[indexPath.row][@"current_state"] integerValue] == 1) {
//            
//            SecHouseSaleDemandWaitDetailVC *nextVC = [[SecHouseSaleDemandWaitDetailVC alloc] initWithRecomendId:_sellArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_sellArr[indexPath.row][@"disabled_state"]];
//            nextVC.secHouseSaleDemandWaitDetailVCBlock = ^{
//                
//                [self->_sellArr removeObjectAtIndex:indexPath.row];
//                [tableView reloadData];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//            
//            SecHouseSaleDemandDoingDetailVC *nextVC = [[SecHouseSaleDemandDoingDetailVC alloc] initWithRecomendId:_sellArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_sellArr[indexPath.row][@"disabled_state"]];
//            nextVC.secHouseSaleDemandDoingDetailVCBlock = ^{
//                                   
//                [self->_sellArr removeObjectAtIndex:indexPath.row];
//                [tableView reloadData];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    }else{
//        
//        if ([_buyArr[indexPath.row][@"current_state"] integerValue] == 1) {
//            
//            SecHouseBuyDemandWaitDetailVC *nextVC = [[SecHouseBuyDemandWaitDetailVC alloc] initWithRecomendId:_buyArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_buyArr[indexPath.row][@"disabled_state"]];
//            nextVC.secHouseBuyDemandWaitDetailVCBlock = ^{
//                
//                [self->_buyArr removeObjectAtIndex:indexPath.row];
//                [tableView reloadData];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else if ([_buyArr[indexPath.row][@"current_state"] integerValue] == 2){
//            
//            SecHouseBuyDemandWaitDetailVC *nextVC = [[SecHouseBuyDemandWaitDetailVC alloc] initWithRecomendId:_buyArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_buyArr[indexPath.row][@"disabled_state"]];
//            nextVC.secHouseBuyDemandWaitDetailVCBlock = ^{
//                
//                [self->_buyArr removeObjectAtIndex:indexPath.row];
//                [tableView reloadData];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else if ([_buyArr[indexPath.row][@"current_state"] integerValue] == 3){
//            
//            SecHouseBuyDemandRecommendDetailVC *nextVC = [[SecHouseBuyDemandRecommendDetailVC alloc] initWithRecomendId:_buyArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_buyArr[indexPath.row][@"disabled_state"]];
//            nextVC.secHouseBuyDemandRecommendDetailVCBlock = ^{
//              
//                [self->_buyArr removeObjectAtIndex:indexPath.row];
//                [tableView reloadData];
//            };
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else if ([_buyArr[indexPath.row][@"current_state"] integerValue] == 4){
//            
//            SecHouseBuyDemandDealDetailVC *nextVC = [[SecHouseBuyDemandDealDetailVC alloc] initWithRecomendId:_buyArr[indexPath.row][@"recommend_id"]];
//            nextVC.status = [NSString stringWithFormat:@"%@",_buyArr[indexPath.row][@"disabled_state"]];
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLWhiteColor;
    
    self.rightBtn.hidden = YES;
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add-1") forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"需求";

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = CLWhiteColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        if ([UserModel defaultModel].token.length) {
            
            [self RequestMethod];
            [self SaleRequest];
        }else{
            
            [self->_table.mj_header endRefreshing];
        }
    }];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(101 *SIZE, SCREEN_Height - TAB_BAR_MORE - 106 *SIZE, 160 *SIZE, 34 *SIZE);
    [_confirmBtn setBackgroundColor:CLNewBlueColor];
    [_confirmBtn setTitle:@"发布需求" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = FONT(15 *SIZE);
    _confirmBtn.layer.cornerRadius = 9 *SIZE;
    _confirmBtn.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6].CGColor;
    _confirmBtn.layer.shadowOffset = CGSizeMake(0,1);
    _confirmBtn.layer.shadowOpacity = 0.5;
//    _confirmBtn.layer.borderWidth = SIZE;
//    _confirmBtn.layer.borderColor = COLOR(231, 231, 231, 1).CGColor;
    _confirmBtn.layer.shadowRadius = 5 *SIZE;
//    _coll.layer.masksToBounds = NO;
    [_confirmBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
}


@end
