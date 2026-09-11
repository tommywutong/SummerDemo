//
//  CitiesDetailViewController.h
//  天气难报
//
//  Created by 吴桐 on 2025/7/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CitiesDetailViewController : UIPageViewController

@property (nonatomic, strong) NSArray<NSString *> *cityNames;
@property (nonatomic, assign) NSInteger initialIndex;

@end

NS_ASSUME_NONNULL_END
