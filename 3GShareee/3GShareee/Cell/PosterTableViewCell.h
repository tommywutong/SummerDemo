//
//  PosterTableViewCell.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PosterTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *titleLabel; 

- (void)configureCellWithImage:(UIImage *)image text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
