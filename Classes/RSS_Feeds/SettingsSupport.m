//
//  SettingsSupport.m
//  Simple RSS
//
//  Created by Kenji Hollis on 12/18/08.
//  Copyright 2008 Bitgate Mobile, LLC.. All rights reserved.
//

#import "SettingsSupport.h"


@implementation SettingsSupport

+ (BOOL)isOpenInSafari {
	return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_OPEN_IN_SAFARI];
}

+ (void)setOpenInSafari:(BOOL)open {
	[[NSUserDefaults standardUserDefaults] setBool:open forKey:KEY_OPEN_IN_SAFARI];
}

@end
