//
//  AutoScrollView.h
//  天巢新1期
//
//  Created by tangjp on 15/12/12.
//  Copyright © 2015年 tangjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoScrollViewDelegate<NSObject>
@optional
/** 这本质上是一个collectionView 只有item,没有row */
-(void)Auto_scrollView:(UICollectionView *)scrollView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)Auto_scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface AutoScrollView : UICollectionView <UICollectionViewDataSource , UICollectionViewDelegate>
@property (nonatomic ,strong) NSArray *images;
@property(nonatomic,assign)id <AutoScrollViewDelegate>Auto_delegate;

@end
