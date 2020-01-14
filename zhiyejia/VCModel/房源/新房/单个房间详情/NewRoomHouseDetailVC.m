//
//  NewRoomHouseDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomHouseDetailVC.h"

#import "NewRoomHouseHeader.h"
#import "TitleBaseHeader.h"
#import "NewRoomHouseInfoCell.h"
#import "NewRoomProjectHouseTypeCell.h"

@interface NewRoomHouseDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NSString *_houseTypeId;
    NSMutableDictionary *_baseInfoDic;
    NSMutableArray *_imgArr;
    NSMutableArray *_houseArr;
    NSString *_projectId;
    NSString *_infoid;
    NSMutableArray *_matchList;
    NSString *_url;
    NSInteger _state;
    NSInteger _selected;
}

@property (nonatomic, strong) UITableView *houseTable;

@end

@implementation NewRoomHouseDetailVC

- (instancetype)initWithHouseTypeId:(NSString *)houseTypeId index:(NSInteger)index dataArr:(NSArray *)dataArr projectId:(NSString *)projectId infoid:(NSString *)infoid
{
    self = [super init];
    if (self) {
        
        _infoid = infoid;
        _projectId = projectId;
        _houseTypeId = houseTypeId;
        _imgArr = [@[] mutableCopy];
        _matchList = [@[] mutableCopy];
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        _houseArr = [NSMutableArray arrayWithArray:self.dataArr];
        [_houseArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[NSString stringWithFormat:@"%@",obj[@"id"]] isEqualToString:houseTypeId]) {
                
                [self->_houseArr removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self RequestMethod];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [BaseRequest GET:@"user/project/getHouseType" parameters:@{@"house_type_id":_houseTypeId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_url = resposeObject[@"data"][@"url"];
//            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        }else{
            
            [self showContent:@"分享失败"];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"分享失败"];
    }];
}


- (void)RequestMethod{
    
    [BaseRequest GET:HouseTypeDetail_URL parameters:@{@"id":_houseTypeId} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {

                [self SetData:resposeObject[@"data"]];
            }else{

                [self showContent:@"暂无信息"];
            }
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"baseInfo"] isKindOfClass:[NSDictionary class]]) {
        
        _baseInfoDic = [NSMutableDictionary dictionaryWithDictionary:data[@"baseInfo"]];
        [_baseInfoDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [self->_baseInfoDic setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"imgInfo"] isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = data[@"imgInfo"];
        for ( int i = 0; i < arr.count; i++) {
            
            if ([arr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:arr[i]];
                
                [_imgArr addObject:tempDic];
            }
        }
    }
    
    [_houseTable reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if (_houseArr.count) {
            
            return 1;
        }
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
    
        NewRoomHouseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HouseTypeTableHeader"];
        if (!header) {
            
            header = [[NewRoomHouseHeader alloc] initWithReuseIdentifier:@"NewRoomHouseHeader"];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        header.newRoomHouseHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            NSMutableArray *tempArr1 = [NSMutableArray array];
            for (NSDictionary *dic in imgArr) {
                
                for (NSDictionary *subDic in dic[@"list"]) {
                    
                    [tempArr1 addObject:subDic];
                }
            }
            [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                if ([obj[@"img_url_3d"] length]) {
                    
                    model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
                }
                
                [tempArr addObject:model];
            }];
            
            [self->_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                [tempDic setObject:obj[@"type"] forKey:@"name"];
                
                [tempDic setObject:obj[@"list"] forKey:@"data"];
                [self->_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                
            }];
            
            YBImageBrowserModel *YBmodel = tempArr[num];
            if (YBmodel.third_URL.length) {

                BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
                nextVC.weburl = YBmodel.third_URL;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                YBImageBrowser *browser = [YBImageBrowser new];
                browser.delegate = self;
                browser.dataArray = tempArr;
                browser.albumArr = self->_imgArr;
                browser.infoid = self->_infoid;
                browser.currentIndex = num;
                [browser show];
            }
        };
        return header;
    }else{
//
        
        TitleBaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleBaseHeader"];
        if (!header) {
            
            header = [[TitleBaseHeader alloc] initWithReuseIdentifier:@"TitleBaseHeader"];
        }
        if (section == 1) {
            
            header.titleL.text = @"小区其他户型";
        }else{
            
            header.titleL.text = @"户型房源";
        }
        
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    
        NewRoomHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomHouseInfoCell"];
        if (!cell) {
            
            cell = [[NewRoomHouseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomHouseInfoCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeL.text = _baseInfoDic[@"house_type_name"];
        cell.areaL.text = [NSString stringWithFormat:@"建筑面积：%@㎡-%@㎡",_baseInfoDic[@"property_area_min"],_baseInfoDic[@"property_area_max"]];
        cell.titleL.text = @"户型卖点";
        cell.contentL.text = _baseInfoDic[@"sell_point"];
        
        return cell;
    }else{
        
        NewRoomProjectHouseTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRoomProjectHouseTypeCell"];
        if (!cell) {
            
            cell = [[NewRoomProjectHouseTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewRoomProjectHouseTypeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.num = _houseArr.count;
        if (_houseArr.count) {
            
            cell.dataArr = [NSMutableArray arrayWithArray:_houseArr];
            [cell.cellColl reloadData];
        }else{
            
            [cell.cellColl reloadData];
        }
        
        cell.collCellBlock = ^(NSInteger index) {
            
            if (self->_houseArr.count) {
                NewRoomHouseDetailVC *nextVC = [[NewRoomHouseDetailVC alloc]initWithHouseTypeId:[NSString stringWithFormat:@"%@",self->_houseArr[index][@"id"]] index:index dataArr:self->_houseArr projectId:self->_projectId infoid:@""];
                
                //                    nextVC.model = _model;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        };
        return cell;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"户型详情";
    self.line.hidden = YES;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.estimatedRowHeight = 150 *SIZE;
    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable.estimatedSectionHeaderHeight = 200 *SIZE;
    _houseTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
}

//- (TransmitView *)transmitView{
//
//    if (!_transmitView) {
//
//        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
//        WS(weakSelf);
//        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
//
//            if (index == 0) {
//
//                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
//
//                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
//                }else{
//
//                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
//                }
//            }else if (index == 1){
//
//                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
//
//                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
//                }else{
//
//                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
//                }
//            }else if (index == 2){
//
//                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
//
//                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
//                }else{
//
//                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
//                }
//            }else{
//
//                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
//
//                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
//                }else{
//
//                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
//                }
//            }
//
//        };
//    }
//    return _transmitView;
//}
//
////
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"【云渠道】%@(%@)邀请您参观【%@】",[UserInfoModel defaultModel].name,[UserInfoModel defaultModel].tel,_model.project_name]  thumImage:[UIImage imageNamed:@"shareimg"]];
//    //设置网页地址
//    shareObject.webpageUrl = _url;
//
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    if (platformType == UMSocialPlatformType_WechatTimeLine) {
//        shareObject.title = [NSString stringWithFormat:@"【云渠道】%@(%@)邀请您参观【%@】",[UserInfoModel defaultModel].name,[UserInfoModel defaultModel].tel,_model.project_name];
//    }
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            //            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            //            NSLog(@"response data is %@",data);
//            [self showContent:@"分享成功"];
//            [self.transmitView removeFromSuperview];
//        }
//    }];
//}

@end
