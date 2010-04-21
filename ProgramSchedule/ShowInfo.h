//
//  ShowInfo.h
//  KPFT_App
//
//  Created by Nathan King of Mojo Hand Development
//

#import <Foundation/Foundation.h>


@interface ShowInfo : NSObject 
{
	NSString *showTitle;
	NSString *startTime;
	NSString *endTime;
}

@property (nonatomic, copy) NSString*  ShowTitle;
@property (nonatomic, copy) NSString*  StartTime;
@property (nonatomic, copy) NSString*  EndTime;



@end
