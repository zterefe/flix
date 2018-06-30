//
//  DetailViewController.m
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/28/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString=@"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString=self.movie[@"poster_path"];
    NSString *fullPosterURLString= [baseURLString stringByAppendingString:posterURLString];
    NSURL* posterURL=[NSURL URLWithString:fullPosterURLString];
    [self.posterview setImageWithURL:posterURL];
    
    
    
    NSString *backdropURLString=self.movie[@"backdrop_path"];
    NSString *fullbackdropPosterURLString= [baseURLString stringByAppendingString:backdropURLString];
    NSURL* backposterURL=[NSURL URLWithString:fullbackdropPosterURLString];
    [self.bodyimageview setImageWithURL:backposterURL];
    self.titleLabel.text=self.movie[@"title"];
  self.overviewLabel.text=self.movie[@"overview"];
    self.relesedate.text=self.movie[@"release_date"];
    
    
    [self.relesedate sizeToFit];
    [self.titleLabel sizeToFit];
    [self.overviewLabel sizeToFit];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
