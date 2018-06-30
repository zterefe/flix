//
//  MoviesGridViewController.m
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/29/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionlayout.dataSource=self;
    self.collectionlayout.delegate=self;
    [self fetchcycle];

    UICollectionViewFlowLayout * layout= (UICollectionViewFlowLayout *) self.collectionlayout.collectionViewLayout;
    layout.minimumLineSpacing=5;
    layout.minimumInteritemSpacing=5;
    
    
    CGFloat posterperline=2;
    CGFloat width=(self.collectionlayout.frame.size.width-layout.minimumInteritemSpacing *(posterperline-1))/posterperline;
    CGFloat height=width*1.5;
    layout.itemSize=CGSizeMake(width, height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) fetchcycle{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", dataDictionary);
            self.movie= dataDictionary[@"results"];
       [self.collectionlayout reloadData];
        }
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MovieCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *movie=self.movie[indexPath.item];
    NSString *baseURLString=@"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString=movie[@"poster_path"];
    NSString *fullPosterURLString= [baseURLString stringByAppendingString:posterURLString];
    NSURL* posterURL=[NSURL URLWithString:fullPosterURLString];
    cell.posterView.image=nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movie.count;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell * tappedCell= sender;
    NSIndexPath *indexPath= [self.collectionlayout indexPathForCell:tappedCell];
    NSDictionary * movie=self.movie[indexPath.row];
    DetailViewController * detailView= [segue destinationViewController];
    detailView.movie=movie;
}


@end
