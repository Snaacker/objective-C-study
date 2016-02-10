//
//  AppDelegate.m
//  PushyApp
//
//  Created by QuangHuy Tran on 1/10/16.
//  Copyright © 2016 QuangHuy Tran. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationIconBadgeNumber = 0;
    UILocalNotification *localNotif = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif){
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received on launch running" message:localNotif.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [ac addAction:aa];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        });

    }
    return YES;
}

- (void) application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(nonnull UILocalNotification *)notification completionHandler:(nonnull void (^)())completionHandler{

    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received on action" message:identifier preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
    [ac addAction:aa];
        
    dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
    
    completionHandler();
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification  {

    application.applicationIconBadgeNumber = 0;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Receive while running" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [ac addAction:aa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
}

@end
