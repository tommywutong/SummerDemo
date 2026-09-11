//
//  CitiesDetailViewController.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/25.
//

#import "CitiesDetailViewController.h"
#import "DetailViewController.h"
@interface CitiesDetailViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray<NSString *> *cities;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UIButton* backButton;
@end

@implementation CitiesDetailViewController

-(id) init  {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                      options:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    self.cities = self.cityNames;
    self.currentIndex = self.initialIndex;
    DetailViewController *initialVC = [self detailViewControllerForIndex:self.initialIndex];
    [self setViewControllers:@[initialVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)backButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)updatePageIndicator {
    self.pageControl.currentPage = self.currentIndex;
    self.navigationItem.title = self.cities[self.currentIndex];
}

/*
 分别获取前一个和后一个VC
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [(DetailViewController *)viewController index];
    //不是第一个就去上一个
    if (index > 0) {
        return [self detailViewControllerForIndex:index - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [(DetailViewController *)viewController index];
    if (index < self.cities.count - 1) {
        return [self detailViewControllerForIndex:index + 1];
    }
    return nil;
}

- (DetailViewController *)detailViewControllerForIndex:(NSInteger)index {
    if (index < 0 || index >= self.cities.count) return nil;
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.cityName = self.cities[index];
    detailVC.index = index;
    detailVC.canAddCity = NO;
    return detailVC;
}

- (void)deleteCurrentCity {
    if (self.cities.count == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    // 获取当前显示的视图控制器
    DetailViewController *currentVC = (DetailViewController *)self.viewControllers.firstObject;
    NSInteger currentIndex = currentVC.index;
    if (currentIndex >= self.cities.count) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }

    NSString *cityName = self.cities[currentIndex];
    NSDictionary *userInfo = @{@"cityName": cityName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteCityNotification"
                                                        object:nil
                                                      userInfo:userInfo];
    NSMutableArray *mutableCities = [self.cities mutableCopy];
    [mutableCities removeObjectAtIndex:currentIndex];
    self.cities = [mutableCities copy];
    if (self.cities.count == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    NSInteger newIndex;
    if (currentIndex >= self.cities.count) {
        newIndex = self.cities.count - 1;
    } else {
        newIndex = currentIndex;
    }
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (newIndex < currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    DetailViewController *newVC = [self detailViewControllerForIndex:newIndex];
    if (newVC) {
        [self setViewControllers:@[newVC]
                       direction:direction
                        animated:YES
                      completion:nil];
        self.currentIndex = newIndex;
    }
}
@end
