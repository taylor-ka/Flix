//
//  DetailsViewController.m
//  Flix
//
//  Created by taylorka on 6/26/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"

@interface DetailsViewController ()

// Image Views
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

// Watch Trailer
@property (strong, nonatomic) NSString *key;
@property (weak, nonatomic) IBOutlet UIButton *watchTrailerButton;

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
    
    // Watch trailer?
    [self loadTrailerInfo];
}

-(void)loadTrailerInfo {
    NSString *movie_id = self.movie[@"id"];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", movie_id]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            // Grab all data
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // Get the array of videos and store in a property
            NSArray *videos = dataDictionary[@"results"];
            
            if (videos.count != 0) { // If there are trailers
                // Fade in watch trailer button
                self.watchTrailerButton.alpha = 0.0;
                self.watchTrailerButton.hidden = NO;
                [UIView animateWithDuration:0.4 animations:^{
                    self.watchTrailerButton.alpha = 1.0;
                }];
                
                NSDictionary *trailer = videos[0];
                self.key = trailer[@"key"];
            } else {
                self.watchTrailerButton.hidden = YES;
            }
        }
    }];
    [task resume];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrailerViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.urlString = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", self.key];
}

@end
