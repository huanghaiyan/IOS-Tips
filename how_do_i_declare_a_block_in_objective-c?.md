###How Do I Declare A Block in Objective-C?

####As a local variable
	returnType (^blockName)(parameterTypes) = ^returnType(parameters){...};
	
####As a property:
	@property (nonatomic,copy) returnType (^blockName)(parameterTypes);
	
####As a method parameter
	- (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes)) blockName;
	
####As an argument to a method call 
	[someObject someMethodThatTakesABlock:^returnType (parameters){...}];
	
####As a typedef
	typedef returnType (^TypeName)(parameterTypes);
	TypeName blockName = ^returnType(parameters){...};