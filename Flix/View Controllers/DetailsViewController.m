//
//  DetailsViewController.m
//  Flix
//
//  Created by taylorka on 6/26/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    // Poster
    self.posterView.image = nil;
    if ([self.movie[@"poster_path"] isKindOfClass:[NSString class]]) {
        NSString *posterURLString = self.movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        [self.posterView setImageWithURL:posterURL];
    } else {
        self.posterView.image = [UIImage imageNamed:@"generic_movie_poster"];
    }

    // Backdrop
    self.backdropView.image = nil;
    if ([self.movie[@"backdrop_path"] isKindOfClass:[NSString class]]) {
        NSString *backdropURLString = self.movie[@"backdrop_path"];
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL:backdropURL];
    } else {
        self.backdropView.image = [UIImage imageNamed:@"GenericMovieTheater"];
    }
    
    // Title
    self.titleLabel.text = self.movie[@"title"];
    [self.titleLabel sizeToFit];
    
    // Release Date
    self.releaseDateLabel.text = [NSString stringWithFormat:@"Release Date: %@", self.movie[@"release_date"]];
    [self.releaseDateLabel sizeToFit];
    
    // Average Rating
    self.ratingLabel.text = [NSString stringWithFormat:@"Average Rating: %@ / 10 ☆", self.movie[@"vote_average"]];
    [self.ratingLabel sizeToFit];
    
    // Synopsis
    self.synopsisLabel.text = self.movie[@"overview"];
    [self.synopsisLabel sizeToFit];
    
    // Navigation title
    self.navigationItem.title = self.movie[@"title"];
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
