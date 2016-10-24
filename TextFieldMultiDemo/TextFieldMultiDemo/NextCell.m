//
//  NextCell.m
//  TextFieldMultiDemo
//
//  Created by wanglidan on 16/10/19.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

#import "NextCell.h"

@interface NextCell ()<UITextViewDelegate>

@property (nonatomic, assign) CGFloat textViewWidth;
@property (nonatomic, assign) CGFloat textViewHeight;
@property (nonatomic, assign) CGFloat height;

@end

@implementation NextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addObserver];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _textView.delegate = self;
    
    _textView.textContainerInset = UIEdgeInsetsZero;
    _textView.textContainer.lineFragmentPadding = 0;
    _textView.text = @"哈哈哈哈我们人时纷纷年跌";
    
    [self layoutIfNeeded];
    _textViewWidth = _textView.frame.size.width;
    _textViewHeight = _textView.frame.size.height;
    
}
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)setModel:(NextModel *)model
{
    _model = model;
    _label.text = _model.title;
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect textRect = [textView.text boundingRectWithSize:CGSizeMake(textView.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat textHeight = textRect.size.height;
    if (textHeight > _textViewHeight) {
        NSInteger row = textHeight / _textViewHeight + 1;
        _height = _textViewHeight * row;
    }else{
        _height = 17;
    }
    _model.height = _height + 26 + 2;

    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
    
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
#pragma mark - Noti

- (void)handleKeyboardWillShow:(NSNotification *)note
{
    if (!_textView.isFirstResponder) {
        return;
    }
    UITableView *tableView = [self tableView];
    
    NSDictionary *info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    tableView.contentInset = UIEdgeInsetsMake(64, 0.0, kbSize.height+10, 0.0);
    [tableView layoutIfNeeded];
    
    NSIndexPath *index = [tableView indexPathForCell:self];
    
    [tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)handleKeyboardWillHide:(NSNotification *)note
{
    if (!_textView.isFirstResponder) {
        return;
    }
    UITableView *tableView = [self tableView];
    [tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
