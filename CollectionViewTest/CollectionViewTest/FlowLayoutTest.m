//
//  FlowLayoutTest.m
//  CollectionViewTest
//
//  Created by most on 2017/12/20.
//  Copyright © 2017年 most. All rights reserved.
//

#import "FlowLayoutTest.h"

@interface FlowLayoutTest()<UICollectionViewDelegate>
@end
@implementation FlowLayoutTest


- (void)prepareLayout{
    
    [super prepareLayout];
    
    //最小行间距
    self.minimumLineSpacing =10;
    //最小列间距
    self.minimumInteritemSpacing =10;
    // cell 的大小
    self.itemSize =CGSizeMake(100,100);
    // 流式布局的方向
    self.scrollDirection =UICollectionViewScrollDirectionVertical;
    // header的size
    self.headerReferenceSize =CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    // footer的size
    self.footerReferenceSize =CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    //collectionview 分区的边距
    self.sectionInset = UIEdgeInsetsMake(10, 40, 100, 30);
    
}

@end
