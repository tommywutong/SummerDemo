//
//  PhotoWallVC.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/10.
//

#import "PhotoWallVC.h"

#define kPhotoSpacing 15
#define kPhotoWidth ((self.view.frame.size.width - kPhotoSpacing * 4) / 3)

@interface PhotoWallVC ()

@end

@implementation PhotoWallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择头像";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *photoNames = @[@"photo1.jpg", @"photo2.jpg", @"photo3.jpg",
                           @"photo4.jpg", @"photo5.jpg", @"photo6.jpg",
                           @"photo7.jpg", @"photo8.jpg", @"photo9.jpg"];
    
    for (int i = 0; i < 9; i++) {
        int row = i / 3;
        int col = i % 3;
        
        CGFloat x = kPhotoSpacing + col * (kPhotoWidth + kPhotoSpacing);
        CGFloat y = 100 + row * (kPhotoWidth + kPhotoSpacing);
        
        UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        photoBtn.frame = CGRectMake(x, y, kPhotoWidth, kPhotoWidth);
        photoBtn.tag = i;
        [photoBtn setImage:[UIImage imageNamed:photoNames[i]] forState:UIControlStateNormal];
        photoBtn.layer.cornerRadius = kPhotoWidth/2;
        photoBtn.layer.masksToBounds = YES;
        photoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        photoBtn.layer.borderWidth = 2;
        [photoBtn addTarget:self action:@selector(photoSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:photoBtn];
    }
}

- (void)photoSelected:(UIButton *)sender {
    UIImage *selectedImage = sender.currentImage;
    
    if ([self.delegate respondsToSelector:@selector(didSelectAvatar:)]) {
        [self.delegate didSelectAvatar:selectedImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
