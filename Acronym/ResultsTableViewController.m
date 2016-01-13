//
//  ResultsTableViewController.m
//  Acronym
//
//  Created by Camille Kander on 1/12/16.
//  Copyright © 2016 xzoky. All rights reserved.
//

#import "ResultsTableViewController.h"

@implementation ResultsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.acronym;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.definitions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [(NSDictionary *)self.definitions[indexPath.row] objectForKey:@"lf"];
    return cell;
}

@end
