//
//  NextCell.h
//  TextFieldMultiDemo
//
//  Created by wanglidan on 16/10/19.
//  Copyright © 2016年 wanglidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextModel.h"


@interface NextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NextModel *model;

@end
