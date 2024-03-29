//
//  MoviesGridViewController.h
//  Flix
//
//  Created by taylorka on 6/26/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesGridViewController : UIViewController

@property (nonatomic, strong) NSURL *url;
- (void)fetchMovies;

@end

NS_ASSUME_NONNULL_END
