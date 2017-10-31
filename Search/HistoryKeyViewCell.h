//
//  HistoryKeyViewCell.h
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^deleteCurrentKeywordCallBack)(void);

@interface HistoryKeyViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,copy) deleteCurrentKeywordCallBack deleteCurrentKeywordCall;

@end
