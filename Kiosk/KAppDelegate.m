//
//  KAppDelegate.m
//  Kiosk
//
//  Created by Joël Gähwiler on 29.05.13.
//  Copyright (c) 2013 256dpi. All rights reserved.
//

#import "KAppDelegate.h"

@implementation KAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  NSString* filePath = @"~/kiosk.config";
  filePath = [filePath stringByExpandingTildeInPath];
  
  NSString* fileContents =
  [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
  
  int windowLevel;
  NSRect screenRect;

  if (CGDisplayCapture(kCGDirectMainDisplay) != kCGErrorSuccess) {
    NSLog( @"Couldn't capture the main display!" );
  }

  windowLevel = CGShieldingWindowLevel();
  screenRect = [[NSScreen mainScreen] frame];

  self.mainWindow = [[NSWindow alloc] initWithContentRect:screenRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO screen:[NSScreen mainScreen]];
  [self.mainWindow setLevel:windowLevel];
  [self.mainWindow setBackgroundColor:[NSColor blackColor]];
  [self.mainWindow makeKeyAndOrderFront:nil];
  
  NSURL *url = [NSURL URLWithString:fileContents];
  NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  WebView *webView = [[WebView alloc] initWithFrame:screenRect];
  [[webView mainFrame] loadRequest:requestObj];
  [self.mainWindow setContentView:webView];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
  [self.mainWindow orderOut:self];
  
  if (CGDisplayRelease( kCGDirectMainDisplay ) != kCGErrorSuccess) {
    NSLog( @"Couldn't release the display(s)!" );
  }
}

- (BOOL)canBecomeKeyWindow
{
  return YES;
}

@end
