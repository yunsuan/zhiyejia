//
//  UITableView+EmptyData.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void)tableViewDisplayWitMessage:(NSString *)message Img:(NSString *)img ifNecessaryForRowCount:(NSUInteger)rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，label和img
        UIView *view = [[UIView alloc] init]; //[UILabel new];
        view.backgroundColor = CLWhiteColor;
        view.frame = self.bounds;
        
        UIImageView *imgView = [UIImageView new];
        imgView.image = IMAGE_WITH_NAME(img);
        imgView.frame = CGRectMake(0, 0, SCREEN_Width, CGRectGetHeight(self.bounds) / 2 - 10 *SIZE);
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgView];
        
        UILabel *label = [UILabel new];
//        label.center = self.center;
        label.frame = CGRectMake(10 *SIZE, CGRectGetMidY(self.bounds) - 10 *SIZE, SCREEN_Width - 20 *SIZE, 20 *SIZE);
        label.text = message;
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
//        [label sizeToFit];
        [view addSubview:label];
 
        self.backgroundView = view;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        
        self.backgroundView = nil;
    }
}

@end
