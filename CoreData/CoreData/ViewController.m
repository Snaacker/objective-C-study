//
//  ViewController.m
//  CoreData
//
//  Created by QuangHuy Tran on 1/16/16.
//  Copyright © 2016 QuangHuy Tran. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChoreMO.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *persistedData;
@property (weak, nonatomic) IBOutlet UITextField *choreField;
@property (nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UILabel *countData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate =    [[UIApplication sharedApplication] delegate];
    [self updateLogList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction) choreTapped:(id)sender{
    ChoreMO *c = [self.appDelegate createChoreMO];
    c.chore_name = self.choreField.text;
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (IBAction) deleteTapped:(id)sender{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results){
        NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for(ChoreMO *c in results){
        [moc deleteObject:c];
    }
    self.countData.text = @"0";
    [self.appDelegate saveContext];
    [self updateLogList];
    
}

- (void) updateLogList{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results){
        NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    NSInteger currentCount = 0;
    for(ChoreMO *c in results){
        [buffer appendFormat:@"\n%@",c.chore_name,nil];
        currentCount++;
    }
    self.countData.text = [@(currentCount) stringValue];
    self.persistedData.text = buffer;
    
}
@end
