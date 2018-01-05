// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  typealias AssetColorTypeAlias = NSColor
  typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias AssetColorTypeAlias = UIColor
  typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
typealias AssetType = ImageAsset

struct ImageAsset {
  fileprivate var name: String

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

struct ColorAsset {
  fileprivate var name: String

  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
  #endif
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  static let achievements = ImageAsset(name: "achievements")
  static let addFriend = ImageAsset(name: "addFriend")
  static let arrow = ImageAsset(name: "arrow")
  static let artwork = ImageAsset(name: "artwork")
  static let back = ImageAsset(name: "back")
  static let badge1 = ImageAsset(name: "badge1")
  static let badge2 = ImageAsset(name: "badge2")
  static let badge3 = ImageAsset(name: "badge3")
  static let badge4 = ImageAsset(name: "badge4")
  static let badges = ImageAsset(name: "badges")
  static let badgesSelected = ImageAsset(name: "badgesSelected")
  static let book = ImageAsset(name: "book")
  static let bookSelected = ImageAsset(name: "bookSelected")
  static let businessIcon = ImageAsset(name: "businessIcon")
  static let bussinessManagementFeatured = ImageAsset(name: "bussinessManagementFeatured")
  static let cancelButton = ImageAsset(name: "cancelButton")
  static let checkmark = ImageAsset(name: "checkmark")
  static let closeArrow = ImageAsset(name: "closeArrow")
  static let computingIcon = ImageAsset(name: "computingIcon")
  static let connectionError = ImageAsset(name: "connectionError")
  static let cornflowerStar = ImageAsset(name: "cornflowerStar")
  static let designIcon = ImageAsset(name: "designIcon")
  static let economyIcon = ImageAsset(name: "economyIcon")
  static let editIcon = ImageAsset(name: "editIcon")
  static let emptyStar = ImageAsset(name: "emptyStar")
  static let error = ImageAsset(name: "error")
  static let fullStar = ImageAsset(name: "fullStar")
  static let guitarFeatured = ImageAsset(name: "guitarFeatured")
  static let halfStar = ImageAsset(name: "halfStar")
  static let home = ImageAsset(name: "home")
  static let homeSelected = ImageAsset(name: "homeSelected")
  static let literatureIcon = ImageAsset(name: "literatureIcon")
  static let loadingIcon = ImageAsset(name: "loadingIcon")
  static let loadingIconShadow = ImageAsset(name: "loadingIconShadow")
  static let login = ImageAsset(name: "login")
  static let logoutIcon = ImageAsset(name: "logoutIcon")
  static let medicineFeatured = ImageAsset(name: "medicineFeatured")
  static let medicineIcon = ImageAsset(name: "medicineIcon")
  static let messages = ImageAsset(name: "messages")
  static let more = ImageAsset(name: "more")
  static let moreSelected = ImageAsset(name: "moreSelected")
  static let myCourse = ImageAsset(name: "myCourse")
  static let myCoursesSelected = ImageAsset(name: "myCoursesSelected")
  static let noCourses = ImageAsset(name: "noCourses")
  static let notificationAlert = ImageAsset(name: "notificationAlert")
  static let oval3 = ImageAsset(name: "oval3")
  static let paperIcon = ImageAsset(name: "paperIcon")
  static let privacy = ImageAsset(name: "privacy")
  static let profile = ImageAsset(name: "profile")
  static let profileDefault = ImageAsset(name: "profileDefault")
  static let profileDefaultWhite = ImageAsset(name: "profileDefaultWhite")
  static let profilePic = ImageAsset(name: "profilePic")
  static let profileSelected = ImageAsset(name: "profileSelected")
  static let rateEmptyStar = ImageAsset(name: "rateEmptyStar")
  static let restartAlert = ImageAsset(name: "restartAlert")
  static let rightAnswer = ImageAsset(name: "rightAnswer")
  static let search = ImageAsset(name: "search")
  static let selectedIndicator = ImageAsset(name: "selectedIndicator")
  static let share = ImageAsset(name: "share")
  static let shareAchievement = ImageAsset(name: "shareAchievement")
  static let shareProfile = ImageAsset(name: "shareProfile")
  static let star = ImageAsset(name: "star")
  static let starProfile = ImageAsset(name: "starProfile")
  static let supportIcon = ImageAsset(name: "supportIcon")
  static let unselectedIndicator = ImageAsset(name: "unselectedIndicator")
  static let welcomeArtwork = ImageAsset(name: "welcomeArtwork")
  static let writeReviewIcon = ImageAsset(name: "writeReviewIcon")

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    achievements,
    addFriend,
    arrow,
    artwork,
    back,
    badge1,
    badge2,
    badge3,
    badge4,
    badges,
    badgesSelected,
    book,
    bookSelected,
    businessIcon,
    bussinessManagementFeatured,
    cancelButton,
    checkmark,
    closeArrow,
    computingIcon,
    connectionError,
    cornflowerStar,
    designIcon,
    economyIcon,
    editIcon,
    emptyStar,
    error,
    fullStar,
    guitarFeatured,
    halfStar,
    home,
    homeSelected,
    literatureIcon,
    loadingIcon,
    loadingIconShadow,
    login,
    logoutIcon,
    medicineFeatured,
    medicineIcon,
    messages,
    more,
    moreSelected,
    myCourse,
    myCoursesSelected,
    noCourses,
    notificationAlert,
    oval3,
    paperIcon,
    privacy,
    profile,
    profileDefault,
    profileDefaultWhite,
    profilePic,
    profileSelected,
    rateEmptyStar,
    restartAlert,
    rightAnswer,
    search,
    selectedIndicator,
    share,
    shareAchievement,
    shareProfile,
    star,
    starProfile,
    supportIcon,
    unselectedIndicator,
    welcomeArtwork,
    writeReviewIcon,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

private final class BundleToken {}
