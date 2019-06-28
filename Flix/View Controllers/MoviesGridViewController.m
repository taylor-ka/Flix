//
//  MoviesGridViewController.m
//  Flix
//
//  Created by taylorka on 6/26/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set up collection view
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // Load data
    [self fetchMovies];
    
    // Set up layout
    // Two movies per row with border in between
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

- (void)fetchMovies {
    [self.activityIndicator startAnimating];
    
    // Find movies using given url
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            // Grab all movie data
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // Get the array of movies of this genre and store in a property
            self.movies = dataDictionary[@"results"];
            [self.collectionView reloadData];
        }
        [self.activityIndicator stopAnimating];
    }];
    [task resume];
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Grab information about current cell movie (sender)
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.item];
    
    // Give movie to details view controller
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    // Create cell and grab current movie
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:(indexPath)];
    NSDictionary *movie = self.movies[indexPath.item];
    
    cell.posterView.image = nil;
    if ([movie[@"poster_path"] isKindOfClass:[NSString class]]) { // If movie poster exists
        // Form URL and make request
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *posterURLString = movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
        
        // Fade image in
        __weak MovieCollectionViewCell *weakCell = cell;
        [cell.posterView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *imageRequest,
                                                                                       NSHTTPURLResponse *imageResponse, UIImage *image) {
                weakCell.posterView.alpha = 0.0;
                weakCell.posterView.image = image;
                                                
                // Animate UIImageView back to alpha 1 over 0.3sec
                [UIView animateWithDuration:0.4 animations:^{
                    weakCell.posterView.alpha = 1.0;
                }];
            }
            failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
                // do something for the failure condition
        }];
        cell.titleIfNoPoster.text = nil;
        
    } else { // No movie poster, use generic
        cell.posterView.image = [UIImage imageNamed:@"generic_movie_poster"];
        cell.titleIfNoPoster.text = movie[@"title"];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

@end
