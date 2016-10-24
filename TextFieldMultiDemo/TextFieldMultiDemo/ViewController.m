//
//  ViewController.m
//  TextFieldMultiDemo
//
//  Created by wanglidan on 16/10/19.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightCons;
@property (nonatomic, assign) CGFloat textViewWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textView.delegate = self;
    _textView.textContainerInset = UIEdgeInsetsZero;
    _textView.textContainer.lineFragmentPadding = 0;
    _textView.text = @"这是一个textView这是一个textView";
    
    [self.view layoutIfNeeded];
    _textViewWidth = _textView.frame.size.width;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect textRect = [textView.text boundingRectWithSize:CGSizeMake(10000, textView.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat textWidth = textRect.size.width;
    if (textWidth > _textViewWidth) {
        NSInteger row = textWidth / _textViewWidth + 1;
        _textViewHeightCons.constant = textRect.size.height * row + 5;
    }else{
        _textViewHeightCons.constant = 20;
    }
}
- (IBAction)buttonAction:(id)sender {
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
