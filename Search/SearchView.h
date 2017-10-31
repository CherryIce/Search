//
//  SearchView.h
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchPushCallBack)(void);

@interface SearchView : UIView

@property (nonatomic,copy) NSString * imageName;

@property (nonatomic,copy) NSString * placeholder;

@property (nonatomic,copy) searchPushCallBack  searchPushCall;


@end
