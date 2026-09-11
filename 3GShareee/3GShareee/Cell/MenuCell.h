//
//  MenuCell.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configureWithIcon:(UIImage *)icon title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
