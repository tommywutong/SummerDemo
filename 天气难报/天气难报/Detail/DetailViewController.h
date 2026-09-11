//
//  DetailViewController.h
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary* weatherData;
@property (nonatomic, strong) NSString* cityName;
@property (nonatomic, strong) UIImageView* backgroundImageView;
@property (nonatomic, strong) UILabel *feelsLikeLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL canAddCity;
@end

NS_ASSUME_NONNULL_END
