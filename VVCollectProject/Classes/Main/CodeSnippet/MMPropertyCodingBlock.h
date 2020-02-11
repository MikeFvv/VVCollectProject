//
//  MMPropertyCodingBlock.h
//  VVCollectProject
//
//  Created by Mike on 2020/2/11.
//  Copyright © 2020 Mike. All rights reserved.
//

#ifndef MMPropertyCodingBlock_h
#define MMPropertyCodingBlock_h


/**
 *  const属性 xxconst
 */
static NSString *const <#varibleName#> = @"<#varibleValue#>";


/**
 *  weak属性 xxweak
 */
@property (weak, nonatomic) <#class#> *<#pram#>;

/**
 *  strong属性 xxstrong
 */
@property (strong, nonatomic) <#class#> *<#pram#>;

/**
 *  assign属性 xxassign
 */
@property (assign, nonatomic) <#class#> <#pram#>;

/**
 *  copy属性 xxcopy
 */
@property (copy, nonatomic) <#class#> *<#pram#>;

/**
 *  NSString属性 xxstring
 */
@property (copy, nonatomic) NSString *<#pram#>;

/**
 *  block属性 xxblock
 */
@property (copy, nonatomic) <#ReturnType#>(^<#BlockName#>)(<#param#>);

/// <#delegate注释#>
@property (nonatomic, weak) id<<#protocol#>> <#delegate#>;



#pragma mark -  <#要注释的内容#>



#endif /* MMPropertyCodingBlock_h */


     

