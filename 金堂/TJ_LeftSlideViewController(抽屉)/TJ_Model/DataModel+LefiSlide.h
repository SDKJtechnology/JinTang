//
//  DataModel+LefiSlide.h
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel.h"

@interface DataModel (LefiSlide)
/**
 *  根据ID获取我的回帖列表数据
 *
 *  @param success 访问成功后回调
 *  @param failure 访问失败回调
 *  @param ID 帖子ID
 */
- (void)getReturnInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据ID获取我的发帖列表数据
 *
 *  @param ID      帖子ID
 *  @param success 访问成功后回调
 *  @param failure 访问失败回调
 */
- (void)getPostingInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;
/**
 *  根据ID获取我收藏帖子列表数据
 *
 *  @param ID      帖子ID
 *  @param success 访问成功后回调
 *  @param failure 访问失败回调
 */
- (void)getEnshrineInvitationDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;

@end
