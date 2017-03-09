#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "libcolorpicker.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SBIconImageView : UIView
@end



%hook SBIconImageView
- (id)initWithFrame:(struct CGRect)arg1
{
	//Define the file that holds our prefs
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:
	[NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"com.pxcex.bordericonplus.plist"]];

	//Create a NSNumber to hold our boolean value to check if our tweak is enabled
  NSNumber* isEnabled = [prefs objectForKey:@"enabled"];

    //Let's capture the hex value from libcolorpicker
  NSString* colorString = [prefs objectForKey:@"saveColor"];

    //To use our macro, we need to have it in '0xFFFFFF' format so lets remove the alpha
  NSArray* subStrings = [colorString componentsSeparatedByString:@":"];
  NSString* finalString = [subStrings objectAtIndex:0];

    //Now that our string doesn't contain an alpha value, let's replace our # with 0x for our macro to use
	finalString = [finalString stringByReplacingOccurrencesOfString:@"#"
                                     withString:@"0x"];

	//Our macro only accepts an integer value so let's convert it

	unsigned colorInt = 0;
	[[NSScanner scannerWithString:finalString] scanHexInt:&colorInt];

	//If the enabled switch is enabled
	if([isEnabled boolValue] == YES)
	{
		//Set our color

		SBIconImageView *tmp = %orig(arg1);
		CALayer *lay = [tmp layer];
		lay.borderWidth = 3;
		lay.cornerRadius = 10;
		lay.borderColor = UIColorFromRGB(colorInt).CGColor;
		return tmp;
	}
	else
	{
		//Otherwise, let's just call the default dock
		return %orig;
	}
}
%end
