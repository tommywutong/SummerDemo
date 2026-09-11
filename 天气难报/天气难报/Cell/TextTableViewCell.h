//
//  textTableViewCell.h
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, strong) UIImageView *weatherIcon;
@property (nonatomic, strong) UIImageView *backgroundImageView;
- (void)configureWithCity:(NSString *)city
                    temp:(NSString *)temp
         weatherIconURL:(NSString *)iconURL
           conditionCode:(NSInteger)code;
@end


NS_ASSUME_NONNULL_END
