@interface UIKeyboardInputMode : UITextInputMode
@property(retain) NSString *normalizedIdentifier;
@end

@interface UIKeyboardInputModeController : NSObject
@property(retain) UIKeyboardInputMode* currentInputMode;
- (NSArray *)activeInputModes;
@end

//==================================================================================

%hook UIKeyboardInputModeController
-(UIKeyboardInputMode *)lastUsedInputMode {
	return %orig;
}

-(UIKeyboardInputMode *)nextInputModeToUse {
	UIKeyboardInputMode *currentInputMode = self.currentInputMode;
	NSArray *activeInputModes = [self activeInputModes];

	if ([activeInputModes count] < 3 || [currentInputMode.normalizedIdentifier isEqualToString:@"emoji"]){ //If there are less than 3 keyboards do not act
		return %orig;
	}

	UIKeyboardInputMode *firstInputMode = [activeInputModes objectAtIndex:0];
	UIKeyboardInputMode *secondInputMode = [activeInputModes objectAtIndex:1];
	UIKeyboardInputMode *thirdInputMode = [activeInputModes objectAtIndex:2];

	if(currentInputMode == firstInputMode){
		return secondInputMode;
	}else if(currentInputMode == secondInputMode){
		return thirdInputMode;
	}else{
		return firstInputMode;
	}
}
%end
