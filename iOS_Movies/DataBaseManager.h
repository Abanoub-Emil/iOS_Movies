//
//  DataBaseManager.h
//  iOS_Movies
//
//  Created by Champion on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"
@interface DataBaseManager : NSObject

+ (instancetype) sharedDBManager;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@property (strong,nonatomic) NSString * dataBasePath;
@property (nonatomic) sqlite3 * contactDB;

- (void) createTable;
- (void) insertMovie:(Movie *)movie;
- (Movie*) selectMovie:(NSString *)ID;
- (NSMutableArray*) selectAllMovie;
@end
