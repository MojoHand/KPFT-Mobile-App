//
//  SettingsSupport.h
//  Simple RSS
//
//  Created by Kenji Hollis on 12/18/08.
//  Copyright 2008 Bitgate Mobile, LLC.. All rights reserved.
//

#import <Foundation/Foundation.h>

#define	KEY_OPEN_IN_SAFARI		@"openLinksInSafari"


@interface SettingsSupport : NSObject {

}

+ (BOOL)isOpenInSafari;

+ (void)setOpenInSafari:(BOOL)open;

@end
