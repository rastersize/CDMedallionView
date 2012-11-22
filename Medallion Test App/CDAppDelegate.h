//
//  CDAppDelegate.h
//  Medallion Test App
//
//  Created by Aron Cedercrantz on 22-11-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CDMedallionView/CDMedallionView.h>

@interface CDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet CDMedallionView *largeMedallionView;
@property (assign) IBOutlet CDMedallionView *mediumMedallionView;
@property (assign) IBOutlet CDMedallionView *smallMedallionView;

@end
