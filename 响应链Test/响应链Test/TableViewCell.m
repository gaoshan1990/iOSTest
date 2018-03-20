//
//  TableViewCell.m
//  响应链Test
//
//  Created by most on 2018/3/14.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TableViewCell.h"
#import "UIResponder+Extension.h"
@interface TableViewCell()

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)cellButtonClick:(UIButton *)sender {
    
    
    [self routerEvent:[NSString stringWithFormat:@"%ld",sender.tag]];
    
    UIResponder  *next =  [self nextResponder];
    
    NSMutableString * prefix = @"".mutableCopy;
    
    while (next != nil) {
        NSLog(@"%@%@", prefix, [next class]);
        [prefix appendString: @"--"];
        next = [next nextResponder];
    }

    return;
    if (self.cellBack) {
      
        self.cellBack(sender.tag);

}

}



@end
