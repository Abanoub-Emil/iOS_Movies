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
baseUrl = @"https://api.themoviedb.org/3/movie/550?api_key=23cca2d1f3e44625a0e74b4f7435b5ea";
    NSURL *url = [[NSURL alloc] initWithString:baseUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
