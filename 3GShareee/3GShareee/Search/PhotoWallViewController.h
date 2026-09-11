//
//  PhotoWallViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import <UIKit/UIKit.h>
#import "PlusViewController.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PhotoWallDelegate <NSObject>

- (void)changedPhotoName: (NSString *)nameOfPhoto andNumber: (int)numbersOfPhoto;

@end

@interface PhotoWallViewController : UIViewController
@property (nonatomic, assign) id<PhotoWallDelegate> delegate;
@property (nonatomic, strong) UIButton* photoButton;
@property (nonatomic, strong) UIImage* photoImage;
@property (nonatomic, strong) UIScrollView* photoWallScrollView;
@property (nonatomic, strong) NSMutableArray* imageNameArray;
@property (nonatomic, assign) int numbersOfPhoto;
@end



NS_ASSUME_NONNULL_END
