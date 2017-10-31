//
//  HistoryKeyViewCell.m
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import "HistoryKeyViewCell.h"

@implementation HistoryKeyViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deleteCurrentKey:(UIButton *)sender
{
    if (_deleteCurrentKeywordCall) {
        _deleteCurrentKeywordCall();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
