//
//  KAppDelegate.h
//  Kiosk
//
//  Created by Joël Gähwiler on 29.05.13.
//  Copyright (c) 2013 256dpi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface KAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) NSWindow* mainWindow;

@end
