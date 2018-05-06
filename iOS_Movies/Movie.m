//
//  Movie.m
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (void) setID:(long)ID andTitle:(NSString *)title andDate:(NSString *)date andRate:(NSString *)rate andImage:(NSString *)image andOverview:(NSString*)overview{
    self.ID=ID;
    self.title=title;
    self.date=date;
    self.rate=rate;
    self.overView=overview;
    self.image=image;
}

- (void) setTrail1:(NSString*)trailer1{
    self.trailer1=trailer1;
}
- (void) setTrail2:(NSString*)trailer2{
    self.trailer2=trailer2;
}
@end
