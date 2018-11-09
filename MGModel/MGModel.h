//
//  MGModel.h
//  awfas
//
//  Created by guangli hao on 2018/11/6.
//  Copyright © 2018 guangli hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGModel : NSObject

/**
 得到指定类中的属性信息

 @param classStr 类名
 @return 属性数组
 */
+ (id)propertyKeysWithString:(NSString *)classStr;


/**
 这个方法可以直接把从json中得到的数组中的字典转化为具体的数组，其里面都是封装好的具体对象。

 @param modelClass 类名
 @param array json数组
 @return model数组
 */
+ (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
