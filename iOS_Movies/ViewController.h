//
//  ViewController.h
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie.h"
@interface ViewController : UIViewController
@property Movie * movieDetail;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDate;
@property (weak, nonatomic) IBOutlet UILabel *movieRate;
@property (weak, nonatomic) IBOutlet UITextView *movieOverView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
- (IBAction)addFavorite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playTrailer1;
- (IBAction)play1:(id)sender;
- (IBAction)play2:(id)sender;

@end

