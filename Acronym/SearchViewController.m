//
//  SearchViewController.m
//  Acronym
//
//  Created by Camille Kander on 1/12/16.
//  Copyright © 2016 xzoky. All rights reserved.
//

#import "SearchViewController.h"
#import "AcronymService.h"
#import "ResultsTableViewController.h"
#import "MBProgressHUD/MBProgressHUD.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *resultAcronym;
@property (nonatomic, strong) NSArray *resultMatches;

@end

@implementation SearchViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (IBAction)search:(id)sender {
    
    [self.textField resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
    
    [[AcronymService sharedService] getMatchesForAcronym:self.textField.text success:^(NSString *acronym, NSArray *matches) {
        NSLog(@"%@", matches);
        [hud hide:YES afterDelay:0.0];
        self.resultAcronym = acronym;
        self.resultMatches = matches;
        [self performSegueWithIdentifier:@"showResults" sender:sender];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        [hud hide:YES afterDelay:0.0];
        UIAlertController *errorAC = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [errorAC addAction:[UIAlertAction actionWithTitle:@"Bummer" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:errorAC animated:YES completion:nil];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showResults"]) {
        ResultsTableViewController *rtvc = segue.destinationViewController;
        rtvc.acronym = self.resultAcronym;
        rtvc.definitions = self.resultMatches;
    }
}

@end
