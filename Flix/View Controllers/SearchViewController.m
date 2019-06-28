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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    super.url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"]];
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length != 0) {
        super.url =[NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&query=%@&page=1&include_adult=false", searchBar.text]];
    } else {
        super.url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"];
    }
    [super fetchMovies];
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    self.searchBar.text = nil;
    [self searchBarSearchButtonClicked:self.searchBar];
}


@end
