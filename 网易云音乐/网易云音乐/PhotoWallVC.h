//
//  PhotoWallVC.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/10.
//

// PhotoWallVC.h
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoWallDelegate <NSObject>
- (void)didSelectAvatar:(UIImage *)selectedAvatar;
@end

@interface PhotoWallVC : UIViewController
@property (nonatomic, weak) id<PhotoWallDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
