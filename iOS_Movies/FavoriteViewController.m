//
//  FavoriteViewController.m
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController{
    NSMutableArray * ideez ;
    NSMutableArray * favMovies;
    DataBaseManager *DBManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   ideez = [NSMutableArray new];
    
    DBManager = [DataBaseManager sharedDBManager];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    favMovies = [NSMutableArray new];
    NSUserDefaults *movieIDeez = [NSUserDefaults standardUserDefaults];
    ideez = [[movieIDeez objectForKey:@"ideez"] mutableCopy];
    for(NSString * DD in ideez){
        [favMovies addObject:[DBManager selectMovie:DD]];
    }
    [self.myTabel reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return favMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    Movie * movie = [favMovies objectAtIndex:indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text=movie.date;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:movie.image]
               placeholderImage:nil];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        Movie * movie = [favMovies objectAtIndex:indexPath.row];
        NSUserDefaults *movieIDeez = [NSUserDefaults standardUserDefaults];
        ideez = [[movieIDeez objectForKey:@"ideez"] mutableCopy];
        for(Movie * m in favMovies){
            if([m.ID isEqualToString:movie.ID]){
                [favMovies removeObject:m];
                [ideez removeObject:movie.ID];
                [movieIDeez setObject:ideez forKey:@"ideez"];
                break;
            }
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        [_myTabel reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController * detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsView"];
    Movie * movieDetails;
    movieDetails = [favMovies objectAtIndex:indexPath.row];
    detailsView.movieDetail=movieDetails;
    [self.navigationController pushViewController:detailsView animated:YES];
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
