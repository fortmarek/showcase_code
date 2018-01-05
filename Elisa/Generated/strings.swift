// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Badges {
    /// Awesome!
    static let awesome = L10n.tr("Localizable", "badges.awesome")
    /// Badges
    static let badges = L10n.tr("Localizable", "badges.badges")
    /// No badges yet, keep learning!
    static let noBadges = L10n.tr("Localizable", "badges.noBadges")
    /// I just got badge for %@!
    static func shareBadge(_ p1: String) -> String {
      return L10n.tr("Localizable", "badges.shareBadge", p1)
    }
  }

  enum Category {
    /// Categories
    static let categories = L10n.tr("Localizable", "category.categories")
    /// Featured
    static let featured = L10n.tr("Localizable", "category.featured")
    /// Recommended
    static let recommended = L10n.tr("Localizable", "category.recommended")
  }

  enum Connection {
    /// Check your connection
    static let checkConnection = L10n.tr("Localizable", "connection.checkConnection")
  }

  enum Course {
    /// Chapter %d
    static func chapter(_ p1: Int) -> String {
      return L10n.tr("Localizable", "course.chapter", p1)
    }
    /// Course Progress
    static let courseProgress = L10n.tr("Localizable", "course.courseProgress")
    /// Lessons
    static let lessons = L10n.tr("Localizable", "course.lessons")
    /// No reviews yet
    static let noReviews = L10n.tr("Localizable", "course.noReviews")
    /// Not enough info filled in
    static let notEnoughInfo = L10n.tr("Localizable", "course.notEnoughInfo")
    /// Sending rating failed
    static let ratingFailed = L10n.tr("Localizable", "course.ratingFailed")
    /// Sending rating succeded
    static let ratingSucceeded = L10n.tr("Localizable", "course.ratingSucceeded")
    /// Review
    static let review = L10n.tr("Localizable", "course.review")
    /// Sending Review Failed
    static let reviewFailed = L10n.tr("Localizable", "course.reviewFailed")
    /// Reviews
    static let reviews = L10n.tr("Localizable", "course.reviews")
    /// Sending the review succeeded
    static let reviewSucceeded = L10n.tr("Localizable", "course.reviewSucceeded")
    /// I am learning about %@ in Elisa app, download it here: 
    static func shareCourse(_ p1: String) -> String {
      return L10n.tr("Localizable", "course.shareCourse", p1)
    }
    /// Tap to Rate: 
    static let tapToRate = L10n.tr("Localizable", "course.tapToRate")
    /// Write a Review
    static let writeReview = L10n.tr("Localizable", "course.writeReview")
  }

  enum Date {
    /// %d %@ ago
    static func ago(_ p1: Int, _ p2: String) -> String {
      return L10n.tr("Localizable", "date.ago", p1, p2)
    }
    /// day
    static let day = L10n.tr("Localizable", "date.day")
    /// days
    static let days = L10n.tr("Localizable", "date.days")
    /// hour
    static let hour = L10n.tr("Localizable", "date.hour")
    /// hours
    static let hours = L10n.tr("Localizable", "date.hours")
    /// minute
    static let minute = L10n.tr("Localizable", "date.minute")
    /// minutes
    static let minutes = L10n.tr("Localizable", "date.minutes")
    /// month
    static let month = L10n.tr("Localizable", "date.month")
    /// months
    static let months = L10n.tr("Localizable", "date.months")
    /// Recently
    static let recently = L10n.tr("Localizable", "date.recently")
    /// week
    static let week = L10n.tr("Localizable", "date.week")
    /// weeks
    static let weeks = L10n.tr("Localizable", "date.weeks")
    /// year
    static let year = L10n.tr("Localizable", "date.year")
    /// years
    static let years = L10n.tr("Localizable", "date.years")
  }

  enum Game {
    /// Check
    static let check = L10n.tr("Localizable", "game.check")
    /// Continue
    static let continueTitle = L10n.tr("Localizable", "game.continueTitle")
    /// Finish Lesson
    static let finishLesson = L10n.tr("Localizable", "game.finishLesson")
    /// Try Again!
    static let tryAgain = L10n.tr("Localizable", "game.tryAgain")
  }

  enum General {
    /// Cancel
    static let cancel = L10n.tr("Localizable", "general.cancel")
    /// Pull to refresh
    static let pullToRefresh = L10n.tr("Localizable", "general.pullToRefresh")
    /// Send
    static let send = L10n.tr("Localizable", "general.send")
    /// Share
    static let share = L10n.tr("Localizable", "general.share")
    /// Try this app and learn something!
    static let shareApp = L10n.tr("Localizable", "general.shareApp")
  }

  enum Home {
    /// SEE ALL
    static let seeAll = L10n.tr("Localizable", "home.seeAll")
    /// Courses
    static let title = L10n.tr("Localizable", "home.title")
  }

  enum Leaderboard {
    /// Friends
    static let friends = L10n.tr("Localizable", "leaderboard.friends")
    /// Invite Friends
    static let inviteFriends = L10n.tr("Localizable", "leaderboard.inviteFriends")
    /// Leaderboard
    static let leaderboard = L10n.tr("Localizable", "leaderboard.leaderboard")
  }

  enum Login {
    /// Forgot?
    static let forgot = L10n.tr("Localizable", "login.forgot")
    /// Log In
    static let login = L10n.tr("Localizable", "login.login")
  }

  enum Mycourses {
    /// All
    static let all = L10n.tr("Localizable", "myCourses.all")
    /// No courses yet
    static let allEmpty = L10n.tr("Localizable", "myCourses.allEmpty")
    /// Completed
    static let completed = L10n.tr("Localizable", "myCourses.completed")
    /// No completed courses yet, keep working!
    static let completedEmpty = L10n.tr("Localizable", "myCourses.completedEmpty")
    /// Ongoing
    static let ongoing = L10n.tr("Localizable", "myCourses.ongoing")
    /// No ongoing courses yet
    static let ongoingEmpty = L10n.tr("Localizable", "myCourses.ongoingEmpty")
  }

  enum Popup {
    /// Cancel
    static let cancel = L10n.tr("Localizable", "popup.cancel")
    /// Enable
    static let enable = L10n.tr("Localizable", "popup.enable")
    /// Later
    static let later = L10n.tr("Localizable", "popup.later")
    /// No
    static let no = L10n.tr("Localizable", "popup.no")
    /// Notifications
    static let notifications = L10n.tr("Localizable", "popup.notifications")
    /// To get alerts from friends and what's new, turn on notifications
    static let notificationsDescription = L10n.tr("Localizable", "popup.notificationsDescription")
    /// Restart Lesson
    static let restart = L10n.tr("Localizable", "popup.restart")
    /// Do you want to restart lesson?
    static let restartDescription = L10n.tr("Localizable", "popup.restartDescription")
    /// Settings
    static let settings = L10n.tr("Localizable", "popup.settings")
    /// In settings turn on notifications for Elisa
    static let settingsDescription = L10n.tr("Localizable", "popup.settingsDescription")
    /// Yes
    static let yes = L10n.tr("Localizable", "popup.yes")
  }

  enum Profile {
    /// Change Password
    static let changePassword = L10n.tr("Localizable", "profile.changePassword")
    /// Contact
    static let contact = L10n.tr("Localizable", "profile.contact")
    /// Edit Profile
    static let editProfile = L10n.tr("Localizable", "profile.editProfile")
    /// General
    static let general = L10n.tr("Localizable", "profile.general")
    /// Logout
    static let logout = L10n.tr("Localizable", "profile.logout")
    /// Name
    static let name = L10n.tr("Localizable", "profile.name")
    /// Privacy Policy
    static let privacy = L10n.tr("Localizable", "profile.privacy")
    /// Rate App
    static let rateApp = L10n.tr("Localizable", "profile.rateApp")
    /// Save
    static let save = L10n.tr("Localizable", "profile.save")
    /// Saving profile failed
    static let saveFailed = L10n.tr("Localizable", "profile.saveFailed")
    /// Saving profile succeded
    static let saveSucceded = L10n.tr("Localizable", "profile.saveSucceded")
    /// Success
    static let success = L10n.tr("Localizable", "profile.success")
    /// Support
    static let support = L10n.tr("Localizable", "profile.support")
    /// Terms and Conditions
    static let terms = L10n.tr("Localizable", "profile.terms")
    /// Version %@
    static func version(_ p1: String) -> String {
      return L10n.tr("Localizable", "profile.version", p1)
    }
  }

  enum Signup {
    /// By pressing '%@' you agree to our
    static func agreeTitle(_ p1: String) -> String {
      return L10n.tr("Localizable", "signup.agreeTitle", p1)
    }
    /// e-mail
    static let email = L10n.tr("Localizable", "signup.email")
    /// Join
    static let join = L10n.tr("Localizable", "signup.join")
    /// first & last name
    static let name = L10n.tr("Localizable", "signup.name")
    /// password
    static let password = L10n.tr("Localizable", "signup.password")
    /// terms & conditions
    static let termsAndConditions = L10n.tr("Localizable", "signup.termsAndConditions")
  }

  enum Tabbar {
    /// Achievements
    static let achievements = L10n.tr("Localizable", "tabBar.achievements")
    /// Home
    static let home = L10n.tr("Localizable", "tabBar.home")
    /// My Courses
    static let myCourses = L10n.tr("Localizable", "tabBar.myCourses")
    /// Profile
    static let profile = L10n.tr("Localizable", "tabBar.profile")
  }

  enum User {
    /// Add Friend
    static let addFriend = L10n.tr("Localizable", "user.addFriend")
    /// %d Points
    static func points(_ p1: Int) -> String {
      return L10n.tr("Localizable", "user.points", p1)
    }
    /// POINTS
    static let pointsTitle = L10n.tr("Localizable", "user.pointsTitle")
  }

  enum Welcome {
    /// Log In
    static let logIn = L10n.tr("Localizable", "welcome.logIn")
    /// Log In With Facebook
    static let logInFacebook = L10n.tr("Localizable", "welcome.logInFacebook")
    /// Sign Up
    static let signUp = L10n.tr("Localizable", "welcome.signUp")
    /// Never stop learning
    static let title = L10n.tr("Localizable", "welcome.title")
    /// Welcome
    static let welcome = L10n.tr("Localizable", "welcome.welcome")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
