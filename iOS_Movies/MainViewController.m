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
    DataBaseManager *DBManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DBManager = [DataBaseManager sharedDBManager];
    [DBManager createTable];
    NSUserDefaults *movieIDeez = [NSUserDefaults standardUserDefaults];
    NSArray * myIdeez = [movieIDeez objectForKey:@"ideez"];
    if(myIdeez.count == 0)
            {
                NSMutableArray * ideez = [NSMutableArray new];
                [movieIDeez setObject:ideez forKey:@"ideez"];
                [movieIDeez synchronize];
            }
    
    allMovies = [NSMutableArray new];
    allMovies = [DBManager selectAllMovie];

    if(allMovies.count==0){
baseUrl = @"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
    
    [self getAllMovies:baseUrl];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sort:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sort"
                                                        message:@"Sort Your Movies By "
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Top Rated",@"Most Popular", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        baseUrl = @"https://api.themoviedb.org/3/movie/top_rated?api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
        allMovies = [NSMutableArray new];
        [self getAllMovies:baseUrl];
    }
    else if(buttonIndex == 2)
    {
        baseUrl = @"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
        allMovies = [NSMutableArray new];
        [self getAllMovies:baseUrl];
    }
    
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
                    NSString * sID = [NSString stringWithFormat:@"%ld", myID];
                    if([sID isEqualToString:@"550"]){
                        continue;
                    }
                    NSString *myTitle =[object objectForKey:@"original_title"];
                    NSString *img= @"https://image.tmdb.org/t/p/w185";
                    NSString *myImage =[img stringByAppendingString:[object objectForKey:@"poster_path"]];
                    long myRates = [[object objectForKey:@"vote_average"]longValue];
                    NSString * myRate = [NSString stringWithFormat:@"%ld", myRates];
                    NSString *myDate = [object objectForKey:@"release_date"];
                    NSString *myOverView = [object objectForKey:@"overview"];
                    [self getTrailers:sID];
                    [self->movie setID:sID andTitle:myTitle andDate:myDate andRate:myRate andImage:myImage andOverview:myOverView];
                    
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
}

- (void)getTrailers:(NSString*)ID{
    NSString* videoUrl1 = @"https://api.themoviedb.org/3/movie/";
    NSString* videoUrlID = [videoUrl1 stringByAppendingString:ID];
    NSString* videoUrl2 = @"/videos?api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
    NSString* videoUrl=[videoUrlID stringByAppendingString:videoUrl2];
    NSURL *vidURL = [[NSURL alloc] initWithString:videoUrl];
    AFHTTPSessionManager *videoManager   = [AFHTTPSessionManager manager];
    [videoManager    GET:vidURL.absoluteString
              parameters:nil
                progress:nil
                 success:^(NSURLSessionTask *task, id responseObject) {
                     NSDictionary *result =[responseObject objectForKey:@"results"];
                     int i = 0;
                     for (NSDictionary * object in result) {
                         i++;
                         NSString * myTrail = @"https://www.youtube.com/watch?v=";
                         if(i==1){
                             NSString * myTrailer1 = [myTrail stringByAppendingString:[object objectForKey:@"key"]];
                             for (Movie *m in self->allMovies){
                                 if(m.ID == ID){
                                 [m setTrail1:myTrailer1];
                                     break;
                                 }
                             }
                         }
                         NSString * myTrailer2 = [myTrail stringByAppendingString:[object objectForKey:@"key"]];
//                         for (Movie *m in self->allMovies){
//                            if( m.ID == ID)
//                             [m setTrail2:myTrailer2];
//                         }
                         for (int j = 0; j<self->allMovies.count; j++) {
                             if([[[self->allMovies objectAtIndex:j] ID] isEqualToString:ID]){
                             [[self->allMovies objectAtIndex:j] setTrailer2:myTrailer2];
                                 break;
                             }
                         }
                         if(i>2)
                             break;
                     }
                     for (Movie * m in self->allMovies){
                         printf("%s\n",[m.trailer2 UTF8String]);
                         
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
    for (Movie * m in self->allMovies){
        [self->DBManager insertMovie:m];
    }
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
