//
//  SearchViewController.m
//  Flix
//
//  Created by taylorka on 6/27/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

//TODO: working on search for all movies in collection view
#import "SearchViewController.h"

@interface SearchViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
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
