//
//  DataBaseManager.m
//  iOS_Movies
//
//  Created by Champion on 5/6/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

+ (id) sharedDBManager
{
    static dispatch_once_t onceToken;
    static DataBaseManager *single;
    dispatch_once(&onceToken, ^{
        single = [[[self class] alloc] init];
    });
    
    return single;
}


- (void) createTable{
    
    NSArray * dirPath;
    NSString * docsDir;
    
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    docsDir = dirPath[0];
    
    _dataBasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"contacts.db"]];
    const char * dbPath = [_dataBasePath UTF8String];
    
    if(sqlite3_open(dbPath,&_contactDB)==SQLITE_OK){
        char *errMsg;
        const char * sql_stmt="CREATE TABLE IF NOT EXISTS MOVIES (ID INTEGER PRIMARY KEY, TITLE TEXT , DATE TEXT , RATE TEXT , IMAGE TEXT, OVERVIEW TEXT, TRAILER1 TEXT, TRAILER2 TEXT)";
        if(sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK){
            printf("Can't Create Table");
        }
        sqlite3_close(_contactDB);
    }else{
        printf("Failed to Create Database");
    }
}

- (void) insertMovie:(Movie *)movie{
    
    const char * dbPath = [_dataBasePath UTF8String];
    sqlite3_stmt * statment ;
    if(sqlite3_open(dbPath,&_contactDB)==SQLITE_OK){
        
        NSString * insertSql = [NSString  stringWithFormat:@"INSERT INTO MOVIES (ID, TITLE, DATE, RATE, IMAGE, OVERVIEW, TRAILER1, TRAILER2) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",movie.ID, movie.title,movie.date,movie.rate,movie.image,movie.overView,movie.trailer1,movie.trailer2];
        
        const char * insertStmt = [insertSql UTF8String];
        sqlite3_prepare_v2(_contactDB,insertStmt,-1,&statment,NULL);
        if(sqlite3_step(statment)==SQLITE_DONE){
            
        }else{
        }
        sqlite3_finalize(statment);
        sqlite3_close(_contactDB);
    }
    
}

- (Movie *) selectMovie:(NSString *)ID{
    Movie * movie = [Movie new];
    const char * dbPath = [_dataBasePath UTF8String];
    sqlite3_stmt * statment ;
    if(sqlite3_open(dbPath,&_contactDB)==SQLITE_OK){
        NSString * querySQL = [NSString stringWithFormat:@"SELECT * FROM MOVIES WHERE ID = '%@'",ID];
        const char * queryStmt = [querySQL UTF8String];
        if(sqlite3_prepare_v2(_contactDB,queryStmt,-1,&statment,NULL)==SQLITE_OK){
            while (sqlite3_step(statment)==SQLITE_ROW) {
                
                movie.ID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,0)];
                movie.title = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,1)];
                movie.date = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,2)];
                movie.rate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,3)];
                movie.image = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,4)];
                movie.overView = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,5)];
                movie.trailer1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,6)];
                movie.trailer2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,7)];
                
            }
        }else{
            printf("SELECT failed");
        }
        sqlite3_finalize(statment);
    }
    sqlite3_close(_contactDB);
    return movie;
}

- (NSMutableArray*) selectAllMovie{
    NSMutableArray * allMovies = [NSMutableArray new];
    const char * dbPath = [_dataBasePath UTF8String];
    sqlite3_stmt * statment ;
    if(sqlite3_open(dbPath,&_contactDB)==SQLITE_OK){
        NSString * querySQL = [NSString stringWithFormat:@"SELECT * FROM MOVIES"];
        const char * queryStmt = [querySQL UTF8String];
        if(sqlite3_prepare_v2(_contactDB,queryStmt,-1,&statment,NULL)==SQLITE_OK){
            while (sqlite3_step(statment)==SQLITE_ROW) {
                Movie * movie = [Movie new];
                movie.ID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,0)];
                movie.title = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,1)];
                movie.date = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,2)];
                movie.rate = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,3)];
                movie.image = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,4)];
                movie.overView = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,5)];
                movie.trailer1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,6)];
                movie.trailer2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statment,7)];
                [allMovies addObject:movie];
            }
        }else{
            printf("SELECT failed");
        }
        sqlite3_finalize(statment);
    }
    sqlite3_close(_contactDB);
    return allMovies;
}
@end
