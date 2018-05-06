//
//  FavoriteViewController.h
//  iOS_Movies
//
//  Created by Champion on 5/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseManager.h"
#import "Movie.h"
#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FavoriteViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTabel;

@end
