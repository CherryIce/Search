//
//  SearchNavBar.m
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import "SearchNavBar.h"

@interface SearchNavBar ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView * backView;

@property (nonatomic,strong) UITextField *tf;

@property (nonatomic,retain) UIImageView * imageView;

@property (nonatomic,strong) UIButton * cancle;

@end

@implementation SearchNavBar

- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, [[UIApplication sharedApplication] statusBarFrame].size.height + 7, self.bounds.size.width - 70, 30)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        _backView.clipsToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2.5, 25, 25)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

- (UITextField *)tf
{
    if (!_tf) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, self.bounds.size.width - 110, 30)];
        _tf.delegate = self;
        [_tf becomeFirstResponder];
    }
    return _tf;
}

- (UIButton *)cancle
{
    if (!_cancle) {
        _cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancle setFrame:CGRectMake(self.bounds.size.width - 60, [[UIApplication sharedApplication] statusBarFrame].size.height + 7, 50, 30)];
        [_cancle setTintColor:[UIColor whiteColor]];
        [_cancle setTitle:@"取消" forState:UIControlStateNormal];
        [_cancle addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancle;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.imageView];
    [self.backView addSubview:self.tf];
    [self addSubview:self.cancle];
}

/**
 点击取消
 **/
- (void) cancleClick
{
    [self endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_searchCancleCall) {
            _searchCancleCall();
        }
    });
}

/**
 完成编辑开始搜索
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_searchKeyWordCall) {
            _searchKeyWordCall(textField.text);
        }
    });
    return YES;
}

/**
 set方法给图
 */
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}

/**
 set方法给placeholder
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.tf.placeholder = placeholder;
}

@end
