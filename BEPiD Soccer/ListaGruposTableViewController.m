//
//  ListaGruposTableViewController.m
//  BEPiD Soccer
//
//  Created by Jáder Borba Nunes on 3/26/15.
//  Copyright (c) 2015 Bruno Rovea Soares. All rights reserved.
//

#import "ListaGruposTableViewController.h"
#import "SessionManager.h"
#import "ServerConnection.h"

@interface ListaGruposTableViewController ()<IGroup>
@property (strong, nonatomic) IBOutlet UITableView *custonTableView;

@property (strong, nonatomic) IBOutlet UIButton *buttonCriateGroup;
@end

@implementation ListaGruposTableViewController
{
    NSDictionary *grupos;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    grupos = [[NSDictionary alloc]init];
    
    self.buttonCriateGroup.layer.cornerRadius = 5.0;
    [self.custonTableView setDelegate:self];
    
    NSString *objectIdUser = [[SessionManager sharedManager]getObjectIdUser];
    
    [[ServerConnection sharedManager]getGroupsByObjectIdUser:objectIdUser events:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[grupos objectForKey:@"Result"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellGroup" forIndexPath:indexPath];
    
    NSString *nomeGrupo = [[[grupos objectForKey:@"Result"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.text = nomeGrupo;
    
    return cell;
}

-(void)OnGetGroupByUserSucceded:(NSDictionary *)userInfo
{
    grupos = userInfo;
    [self.custonTableView reloadData];
}
-(void)OnGetGroupByUserError:(NSString *)error ErrorCode:(enum JsonErrorCode)errorCode
{
    
}

@end
