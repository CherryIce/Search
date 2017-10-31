//
//  SearchNavBar.h
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchCancleCallBack)(void);

typedef void(^searchKeyWordCallBack)(NSString * keyword);

@interface SearchNavBar : UIView

@property (nonatomic,copy) NSString * placeholder;

@property (nonatomic,copy) NSString * imageName;

@property (nonatomic,copy) searchCancleCallBack  searchCancleCall;

@property (nonatomic,copy) searchKeyWordCallBack  searchKeyWordCall;

@end
