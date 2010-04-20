//
//  ScheduleDayModel.h
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import <Three20/Three20.h>


@interface ScheduleDayModel : TTURLRequestModel
{
	NSMutableArray*  _properties;
	NSString*        _activePropertyKey;
	//	NSString*             _activePropertyType;	
}

@property (nonatomic, readonly) NSMutableArray*  properties;

@end



