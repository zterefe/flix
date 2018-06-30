//
//  MoviesViewController.m
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/28/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) UIRefreshControl * refreashControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbarlayout;
@property NSArray *filteredData;
@property NSArray * movies;

@end

@implementation MoviesViewController

-(void) fetchcycle{
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can get Movies"message:@"The internet connection appears to be offline" preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:alert animated:YES completion:^{
                NSLog(@"%@", @"Network error");
            }];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", dataDictionary);
            self.movies=dataDictionary[@"results" ];
            for(NSDictionary *movie in self.movies){
                NSLog(@"%@", movie[@"title"]);
            }
                self.filteredData = self.movies;
            [self.mytableview reloadData];
        }
        [self.refreashControl endRefreshing];
        
    }];
    [task resume];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mytableview.dataSource=self;
    self.mytableview.delegate=self;
    self.searchbarlayout.delegate=self;
    //[self.searchbarlayout sizeToFit];

    [self fetchcycle];
    self.refreashControl= [[UIRefreshControl alloc] init];
    [self.refreashControl addTarget:self action:@selector(fetchcycle) forControlEvents:UIControlEventValueChanged];
    [self.mytableview insertSubview:self.refreashControl atIndex:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie=self.filteredData[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.overviewLabel.text=movie[@"overview"];
     //cell.titleLabel.text = self.filteredData[indexPath.row];
    
    NSString *baseURLString=@"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString=movie[@"poster_path"];
    NSString *fullPosterURLString= [baseURLString stringByAppendingString:posterURLString];
    NSURL* posterURL=[NSURL URLWithString:fullPosterURLString];
    cell.posterview.image=nil;
    [cell.posterview setImageWithURL:posterURL];
    return cell;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *movie, NSDictionary *bindings) {
            NSString *title = movie[@"title"];
            BOOL shouldKeep = [title containsString:searchText];
            return shouldKeep;
            
            //if(title)
          
        }];
        
        
        self.filteredData = [self.movies filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredData);
        
    }
    else {
        self.filteredData = self.movies;
    }
    
    [self.mytableview reloadData];
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchbarlayout.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchbarlayout.showsCancelButton = NO;
    self.searchbarlayout.text = @"";
    [self.searchbarlayout resignFirstResponder];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell * tappedCell= sender;
    NSIndexPath *indexPath= [self.mytableview indexPathForCell:tappedCell];
    NSDictionary * movie=self.movies[indexPath.row];
    DetailViewController * detailView= [segue destinationViewController];
    detailView.movie=movie;
}



@end
