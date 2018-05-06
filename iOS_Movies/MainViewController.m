//
//  MainViewController.m
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController{
    NSString * baseUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    allMovies = [NSMutableArray new];
    
baseUrl = @"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
    
    [self getAllMovies:baseUrl];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllMovies:(NSString*)url{
    NSURL *URL = [[NSURL alloc] initWithString:baseUrl];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:URL.absoluteString
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *results =[responseObject objectForKey:@"results"];
                for (NSDictionary * object in results) {
                    self->movie = [Movie new];
                    long myID = [[object objectForKey:@"id"]longValue];
//                    printf("%ld\n",myID);
                    NSString *myTitle =[object objectForKey:@"original_title"];
                    NSString *img= @"https://image.tmdb.org/t/p/w185";
                    NSString *myImage =[img stringByAppendingString:[object objectForKey:@"poster_path"]];
                    long myRates = [[object objectForKey:@"vote_average"]longValue];
                    NSString * myRate = [NSString stringWithFormat:@"%ld", myRates];
//                    printf("%s\n",[myRate UTF8String] );
                    NSString *myDate = [object objectForKey:@"release_date"];
                    NSString *myOverView = [object objectForKey:@"overview"];
                    [self getTrailers:myID];
                    [self->movie setID:myID andTitle:myTitle andDate:myDate andRate:myRate andImage:myImage andOverview:myOverView];
                    
                    [self->allMovies addObject:self->movie];
                }
                
                
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
    
}

- (void) printData{
    [self.myCollection reloadData];
    for (Movie * m in allMovies){
        printf("%s\n",[m.title UTF8String]);
        printf("%s\n",[m.rate UTF8String]);
        printf("%s\n",[m.image UTF8String]);
        printf("%s\n",[m.overView UTF8String]);
        printf("%s\n",[m.trailer1 UTF8String]);
        printf("%s\n",[m.trailer2 UTF8String]);
    }
}

- (void)getTrailers:(long)ID{
    NSString* videoUrl1 = @"https://api.themoviedb.org/3/movie/";
    NSString * sID = [NSString stringWithFormat:@"%ld", ID];
    NSString* videoUrlID = [videoUrl1 stringByAppendingString:sID];
    NSString* videoUrl2 = @"/videos?api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
    NSString* videoUrl=[videoUrlID stringByAppendingString:videoUrl2];
//    printf("%s\n",[videoUrl UTF8String]);
    NSURL *vidURL = [[NSURL alloc] initWithString:videoUrl];
    AFHTTPSessionManager *videoManager   = [AFHTTPSessionManager manager];
    [videoManager    GET:vidURL.absoluteString
              parameters:nil
                progress:nil
                 success:^(NSURLSessionTask *task, id responseObject) {
                     NSDictionary *result =[responseObject objectForKey:@"results"];
//                     NSLog(@"Error: %@", responseObject);
                     int i = 0;
                     for (NSDictionary * object in result) {
                         i++;
                         NSString * myTrail = @"https://www.youtube.com/watch?v=";
                         if(i==1){
                             NSString * myTrailer1 = [myTrail stringByAppendingString:[object objectForKey:@"key"]];
                             for (Movie *m in self->allMovies){
                                 if(m.ID == ID)
                                 [m setTrail1:myTrailer1];
                             }
                         }
                         NSString * myTrailer2 = [myTrail stringByAppendingString:[object objectForKey:@"key"]];
                         for (Movie *m in self->allMovies){
                            if( m.ID == ID)
                             [m setTrail2:myTrailer2];
                         }
                         if(i>2)
                             break;
                     }
                    [self printData];
                     
                 }
                 failure:^(NSURLSessionTask *operation, NSError *error) {
                     NSLog(@"Error: %@", error);
                 }
     ];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return allMovies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    Movie * cellMovie =[allMovies objectAtIndex:indexPath.row];
    UIImageView * myImage = [cell viewWithTag:1];
    [myImage sd_setImageWithURL:[NSURL URLWithString:cellMovie.image]
               placeholderImage:nil];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewController * detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsView"];
    Movie * movieDetails;
    movieDetails = [allMovies objectAtIndex:indexPath.row];
    detailsView.movieDetail=movieDetails;
    [self.navigationController pushViewController:detailsView animated:YES ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
