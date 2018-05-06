//
//  MainViewController.h
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import "Movie.h"
#import "ViewController.h"
@interface MainViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * allMovies ;
    Movie * movie;
}
- (void)getAllMovies:(NSString*)url;
- (void)getTrailers:(long)ID;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@end
