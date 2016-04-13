//
//  LSDispatchQueuePool.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSDispatchQueuePool.h"
#import <UIKit/UIKit.h>
#import <libkern/OSAtomic.h>
#define MAX_QUEUE_Count 32

static inline dispatch_queue_priority_t NSOperationQualityOfServiceToDispatchPriority(NSQualityOfService qos){
    switch(qos){
        case NSOperationQualityOfServiceUserInteractive:
            return DISPATCH_QUEUE_PRIORITY_HIGH;
        case NSQualityOfServiceUserInitiated:
            return DISPATCH_QUEUE_PRIORITY_HIGH;
        case NSQualityOfServiceUtility:
            return DISPATCH_QUEUE_PRIORITY_LOW;
        case NSQualityOfServiceBackground:
            return DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        case NSQualityOfServiceDefault:
            return DISPATCH_QUEUE_PRIORITY_DEFAULT;
        default: return DISPATCH_QUEUE_PRIORITY_DEFAULT;
    }
}


static inline qos_class_t NSQualityOfServiceToQOSClass(NSQualityOfService qos){
    switch(qos){
        case NSOperationQualityOfServiceUserInteractive:
            return QOS_CLASS_USER_INTERACTIVE;
        case NSQualityOfServiceUserInitiated:
            return QOS_CLASS_USER_INITIATED;
        case NSQualityOfServiceUtility:
            return QOS_CLASS_UTILITY;
        case NSQualityOfServiceBackground:
            return QOS_CLASS_BACKGROUND;
        case NSQualityOfServiceDefault:
            return QOS_CLASS_DEFAULT;
        default: return QOS_CLASS_UNSPECIFIED;
    }
}
typedef struct {
    const char *name;
    void **queues;
    uint32_t queueCount;
    int32_t counter;
}LSDispatchContext;

static LSDispatchContext *LSDispatchContextCreate(const char *name , uint32_t queueCount , NSQualityOfService qos){
    LSDispatchContext *con = calloc(1, sizeof(LSDispatchContext));
    if (!con) {
        return NULL;
    }
    con->queues = calloc(queueCount, sizeof(void *));
    
    if (!con -> queues) {
        free(con);
        return NULL;
    }
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        dispatch_qos_class_t qos_class_t = NSQualityOfServiceToQOSClass(qos);
        for (NSUInteger i=0; i<queueCount; i++) {
            dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qos_class_t, 0);
            dispatch_queue_t queue= dispatch_queue_create(name, attr);
            con->queues[i] = (__bridge_retained void *)queue;
        }
    }else{
        long identifier = NSOperationQualityOfServiceToDispatchPriority(qos);
        for (NSUInteger i=0; i<queueCount; i++) {
            
            dispatch_queue_t queue= dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL);
            dispatch_set_target_queue(queue, dispatch_get_global_queue(identifier, 0));
            con->queues[i] = (__bridge_retained void *)queue;
        }
    }
    con->queueCount = queueCount;
    if (name) {
        con->name = strdup(name);
    }
    return con;
}

static void LSDispatchContextRelease(LSDispatchContext *con){
    if (!con) {
        return;
    }
    if (con->queues) {
        for (NSUInteger i=0; i<con->queueCount; i++) {
            void *queuePointer = con->queues[i];
            dispatch_queue_t queue = (__bridge_transfer dispatch_queue_t)(queuePointer);
            const char *name = dispatch_queue_get_label(queue)
            ;
            if (name) {
                strlen(name);
            }
            queue = nil;
        }
        free(con->queues);
        con->queues = NULL;
    }
    if (con->name) {
        free((void*)con->name);
    }
}

static dispatch_queue_t LSDispatchContextGetQueue(LSDispatchContext *con){
    int32_t counter = OSAtomicIncrement32(&con->counter);;
    if (counter < 0) {
        counter = -counter;
    }
    void *queue = con->queues[counter % con->queueCount];
    return (__bridge dispatch_queue_t)(queue);
}

static LSDispatchContext *LSDispatchContextGetForQOS(NSQualityOfService qos){
    static LSDispatchContext *con[5] = {0};
    switch (qos) {
        case NSQualityOfServiceUserInteractive:{
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1? 1 : count > MAX_QUEUE_Count ? MAX_QUEUE_Count : count;
                con[0] = LSDispatchContextCreate("Interactive", count, qos);
            });
            return con[0];
        }
            break;
        case NSQualityOfServiceUserInitiated:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1? 1 : count > MAX_QUEUE_Count ? MAX_QUEUE_Count : count;
                con[1] = LSDispatchContextCreate("Initiated", count, qos);
            });
            return con[1];
        }
            break;
        case NSQualityOfServiceUtility:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1? 1 : count > MAX_QUEUE_Count ? MAX_QUEUE_Count : count;
                con[2] = LSDispatchContextCreate("Utility", count, qos);
            });
            return con[2];
        }
            break;
        case NSQualityOfServiceBackground:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1? 1 : count > MAX_QUEUE_Count ? MAX_QUEUE_Count : count;
                con[3] = LSDispatchContextCreate("Background", count, qos);
            });
            return con[3];
        }
            break;
        case NSQualityOfServiceDefault:
        {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
                count = count < 1? 1 : count > MAX_QUEUE_Count ? MAX_QUEUE_Count : count;
                con[4] = LSDispatchContextCreate("Default", count, qos);
            });
            return con[4];
        }
            break;
    }
}
@implementation LSDispatchQueuePool
{
@public LSDispatchContext *_context;
}

-(void)dealloc
{
    if (_context) {
        LSDispatchContextRelease(_context);
        _context = NULL;
    }
}


-(instancetype)initWithName:(NSString *)name queueCount:(NSUInteger)queueCount qos:(NSQualityOfService)qos
{
    if (queueCount == 0 || queueCount > MAX_QUEUE_Count) {
        return nil;
    }
    self = [super init];
    if (self) {
        _context = LSDispatchContextCreate(name.UTF8String, (uint32_t)queueCount,qos);
    }
    if (!_context) {
        return nil;
    }
    _name = name;
    return self;
}

-(instancetype)initWithContext:(LSDispatchContext *)context
{
    if (!context) {
        return nil;
    }
    self = [super init];
    if (self) {
        _context = context;
        _name = context -> name ? [NSString stringWithUTF8String:context->name] : nil;
    }
    return self;
}
-(dispatch_queue_t)queue
{
    return LSDispatchContextGetQueue(_context);
}

+(instancetype)defaultPoolForQOS:(NSQualityOfService)qos
{
    switch (qos) {
        case NSQualityOfServiceUserInteractive:
        {
            static LSDispatchQueuePool *pool;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                pool = [[LSDispatchQueuePool alloc] initWithContext:LSDispatchContextGetForQOS(qos)];
            });
            return pool;
        }
            break;
        case NSQualityOfServiceUserInitiated:
        {
            static LSDispatchQueuePool *pool;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                pool = [[LSDispatchQueuePool alloc] initWithContext:LSDispatchContextGetForQOS(qos)];
            });
            return pool;
        }
            break;
        case NSQualityOfServiceUtility:
        {
            static LSDispatchQueuePool *pool;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                pool = [[LSDispatchQueuePool alloc] initWithContext:LSDispatchContextGetForQOS(qos)];
            });
            return pool;
        }
            break;
        case NSQualityOfServiceBackground:
        {
            static LSDispatchQueuePool *pool;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                pool = [[LSDispatchQueuePool alloc] initWithContext:LSDispatchContextGetForQOS(qos)];
            });
            return pool;
        }
            break;
        case NSQualityOfServiceDefault:
        {
            static LSDispatchQueuePool *pool;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                pool = [[LSDispatchQueuePool alloc] initWithContext:LSDispatchContextGetForQOS(NSQualityOfServiceDefault)];
            });
            return pool;
        }
            break;
    }
}
@end

dispatch_queue_t LSDispatchQueueGetForQOS(NSQualityOfService qos){
    return LSDispatchContextGetQueue(qos);
}