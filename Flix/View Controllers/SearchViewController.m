//
//  SearchViewController.m
//  Flix
//
//  Created by taylorka on 6/27/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

//TODO: working on search for all movies in collection view
#import "SearchViewController.h"
#import "MoviesGridViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    super.url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"]];
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length != 0) { // User has entered in a search
        NSString *searchString = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        super.url =[NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&query=%@&page=1&include_adult=false", searchString]];
    } else { // Show popular movies if no text
        super.url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"];
    }
    
    // Update movies and hide keyboard
    [super fetchMovies];
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // Reset search bar and hide keyboard
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = nil;
    [self.view endEditing:YES];
    
    // Refresh popular movies
    [self searchBarSearchButtonClicked:self.searchBar];
}


@end
