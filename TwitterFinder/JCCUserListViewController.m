//
//  JCCUserListViewController.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCUserListViewController.h"
#import "JCCTwitterUser.h"
#import "JCCProfileWebView.h"
#import "JCCTwitterService.h"

@interface JCCUserListViewController ()

@property(nonatomic, strong) JCCTwitterService* twitterService;
@property(nonatomic, strong) NSArray *users;

@end

@implementation JCCUserListViewController

#pragma mark - JCCTwitterDataLoaded
- (void)dataLoaded
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.twitterService = [[JCCTwitterService alloc] init];
    self.twitterService.delegate = self;
    self.users = [self.twitterService getUsers:self.searchText];
    
    //TODO add loading indicator

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.users count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    JCCTwitterUser *user = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = [user name];
    cell.detailTextLabel.text = [user screenName];
    cell.imageView.image = [user image];
    
    return cell;
}

- (IBAction)done:(id *)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"viewProfile" isEqualToString:segue.identifier]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JCCProfileWebView *destViewController = segue.destinationViewController;
        destViewController.screenName = [[self.users objectAtIndex:indexPath.row] screenName];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
