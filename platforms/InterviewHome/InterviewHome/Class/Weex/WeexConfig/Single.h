//
//  Single.h
//  WeexDemo
//
//  Created by genglei on 2018/7/29.
//  Copyright © 2018年 genglei. All rights reserved.
//

#ifndef Single_h
#define Single_h

#if __has_feature(objc_instancetype)

#undef    DEF_SINGLETON
#define   DEF_SINGLETON( ... )  \
+ (instancetype)sharedInstance;

#undef  IMP_SINGLETON
#define IMP_SINGLETON \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif


#undef    DEF_SINGLETON_AUTOLOAD
#define DEF_SINGLETON_AUTOLOAD( __class ) \
DEF_SINGLETON( __class ) \
+ (void)load \
{ \
[__class sharedInstance]; \
}


#endif /* Single_h */
