/**
 *    gVoice
 * 
 *    Copyright (C) 2009 Adam Venturella
 *
 *    LICENSE:
 *
 *    Licensed under the Apache License, Version 2.0 (the "License"); you may not
 *    use this file except in compliance with the License.  You may obtain a copy
 *    of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
 *    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
 *    PURPOSE. See the License for the specific language governing permissions and
 *    limitations under the License.
 *
 *    Author: Adam Venturella - aventurella@gmail.com
 *
 **/

#import "GVGoogleVoice.h"
#import "GVOperation.h"
#import "GVAuthorizationOperation.h"
#import "GVAuthorizationDelegate.h"
#import "GVAuthorization.h"
#import "GVCall.h"
#import "GVSMS.h"
#import "GVAPISettings.h"

@implementation GVGoogleVoice
@synthesize delegate;
@dynamic sessionKey;

- (id)init
{
	if(self = [super init])
	{
		queue = [[NSOperationQueue alloc] init];
	}
	
	return self;
}

-(NSString *)sessionKey
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:kGVSessionKey];
}

- (void)call:(NSString *)forwardingNumber outgoingNumber:(NSString *)outgoingNumber subscriberNumber:(NSString *)subscriberNumber
{	
	GVCall * command = [[GVCall alloc] initWithSessionKey:self.sessionKey forwardingNumber:forwardingNumber outgoingNumber:outgoingNumber subscriberNumber:subscriberNumber];
	GVOperation * operation  = [GVOperation operationWithCommand:command];
	
	[command release];
	[queue addOperation:operation];

}

- (void)sms:(NSString *)phoneNumber message:(NSString *)message threadId:(NSString *)threadId
{
	GVSMS * command = [[GVSMS alloc] initWithSessionKey:self.sessionKey phoneNumber:phoneNumber message:message threadId:threadId];
	GVOperation * operation  = [GVOperation operationWithCommand:command];
	
	[command release];
	[queue addOperation:operation];
}

- (void)authorize:(NSString *)email password:(NSString *)password
{
	GVAuthorization * command              = [[GVAuthorization alloc] initWithEmail:email password:password];
	GVAuthorizationOperation * operation   = [GVAuthorizationOperation authorizationOperationWithCommand:command];
	
	operation.delegate = self;
	[command release];
	
	[queue addOperation:operation];
	
}

- (void) operationDidFinish:(NSDictionary *)operationInfo
{
	
	if([operationInfo objectForKey:kGVOperationKeyClass] == [GVAuthorization class])
	{
		if([self.delegate conformsToProtocol:@protocol( GVAuthorizationDelegate)])
		{
			[self.delegate performSelector:@selector(googleVoiceAuthorizationDidFinish:info:) withObject:self withObject:operationInfo];
		}
	}
}

- (void)dealloc
{
	[queue release], queue = nil;
	[super dealloc];
}

@end
