//
//  MovieCellTableViewCell.h
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/28/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterview;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end
