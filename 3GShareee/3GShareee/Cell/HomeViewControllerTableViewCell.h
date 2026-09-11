//
//  FirstVCTableViewCell.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewControllerTableViewCell : UITableViewCell

@property (nonatomic,strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
