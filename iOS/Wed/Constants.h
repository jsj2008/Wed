//
//  Constants.h
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#ifndef Wed_Constants_h
#define Wed_Constants_h


/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define PRFontHelveticaNeueLight @"HelveticaNeue-Light"
#define PRFontHelveticaNeueRegular @"HelveticaNeue"

#define PRDropboxFilesPrefix @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/"
#define PRDropboxEventsScheduleURL  @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/schedule_list.plist"
#define PRDropboxThakurFamilyURL @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/thakurs_family.plist"
#define PRDropboxTayalFamilyURL @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/tayals_family.plist"
#define PRDropboxVenuesURL @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/venues.plist"
#define PRDropboxEventDetailURL @"https://dl.dropboxusercontent.com/u/57884865/wedding_app_files/event_detail.plist"

#define NAVIGATIONBARBACKBUTTON @"back.png"

#define PRAppikonServerUploadImageURL @"http://appikon.com/wedding_app/upload/"
#define AppUpdateURL @"itms-services://?action=download-manifest&url=http://appikon.com/wedding_app/wed.plist"
#define VersionCheckPlistURL @"http://appikon.com/wedding_app/versions.plist"

//Coachmarks booleans
#define PRCoachMarksEventsSeen @"event_coachmarks_seen"

#endif
