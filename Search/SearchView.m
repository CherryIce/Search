//
//  SearchView.m
//  Search
//
//  Created by WXL-TECH on 2017/10/31.
//  Copyright © 2017年 WXL-TECH. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField * textfield;

@property (nonatomic,retain) UIImageView * imageView;

@end

@implementation SearchView

- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2.5, 25, 25)];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

- (UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, self.bounds.size.width - 50, self.bounds.size.height)];
        _textfield.delegate = self;
    }
    return _textfield;
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
    [self addSubview:self.imageView];
    [self addSubview:self.textfield];
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
    self.textfield.placeholder = placeholder;
}

/**
 走这里就跳转到下个页面
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[self.textfield resignFirstResponder];
    [self endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_searchPushCall) {
            _searchPushCall();
        }
    });
    return YES;
}

@end
