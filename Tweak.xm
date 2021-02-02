@interface UIKeyboardInputMode : UITextInputMode
@property(retain) NSString *normalizedIdentifier;
@end

@interface UIKeyboardInputModeController : NSObject
@property(retain) UIKeyboardInputMode* currentInputMode;
- (NSArray *)activeInputModes;
@end


%hook UIKeyboardInputModeController
//We are hooking this method because whatever we return here will determine what keyboard will be activated next.
-(UIKeyboardInputMode *)nextInputModeToUse {
	UIKeyboardInputMode *currentInputMode = self.currentInputMode; //This will return the currently used keyboard.
	NSArray *activeInputModes = [self activeInputModes]; //This will return the array of all enabled keyboards ordered the same as the keyboard settings

	if ([activeInputModes count] < 3 || [currentInputMode.normalizedIdentifier isEqualToString:@"emoji"]){ //If (there are less than 3 keyboards) OR (currently using the emoji keyboard) -> do nothing special
		return %orig;
	}
//If we got here, we have 3 or more keyboards and we are not on the emoji keyboard.
//now we make 3 variables for the first 3 keyboards in our keyboards array.
	UIKeyboardInputMode *firstInputMode = [activeInputModes objectAtIndex:0];
	UIKeyboardInputMode *secondInputMode = [activeInputModes objectAtIndex:1];
	UIKeyboardInputMode *thirdInputMode = [activeInputModes objectAtIndex:2];

	if(currentInputMode == firstInputMode){ //if using first -> go to second
		return secondInputMode;
	}else if(currentInputMode == secondInputMode){ //if using second -> go to third
		return thirdInputMode;
	}else{ //any other case -> go to first
		return firstInputMode;
	}
}
%end
