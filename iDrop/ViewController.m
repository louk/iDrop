//
//  ViewController.m
//  iDrop2
//
//  Created by Larry Walters on 11/15/15.
//  Copyright © 2015 Hackathon. All rights reserved.
//

#import "ViewController.h"
#import <Button/Button.h>
#import "DBTManager.h"
#import "DonateViewController.h"


@interface ViewController ()

@property (nonatomic, strong) BTNContext *buttonContext;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) IDropVerse* verse;

@property (nonatomic, strong) IBOutlet UILabel* verseTextView;
@property (nonatomic, strong) IBOutlet UILabel* verseReferenceView;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem* accountButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem* amountButton;
@property (weak, nonatomic) IBOutlet UITableView *tableViewUber;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
   [super viewDidLoad];
    
  [Button allowButtonToRequestLocationPermission:YES];
  [[Button sharedButton] setDebugLoggingEnabled:YES];
   
   BTNLocation *location = [BTNLocation locationWithName:@"iDrop" latitude:40.723027 longitude:-73.9956459];
   self.buttonContext = [BTNContext contextWithSubjectLocation:location];
   
   self.items = @[ /*@{ @"cell-identifier": @"verse-cell", @"text": @"" },*/
                  
                  
                  @{ @"cell-identifier": @"button-cell" },
                  @{ @"cell-identifier": @"button-cell" },
                  @{ @"cell-identifier": @"button-cell" },
                  @{ @"cell-identifier": @"button-cell" },
                  @{ @"cell-identifier": @"button-cell" },
                  @{ @"cell-identifier": @"button-cell" }
                  ];
   
//   [[DBTManager instance] verseInBook:@"John"
//                              chapter:@3
//                                verse:@16
//                              success:^(IDropVerse* verse)
    [[DBTManager instance] randomVerseOnSuccess:^(IDropVerse* verse)
    {
       self.verse = verse;
       assert(verse != nil);
       self.verseTextView.text = self.verse.text;
       self.verseReferenceView.text = self.verse.reference;
       
       [self.view layoutSubviews];
    }
    failure:^(NSError* error)
    {
       self.verseTextView.text = [NSString stringWithString:[error description]];
    }
    ];
    
    [self.tableViewUber reloadData];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   NSDictionary *rowInfo = self.items[indexPath.row];
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowInfo[@"cell-identifier"]
                                                           forIndexPath:indexPath];
   
   cell.textLabel.text       = rowInfo[@"text"];
   cell.detailTextLabel.text = rowInfo[@"details"];
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 0) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-1278b8a43d711414";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
       
   }
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 1) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-5d45c600ab0bd95b";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
   }
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 2) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-3ceef8e200db3403";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
   }
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 3) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-3735b41adce1de71";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
   }
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 4) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-121358e26e7fa304";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
   }
   
   if ([cell isKindOfClass:[BTNDropinButtonCell class]] && indexPath.row == 5) {
      BTNDropinButtonCell *buttonCell = (BTNDropinButtonCell *)cell;
      
      // Replace YOUR_BUTTON_ID with your Button ID from the Button Dashboard https://app.usebutton.com
      buttonCell.buttonId = @"btn-785de81a1b5dea0f";
      
      [buttonCell prepareWithContext:self.buttonContext completion:^(BOOL isDisplayable) {
         NSLog(@"Displayable: %@", @(isDisplayable));
         // You might remove the backing data item and reload your table view if the button cell is not displayable.
      }];
   }
   
   
   return cell;
}




- (IBAction)donateButton:(id)sender {
    
    DonateViewController *productListVC = [[DonateViewController alloc] init];
    [self.navigationController pushViewController:productListVC animated:YES];
    
}



@end
