//
//  FastFeedCell.h
//  Simple RSS
//
//  Created by Kenji Hollis on 3/24/09.
//  Copyright 2009 Bitgate Mobile, LLC.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastTableViewCell.h"


@interface FastFeedCell : FastTableViewCell {
@private
	NSString *mainText;
	NSString *subText;
	BOOL markedRead;
}

@property (nonatomic,retain) NSString *mainText;
@property (nonatomic,retain) NSString *subText;

- (void)setMainLabel:(NSString *)label;
- (void)setSubLabel:(NSString *)label;
- (void)setMarkedRead:(BOOL)yesOrNo;

@end
