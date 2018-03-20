//
//  TableViewCell.h
//  响应链Test
//
//  Created by most on 2018/3/14.
//  Copyright © 2018年 most. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cellButtonClick)(NSInteger index);
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

@property(copy,nonatomic) cellButtonClick cellBack;
@end
