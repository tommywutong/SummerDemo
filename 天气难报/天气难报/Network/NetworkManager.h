//
//  NetworkManager.h
//  天气难报
//
//  Created by 吴桐 on 2025/7/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchCityWeather:(NSString *)cityName 
                        completion:(void(^)(NSDictionary * _Nullable weatherData, NSError * _Nullable error))completion;

- (void)fetchCityForecast:(NSString *)cityName 
                        days:(NSInteger)days 
                  completion:(void(^)(NSDictionary * _Nullable weatherData, NSError * _Nullable error))completion;

- (void)searchCities:(NSString *)keyword 
                     completion:(void(^)(NSArray * _Nullable cities, NSError * _Nullable error))completion;

- (void)loadImageWithURL:(NSString *)urlString 
                    completion:(void(^)(UIImage * _Nullable image, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
