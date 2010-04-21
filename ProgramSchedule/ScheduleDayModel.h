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
	NSString* programDay;
}

@property (nonatomic, copy) NSString* ProgramDay;
@property (nonatomic, readonly) NSMutableArray*  properties;

@end



