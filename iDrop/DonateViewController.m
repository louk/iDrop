//
//  DonateViewController.m
//  iDrop
//
//  Created by Naranbayar on 11/15/15.
//  Copyright © 2015 Naranbayar. All rights reserved.
//

#import "DonateViewController.h"
#import "ProgressHUD.h"



@interface DonateViewController ()

@property (strong, nonatomic)  UITableView *tableMessages;

@end

@implementation DonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set bar color
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0f]}];
    
    self.title = @"Donate";
    
    
    _tableMessages = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    
    _tableMessages.delegate = self;
    _tableMessages.dataSource = self;
    _tableMessages.backgroundColor = [UIColor whiteColor];
    _tableMessages.scrollEnabled = YES;
    //[_tableMessages setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    _tableMessages.contentInset=UIEdgeInsetsMake(0,0.0,0,0.0);
    

    [self.view addSubview:_tableMessages];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    UILabel *productName;
    UILabel *productPrice;

    

    
    
    if (cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        productName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cell.frame.size.width - 140, 50)];
        productName.font = [UIFont fontWithName:@"Helvetica" size:14];
        productName.numberOfLines = 2;
        productName.textAlignment = NSTextAlignmentJustified;
        productName.textColor = [UIColor blackColor];
        [cell.contentView addSubview:productName];
        
        productPrice = [[UILabel alloc] initWithFrame:CGRectMake(90, 80 - 26, cell.frame.size.width - 100, 20)];
        productPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        
        productPrice.textColor = [UIColor colorWithRed:0/255.0f green:124/255.0f blue:188/255.0f alpha:1.0f];
        [cell.contentView addSubview:productPrice];
        
    }
    
    if (indexPath.row == 0) {
    
        productName.text = @"Kingdom Hackathon";
    
    }
    
    if (indexPath.row == 1) {
        
        productName.text = @"Planting Church, Mission";
        
    }

    
    if (indexPath.row == 2) {
        
        productName.text = @"Human Trafficking";
        
    }

    
    
    if (indexPath.row == 3) {
        
        productName.text = @"Instition for Orphan";
        
    }

    
    
    //productPrice.text =  [NSString stringWithFormat:@"%@ ₮",product[PF_PRODUCTS_PRICE]];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    

   // [_tableMessages deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        
        [ProgressHUD showSuccess: @"Donated to $5 to Kingdom Hackathon"];
        
    }
    
    if (indexPath.row == 1) {
        
        [ProgressHUD showSuccess:@"Donated to Planting Church, Mission"];
        
    }
    
    
    if (indexPath.row == 2) {
        
       [ProgressHUD showSuccess:@"Donated to Human Trafficking"];
        
    }    
    
    if (indexPath.row == 3) {
        
        [ProgressHUD showSuccess:@"Donated to Instition for Orphan"];
        
    }
    
    //PFObject *message = messages[indexPath.row];
    
    //ChatView *chatView = [[ChatView alloc] initWith:message[PF_MESSAGES_ROOMID]];
    
    //chatView.hidesBottomBarWhenPushed = YES;
    
    //[self.navigationController pushViewController:chatView animated:YES];
    
}

@end
