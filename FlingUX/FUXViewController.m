//
//  FViewController.m
//  FlingUX
//
//  Created by Maciek on 22.09.2013.
//  Copyright (c) 2013 Fortunity. All rights reserved.
//

#import "FUXViewController.h"

@interface FUXViewController ()

@end

@implementation FUXViewController

- (void)viewDidLoad
{
    self.collectionCapacity = 30;
    self.collection = [NSMutableArray arrayWithCapacity:self.collectionCapacity];
    
    for (int index = 0; index < self.collectionCapacity; ++index)
    {
        [self.collection addObject:[NSNumber numberWithInt:index]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectionCapacity;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", [[self.collection objectAtIndex:indexPath.row] intValue]];
    cell.showsReorderControl = YES;
    
    return cell;
}

- (IBAction)didLongTapCellWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self.tableView setEditing:!self.tableView.editing animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark - FlingUX
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id object = [self.collection objectAtIndex:sourceIndexPath.row];
    [self.collection removeObject:object];
    [self.collection insertObject:object atIndex:destinationIndexPath.row];
    
//    NSLog(@"Cell oficially moved");
    
    if (!self.landingIndexPathIsOutsideTheCurrentView)
    {
        self.isMoving = NO;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.movedCell)
    {
        [cell removeFromSuperview];
//        NSLog(@"Cell removed from superview");
        
        [tableView reloadData];
        
        self.isMoving = NO;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSLog(@"START: %@", NSStringFromSelector(_cmd));
    self.isMoving = YES;
    
    //  Velocity in px/s:
    self.currentYOffset = self.movedCell.frame.origin.y;
    self.currentTimeStamp = CACurrentMediaTime();
    
    CGFloat velocityInPxPerSecond =  (self.currentYOffset - self.previousYOffset) / (self.currentTimeStamp - self.previousTimeStamp);
    
    self.previousYOffset = self.currentYOffset;
    self.previousTimeStamp = self.currentTimeStamp;

    //  Calculate number of cells to skip. Height of the cell * 4 - empirical value:
    CGFloat flingLength = velocityInPxPerSecond / (44.0 * 4.0);
    
    NSInteger landingRow = proposedDestinationIndexPath.row + flingLength;
    if (landingRow < 0)
    {
        landingRow = 0;
    }
    else if (landingRow >= [self tableView:self.tableView numberOfRowsInSection:0])
    {
        landingRow = [self tableView:self.tableView numberOfRowsInSection:0] - 1;
    }
    
    NSIndexPath* landingIndexPath = [NSIndexPath indexPathForRow:landingRow inSection:proposedDestinationIndexPath.section];
//    NSIndexPath* tempIndexPath = sourceIndexPath;
//    NSLog(@"sourceIndexPath row: %li, section: %li", (long)sourceIndexPath.row, (long)sourceIndexPath.section);
//    tempIndexPath = landingIndexPath;
//    NSLog(@"landingIndexPath row: %li, section: %li", (long)tempIndexPath.row, (long)tempIndexPath.section);
    
    self.landingIndexPathIsOutsideTheCurrentView = [tableView.indexPathsForVisibleRows indexOfObject:landingIndexPath] == NSNotFound;
    
    NSLog(@"END: %@", NSStringFromSelector(_cmd));
    return landingIndexPath;
}

- (UITableViewCell *)movedCell
{
    if (self.isMoving)
    {
        NSArray* cellsAndOtherLowLewelTableViewSubviews = ((UIView *)[self.tableView.subviews firstObject]).subviews;
        
        return [cellsAndOtherLowLewelTableViewSubviews objectAtIndex:cellsAndOtherLowLewelTableViewSubviews.count - 2];
    }
    
    return nil;
}

@end
