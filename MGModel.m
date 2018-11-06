//
//  MGModel.m
//  awfas
//
//  Created by guangli hao on 2018/11/6.
//  Copyright © 2018 guangli hao. All rights reserved.
//

#import "MGModel.h"

@implementation MGModel


//获取类的各个属性，存到数组中
+ (id)propertyKeysWithString:(NSString *)classStr

{
    unsigned int outCount, i;
    
    //获取一个类的各个成员变量存放在properties[]数组中
    objc_property_t *properties = class_copyPropertyList([NSClassFromString(classStr) class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    
    return keys;
    
}


+ (NSMutableArray *)customModel:(NSString *)modelClass ToArray:(NSArray *)array
{
    //由于objc_getClass()函数的参数类型是const char *类型的，故在这里要转化一下；
    const char *cComplexClassName = [modelClass UTF8String];
    
    //将传过来的字符串转化为一个类对象
    id theComplexClass = objc_getClass(cComplexClassName);
    
    //用来存放一个类中有几个成员变量。
    unsigned int outCount = 0;
    
    //这句话执行之后outCount的值就会是当前类中属性的个数。整体返回的是一个指针数组，里面包含对应类的各个属性信息。
    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
    
    //创建一个数组用来存放传过来数组中的字典转化成的对象；
    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (int i = 0; i < [array count]; i++) {
        //取出数组中的一个对象
        id jsonDic = [array objectAtIndex:i];
        
        //若数组中的对象不是字典对象就跳过它。继续下一个。
        if(![jsonDic isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        
        //创建一个传过来字符串（类名）相应的对象
        id model = [[NSClassFromString(modelClass) alloc] init];
        
        //判断类中的每一个属性
        for (int j = 0; j < outCount; j++)
        {
            //获取类中的第j个成员变量信息
            objc_property_t property = properties[j];
            
            //获取类中的第j个成员变量将其转化为字符串
            NSString *propertyNameString =[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            //把第一个字母变成大写
            NSString *firstStr = [propertyNameString substringToIndex:1];
            NSString *propertyNameString1 = [propertyNameString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstStr uppercaseString]];
            
            //为每个成员变量设置一个set函数相关的字符串。
            NSString *setProperty = [NSString stringWithFormat:@"%@%@:",@"set",propertyNameString1];
            
            //把字符串转换为一个函数
            SEL setSelector = NSSelectorFromString(setProperty);
            
            //获得json串中的键对应的值
            id object = [jsonDic objectForKey:propertyNameString];
            
            //判断上面取得的值是否存在，不存在就去转换下一个属性
            if(!object || [object isKindOfClass:[NSNull class]])
            {
                continue;
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [model performSelector:setSelector withObject:object];;//此处是你调用函数的地方
#pragma clang diagnostic pop
            //为对应类的对象设置对应的属性
            
        }
        //把数组中对应的每个字典整体转化后加到一个数组中去。
        [dataArr addObject:model];
        
    }
    return dataArr;
}

@end
