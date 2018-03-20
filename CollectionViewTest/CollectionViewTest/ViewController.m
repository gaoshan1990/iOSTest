//
//  ViewController.m
//  CollectionViewTest
//
//  Created by most on 2017/12/20.
//  Copyright © 2017年 most. All rights reserved.
//

#import "ViewController.h"
#import "FlowLayoutTest.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionview;

@end

static NSString *const cellID = @"CollectionViewID";
static NSString *const SectionHeaderID = @"CollectionViewHeaderID";/* 顶部视图用这个 */
static NSString *const SectionFooterID = @"CollectionViewFooterID";/* 底部视图用这个 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];

}

- (void)initCollectionView{
    
    
    FlowLayoutTest * layout = [[FlowLayoutTest alloc] init];;
    
    self.collectionview  =[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionview.backgroundColor  =[UIColor whiteColor];
    self.collectionview.delegate =self;
    self.collectionview.dataSource =self;
 
    [self.view addSubview:self.collectionview];
    
    //注册cell
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    //注册sectionHeader
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SectionHeaderID];
    //注册sectionFooter
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SectionFooterID];

}

#pragma mark--- UICollectionViewFlowLayoutDelegate
//item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 100);
}
//设置分区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section ==1) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else if(section ==2){
        return UIEdgeInsetsMake(30, 20, 10, 30);
        
    }
    return UIEdgeInsetsZero;
}
//最小行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
}
//设置Header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}
//设置Footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
    
}



//- (BOOL)shouldInvalidateLayoutForPreferredLayoutAttributes:(UICollectionViewLayoutAttributes *)preferredAttributes withOriginalAttributes:(UICollectionViewLayoutAttributes *)originalAttributes NS_AVAILABLE_IOS(8_0){
//
//}
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForPreferredLayoutAttributes:(UICollectionViewLayoutAttributes *)preferredAttributes withOriginalAttributes:(UICollectionViewLayoutAttributes *)originalAttributes NS_AVAILABLE_IOS(8_0){
//
//}
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//}
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset NS_AVAILABLE_IOS(7_0){
//
//}

#pragma mark--- UICollectionViewDataSourceDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}
//返回UICollectionView
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell  *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.backgroundColor =[UIColor redColor];
    
    return cell;
}

//设置collectionView的头部和脚部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView  *header  =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SectionHeaderID forIndexPath:indexPath];
        
        UILabel  *headerLabel  =[[UILabel alloc] init];
        headerLabel.frame  =  header.bounds;
        headerLabel.text =@"-------流式布局--------";
        for (UIView *tempView in header.subviews  ) {
            
            if ([tempView isKindOfClass:[UILabel class]]) {
                [tempView removeFromSuperview];
            }
        }
        [header addSubview:headerLabel];
        header.backgroundColor =[UIColor yellowColor];
        return header;

        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        UICollectionReusableView  *footer  =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SectionFooterID forIndexPath:indexPath];
        
        footer.backgroundColor =[UIColor greenColor];
        return footer;

    }
    
    return nil;
}

@end
