//
//  MoviesGridViewController.h
//  flix
//
//  Created by Zelalem Tenaw Terefe on 6/29/18.
//  Copyright © 2018 Zelalem Tenaw Terefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesGridViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionlayout;

@property (nonatomic, strong) NSArray* movie;

@end
