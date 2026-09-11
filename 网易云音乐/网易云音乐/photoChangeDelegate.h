//
//  photoChangeDelegate.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/11.
//

#ifndef photoChangeDelegate_h
#define photoChangeDelegate_h

@class PhotoWallVC; 
@protocol photoChangeDelegate <NSObject>

- (void)viewController:(JCFourth*)controller didSelectImage:(UIImage *)image;

@end

#endif
