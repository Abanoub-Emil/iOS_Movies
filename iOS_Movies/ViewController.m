//
//  ViewController.m
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    UIView * separator = [[UIView alloc] initWithFrame:CGRectMake(20, 425, width-40, 1)];
//    separator.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
//    [self.view addSubview:separator];
}

- (void)viewWillAppear:(BOOL)animated{
    _movieTitle.text = _movieDetail.title;
    _movieDate.text = _movieDetail.date;
    _movieRate.text = [_movieDetail.rate stringByAppendingString:@"/10"];
    [_movieOverView setText:_movieDetail.overView];
    
    [_movieImage sd_setImageWithURL:[NSURL URLWithString:_movieDetail.image]
               placeholderImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addFavorite:(id)sender {
    NSUserDefaults *movieIDeez = [NSUserDefaults standardUserDefaults];
    NSMutableArray * ideez = [NSMutableArray new];
    ideez = [[movieIDeez objectForKey:@"ideez"] mutableCopy];
    for(NSString * DD in ideez){
        if([DD isEqualToString:_movieDetail.ID]){
            return;
        }
    }
        [ideez addObject:_movieDetail.ID];
    [movieIDeez setObject:ideez forKey:@"ideez"];
    for(NSString * DD in ideez){
        printf("%s\n",[DD UTF8String]);
    }

}
- (IBAction)play1:(id)sender {
    NSURL *URL = [[NSURL alloc] initWithString:_movieDetail.trailer1];
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
}

- (IBAction)play2:(id)sender {
    NSURL *URL = [[NSURL alloc] initWithString:_movieDetail.trailer2];
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
}
@end
