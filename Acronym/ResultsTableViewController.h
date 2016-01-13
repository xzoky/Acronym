//
//  ResultsTableViewController.h
//  Acronym
//
//  Created by Camille Kander on 1/12/16.
//  Copyright © 2016 xzoky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSString *acronym;
@property (nonatomic, strong) NSArray *definitions;

@end
