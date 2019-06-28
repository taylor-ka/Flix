//
//  MoviesViewController.m
//  Flix
//
//  Created by taylorka on 6/26/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

// Visual elements
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UISearchController *searchController;

// Data
@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) NSArray *filteredData;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set up table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Make network request to get movies
    [self.activityIndicator startAnimating];
    [self fetchMovies];
    
    // Set up search controller
    // Do not dim view since we are using current controller to display results
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    // Set up search bar
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.searchController.searchBar.placeholder = @"Search Now Playing";
    
    // Setup refresh at the top of scroll
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies {
    // Fetch movies Now Playing
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            // Create alert
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                                                           message:@"The internet connection appears to be offline."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            // Create a try again action
            UIAlertAction *tryAgainAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [self fetchMovies];
                                                                 }];
            // Add the try again action to the alertController
            [alert addAction:tryAgainAction];
            
            // Show alert
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            // Grab all movie data
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // Get the array of movies and store in a property
            self.movies = dataDictionary[@"results"];
  
            // Set up filtered movies
            self.filteredData = self.movies;
            
            // Reload table view data
            [self.tableView reloadData];
        }
        // Always end refreshing regardless of error status
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
    }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Grab current info of current movie
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    // Create cell for movie with title and synopsis
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    // Get movie poster url
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    // Load movie poster
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Row will only be selected when user clicks
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (searchText) {
        if (searchText.length != 0) { // no text
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title beginswith[cd] %@", searchText];
            self.filteredData = [self.movies filteredArrayUsingPredicate:predicate];
        }
        else {
            // Display all moviies
            self.filteredData = self.movies;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Grab information about current cell movie (sender)
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredData[indexPath.row];
    
    // Give movie to details view controller
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}


@end
