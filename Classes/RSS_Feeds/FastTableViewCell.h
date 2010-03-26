//
//  FastTableViewCell.h
//  DocLookup
//
//  Created by Kenji Hollis on 3/5/09.
//  Copyright 2009 Bitgate Mobile, LLC.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FastTableViewCell : UITableViewCell {
@private
	UIView *contentView;
}

- (void)drawContentView:(CGRect)r; // subclasses should implement

@end
