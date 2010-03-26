//
//  FeedsDetailViewController.h
//  Simple RSS
//
//  Created by Kenji Hollis on 12/10/08.
//

#import <UIKit/UIKit.h>


@interface FeedsDetailViewController : UIViewController {
@private
	NSDictionary *detailDictionary;
	NSArray *categories;
	UILabel *categoryLabel;
	NSTimer *categoryLabelTimer;
	int categoryPosition;
}

@property (nonatomic, retain) NSDictionary *detailDictionary;
@property (nonatomic, retain) NSArray *categories;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
