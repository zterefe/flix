//
//  DetailViewController.h
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/28/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet UIImageView *bodyimageview;
@property (weak, nonatomic) IBOutlet UIImageView *posterview;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *relesedate;

@end
