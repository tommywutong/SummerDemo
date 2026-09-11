//
//  HolidayDetailTableViewCell.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/16.
//

#import <UIKit/UIKit.h>


@interface HolidayDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *detailImageView;
@property (nonatomic, strong)UILabel* textName;
@property (nonatomic, strong)UILabel* writerName;
@property (nonatomic, strong)UILabel* timeLabel;

@property (nonatomic, strong)UIImageView* viewingIcon;
@property (nonatomic, strong)UIImageView* shareIcon;
@property (nonatomic, strong)UIImageView* avater;

@property (nonatomic, strong)UILabel* artLabel;
@property (nonatomic, strong)UIImageView* worksView1;
@property (nonatomic, strong)UIImageView* worksView2;
@property (nonatomic, strong)UIImageView* worksView3;
@property (nonatomic, strong)UIImageView* worksView4;

- (void)configureWithImage:(UIImage *)image;

@end
