//
//  MMPropertyCodingBlock.h
//  VVCollectProject
//
//  Created by Mike on 2020/2/11.
//  Copyright © 2020 Mike. All rights reserved.
//

#ifndef MMPropertyCodingBlock_h
#define MMPropertyCodingBlock_h

/// <#xxx属性 #">


/// const属性 xxconst
/// <#const属性#>
static NSString *const <#varibleName#> = @"<#varibleValue#>";

/// weak属性 xxweakP
/// <#weak属性#>
@property (nonatomic, weak) <#class#> *<#pram#>;

/// strong属性 xxstrong
/// <#strong属性#>
@property (nonatomic, strong) <#class#> *<#pram#>;

/// assign属性 xxassign
/// <#assign属性#>
@property (nonatomic, assign) <#class#> <#pram#>;

/// copy属性 xxcopy
/// <#copy属 #>
@property (nonatomic, copy) <#class#> *<#pram#>;

/// NSString属性 xxstring
/// <#NSString属性#>
@property (nonatomic, copy) NSString *<#pram#>;

/// block属性 xxblock
/// <#block属性#>
@property (nonatomic, copy) <#ReturnType#>(^<#BlockName#>)(<#param#>);

/// block属性 xxdelegate
/// <#delegate注释#>
@property (nonatomic, weak) id<<#protocol#>> <#delegate#>;


/// xxmark
#pragma mark -  <#要注释的内容#>

/// xxweak
__weak __typeof(self)weakSelf = self;
__strong __typeof(weakSelf)strongSelf = weakSelf;



#endif /* MMPropertyCodingBlock_h */


     

