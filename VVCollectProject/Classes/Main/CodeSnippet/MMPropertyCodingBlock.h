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
@property (weak, nonatomic) <#class#> *<#pram#>;

/// strong属性 xxstrong
/// <#strong属性#>
@property (strong, nonatomic) <#class#> *<#pram#>;

/// assign属性 xxassign
/// <#assign属性#>
@property (assign, nonatomic) <#class#> <#pram#>;

/// copy属性 xxcopy
/// <#copy属 #>
@property (copy, nonatomic) <#class#> *<#pram#>;

/// NSString属性 xxstring
/// <#NSString属性#>
@property (copy, nonatomic) NSString *<#pram#>;

/// block属性 xxblock
/// <#block属性#>
@property (copy, nonatomic) <#ReturnType#>(^<#BlockName#>)(<#param#>);

/// block属性 xxdelegate
/// <#delegate注释#>
@property (nonatomic, weak) id<<#protocol#>> <#delegate#>;


/// xxmark
#pragma mark -  <#要注释的内容#>

/// xxseak
__weak __typeof(self)weakSelf = self;
__strong __typeof(weakSelf)strongSelf = weakSelf;



#endif /* MMPropertyCodingBlock_h */


     

