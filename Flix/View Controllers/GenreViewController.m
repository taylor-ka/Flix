//
//  GenreViewController.m
//  Flix
//
//  Created by taylorka on 6/27/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "GenreViewController.h"
#import "GenreCell.h"
#import "MoviesGridViewController.h"

@interface GenreViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *genres;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GenreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Make network request to get genres
    [self fetchGenres];
}

- (void)fetchGenres {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/genre/movie/list?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            // Grab all movie data
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // Get the array of movies and store in a property
            self.genres = dataDictionary[@"genres"];
            
            // Reload table view data
            [self.tableView reloadData];
        }
    }];
    [task resume];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Grab information about current cell genre
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *genre = self.genres[indexPath.row];
    
    // Give genre to movies view controller
    MoviesGridViewController *gridController = [segue destinationViewController];
    gridController.genreID = genre[@"id"];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *genre = self.genres[indexPath.row];
    GenreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenreCell"];
    cell.genreLabel.text = genre[@"name"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.genres.count;
}

@end
