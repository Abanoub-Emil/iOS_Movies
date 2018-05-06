//
//  Movie.h
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property NSString* ID;
@property NSString * title;
@property NSString * date;
@property NSString * rate;
@property NSString * image;
@property NSString * trailer1;
@property NSString * trailer2;
@property NSString * overView;

- (void) setID:(NSString*)ID andTitle:(NSString *)title andDate:(NSString *)date andRate:(NSString *)rate andImage:(NSString *)image andOverview:(NSString*)overview;

- (void) setTrail1:(NSString*)trailer1;
- (void) setTrail2:(NSString*)trailer2;

@end
