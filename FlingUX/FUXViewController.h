//
//  FViewController.h
//  FlingUX
//
//  Created by Maciek on 22.09.2013.
//  Copyright (c) 2013 Fortunity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUXViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSUInteger collectionCapacity;
@property (nonatomic, strong) NSMutableArray* collection;

@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, strong) NSIndexPath* indexPathOfFlingRow;
@property (nonatomic, assign) BOOL landingIndexPathIsOutsideTheCurrentView;

@property (nonatomic, assign) CGFloat previousYOffset;
@property (nonatomic, assign) CGFloat currentYOffset;

@property (nonatomic, assign) double previousTimeStamp;
@property (nonatomic, assign) double currentTimeStamp;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
