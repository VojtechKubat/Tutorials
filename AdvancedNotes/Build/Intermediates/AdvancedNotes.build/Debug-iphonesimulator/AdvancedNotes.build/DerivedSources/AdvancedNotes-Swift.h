// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import CoreData;
@import UIKit;
@import CoreGraphics;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSDate;
@class NSEntityDescription;
@class NSManagedObjectContext;

SWIFT_CLASS("_TtC13AdvancedNotes8ANEntity")
@interface ANEntity : NSManagedObject
@property (nonatomic, readonly, strong) NSDate * _Null_unspecified getLastChange;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC13AdvancedNotes11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface AppDelegate (SWIFT_EXTENSION(AdvancedNotes))
- (void)importDummyData;
@end


SWIFT_CLASS("_TtC13AdvancedNotes12DescendantID")
@interface DescendantID : NSManagedObject
+ (DescendantID * _Nullable)parseJsonToDescendantID:(NSInteger)descID context:(NSManagedObjectContext * _Nonnull)context;
+ (DescendantID * _Nullable)parseJsonToDescendantID:(NSInteger)descID context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSNumber;

@interface DescendantID (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, strong) NSNumber * _Nullable id;
@end

@class Note;
@class UILabel;
@class UIViewController;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC13AdvancedNotes19DetailNavController")
@interface DetailNavController : UINavigationController
@property (nonatomic, copy) NSString * _Nonnull headline;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified mainLabel;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)configureDetail:(Note * _Nonnull)note;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSTextContainer;

SWIFT_CLASS("_TtC13AdvancedNotes13FrameTextView")
@interface FrameTextView : UITextView
@property (nonatomic) BOOL autoShrink;
- (void)didMoveToSuperview;
- (nonnull instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer * _Nullable)textContainer OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)addBorders;
@end

@class NSLayoutConstraint;

SWIFT_CLASS("_TtC13AdvancedNotes17MainTableViewCell")
@interface MainTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified headlineLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * _Null_unspecified leftHeading;
- (void)configureCell:(Note * _Nonnull)note;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSFetchedResultsController;
@class UITableView;
@class NSIndexPath;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC13AdvancedNotes20MasterViewController")
@interface MasterViewController : UITableViewController
@property (nonatomic, strong) NSFetchedResultsController * _Null_unspecified fetchedResultsController;
- (void)viewDidLoad;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NSDate (SWIFT_EXTENSION(AdvancedNotes))
+ (NSDate * _Nonnull)isoToDate:(NSString * _Nonnull)dateInString;
@end


@interface NSManagedObject (SWIFT_EXTENSION(AdvancedNotes))
+ (NSManagedObject * _Nullable)myNewEntity:(NSManagedObjectContext * _Nonnull)context;
@end

@class NSDictionary;

SWIFT_CLASS("_TtC13AdvancedNotes4Note")
@interface Note : ANEntity
@property (nonatomic, readonly, strong) NSDate * _Null_unspecified getLastChange;
+ (Note * _Nullable)parseJsonToNote:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context;
+ (Note * _Nullable)parseJsonToNote:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSSet;

@interface Note (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, strong) NSNumber * _Nullable active;
@property (nonatomic, copy) NSString * _Nullable headline;
@property (nonatomic, strong) NSDate * _Nullable lastChange;
@property (nonatomic, strong) NSNumber * _Nullable priority;
@property (nonatomic, strong) NSNumber * _Nullable id;
@property (nonatomic, strong) NSSet * _Nullable hasChild;
@property (nonatomic, strong) NSSet * _Nullable hasParagraph;
@property (nonatomic, strong) NSSet * _Nullable hasPicture;
@property (nonatomic, strong) NSSet * _Nullable hasReminder;
@property (nonatomic, strong) NSSet * _Nullable isTagged;
@property (nonatomic, strong) Note * _Nullable hasParent;
@property (nonatomic, strong) NSSet * _Nullable hasDescendantID;
@end


SWIFT_CLASS("_TtC13AdvancedNotes9Paragraph")
@interface Paragraph : ANEntity
@property (nonatomic, readonly, strong) NSDate * _Null_unspecified getLastChange;
+ (Paragraph * _Nullable)parseJsonToParagraph:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context;
+ (Paragraph * _Nullable)parseJsonToParagraph:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Paragraph (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, strong) NSNumber * _Nullable active;
@property (nonatomic, strong) NSDate * _Nullable lastChange;
@property (nonatomic, copy) NSString * _Nullable text;
@property (nonatomic, strong) NSNumber * _Nullable id;
@property (nonatomic, strong) Note * _Nullable relatesToNote;
@end

@class SummaryViewController;

SWIFT_CLASS("_TtC13AdvancedNotes15SummaryCellView")
@interface SummaryCellView : UITableViewCell
@property (nonatomic, strong) SummaryViewController * _Nullable parentVC;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIButton;

SWIFT_CLASS("_TtC13AdvancedNotes17ParagraphViewCell")
@interface ParagraphViewCell : SummaryCellView
@property (nonatomic, weak) Paragraph * _Nullable myParagraph;
@property (nonatomic, weak) IBOutlet FrameTextView * _Null_unspecified paragraphTextView;
- (IBAction)remove:(UIButton * _Nonnull)sender;
- (IBAction)edit:(UIButton * _Nonnull)sender;
- (void)setParagraph:(Paragraph * _Nonnull)paragraph;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIBarButtonItem;

SWIFT_CLASS("_TtC13AdvancedNotes23ParagraphViewController")
@interface ParagraphViewController : UIViewController
@property (nonatomic, weak) IBOutlet FrameTextView * _Null_unspecified textView;
- (IBAction)discardChanges:(UIBarButtonItem * _Nonnull)sender;
- (void)viewDidLoad;
- (void)viewWillDisappear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSURL;
@class NSData;

SWIFT_CLASS("_TtC13AdvancedNotes7Picture")
@interface Picture : ANEntity
@property (nonatomic, readonly, strong) NSDate * _Null_unspecified getLastChange;
+ (Picture * _Nullable)parseJsonToPicture:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context;
+ (Picture * _Nullable)parseJsonToPicture:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
+ (NSData * _Nonnull)dataForURLImage:(NSURL * _Nonnull)url;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Picture (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, strong) NSNumber * _Nullable active;
@property (nonatomic, strong) NSData * _Nullable image;
@property (nonatomic, strong) NSDate * _Nullable lastChange;
@property (nonatomic, copy) NSString * _Nullable textDetail;
@property (nonatomic, strong) NSNumber * _Nullable id;
@property (nonatomic, strong) Note * _Nullable relatesToNote;
@end


SWIFT_CLASS("_TtC13AdvancedNotes15PictureCellView")
@interface PictureCellView : SummaryCellView
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13AdvancedNotes8Reminder")
@interface Reminder : ANEntity
@property (nonatomic, readonly, strong) NSDate * _Null_unspecified getLastChange;
+ (Reminder * _Nullable)parseJsonToReminder:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context;
+ (Reminder * _Nullable)parseJsonToReminder:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Reminder (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, strong) NSNumber * _Nullable active;
@property (nonatomic, copy) NSString * _Nullable recurrence;
@property (nonatomic, strong) NSDate * _Nullable time;
@property (nonatomic, strong) NSNumber * _Nullable type;
@property (nonatomic, strong) NSNumber * _Nullable id;
@property (nonatomic, strong) Note * _Nullable relatesToNote;
@end


SWIFT_CLASS("_TtC13AdvancedNotes16ReminderViewCell")
@interface ReminderViewCell : SummaryCellView
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13AdvancedNotes23RemindersViewController")
@interface RemindersViewController : UIViewController
- (void)viewDidLoad;
- (void)addReminder;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@class NSSortDescriptor;

SWIFT_CLASS("_TtC13AdvancedNotes21SummaryViewController")
@interface SummaryViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified tableView;
@property (nonatomic, strong) NSSortDescriptor * _Nonnull sort;
@property (nonatomic, readonly, copy) BOOL (^ _Nonnull compareByLastChange)(ANEntity * _Nonnull, ANEntity * _Nonnull);
@property (nonatomic, strong) Note * _Nullable note;
@property (nonatomic, copy) NSSet<ANEntity *> * _Nonnull contentSet;
@property (nonatomic, copy) NSArray<ANEntity *> * _Nonnull contentListFiltered;
- (IBAction)addAttachment:(UIBarButtonItem * _Nonnull)sender;
- (void)viewDidLoad;
- (void)refresh;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (void)editItem:(ANEntity * _Nullable)entitiy;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface SummaryViewController (SWIFT_EXTENSION(AdvancedNotes)) <UITableViewDelegate, UIScrollViewDelegate>
@end


@interface SummaryViewController (SWIFT_EXTENSION(AdvancedNotes)) <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


SWIFT_CLASS("_TtC13AdvancedNotes3Tag")
@interface Tag : NSManagedObject
+ (Tag * _Nullable)parseJsonToTag:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context;
+ (Tag * _Nullable)parseJsonToTag:(NSDictionary * _Nonnull)jsonDict context:(NSManagedObjectContext * _Nonnull)context save:(BOOL)save;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Tag (SWIFT_EXTENSION(AdvancedNotes))
@property (nonatomic, copy) NSString * _Nullable label;
@property (nonatomic, strong) NSNumber * _Nullable id;
@property (nonatomic, strong) NSSet * _Nullable relatesToNote;
@end

#pragma clang diagnostic pop
