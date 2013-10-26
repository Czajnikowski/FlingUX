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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
    cell.showsReorderControl = YES;
    
//    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)]];
    
    return cell;
}

- (void)longTap:(UIGestureRecognizer *)recognizer
{
    NSInteger tempInteger = recognizer.state;
    NSLog(@"recognizer.state: %i", tempInteger);
}

- (IBAction)didLongTapCellWithGestureRecognizer:(id)sender
{
    [self.tableView setEditing:YES animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

//  Fling UX
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSIndexPath* tempIndexPath = destinationIndexPath;
    NSLog(@"destinationIndexPath row: %i, section: %i", tempIndexPath.row, tempIndexPath.section);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == self.movedCell)
    {
        [tableView reloadData];
        self.isMoving = NO;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    self.isMoving = YES;
    
    //  We will measure velocity in px/s
    self.currentYOffset = self.movedCell.frame.origin.y;
    self.currentTimeStamp = CACurrentMediaTime();
    
    CGFloat velocity =  (self.currentYOffset - self.previousYOffset) / (self.currentTimeStamp - self.previousTimeStamp);
    
    self.previousYOffset = self.currentYOffset;
    self.previousTimeStamp = self.currentTimeStamp;

    //  Now we need to calculate number of cells to skip
    
    CGFloat flingLength = velocity / 15 / 22;
    
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
