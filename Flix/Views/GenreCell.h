//
//  GenreCell.h
//  Flix
//
//  Created by taylorka on 6/27/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIView *genreImageView;

@end

NS_ASSUME_NONNULL_END
