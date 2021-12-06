// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// Template Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
//


import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
 extension String {

   enum Error {
    /// API rate limit exceeded.\nWait a minute and try again
     static var apiRateLimit: String { String.tr("Localizable", "error.api_rate_limit") }
    /// Error
     static var error: String { String.tr("Localizable", "error.error") }
    /// Something went wrong. Please try again later
     static var somethingWentWrong: String { String.tr("Localizable", "error.something_went_wrong") }
    /// Unknown error
     static var undefinedError: String { String.tr("Localizable", "error.undefined_error") }
  }

   enum General {
    /// Accept
     static var accept: String { String.tr("Localizable", "general.accept") }
    /// Actions
     static var actions: String { String.tr("Localizable", "general.actions") }
    /// Add
     static var add: String { String.tr("Localizable", "general.add") }
    /// Allow
     static var allow: String { String.tr("Localizable", "general.allow") }
    /// Apply
     static var apply: String { String.tr("Localizable", "general.apply") }
    /// Back
     static var back: String { String.tr("Localizable", "general.back") }
    /// Begin
     static var begin: String { String.tr("Localizable", "general.begin") }
    /// Cancel
     static var cancel: String { String.tr("Localizable", "general.cancel") }
    /// Update
     static var change: String { String.tr("Localizable", "general.change") }
    /// Clear
     static var clear: String { String.tr("Localizable", "general.clear") }
    /// Close
     static var close: String { String.tr("Localizable", "general.close") }
    /// Collapse
     static var collapse: String { String.tr("Localizable", "general.collapse") }
    /// \nComing Soon...\n
     static var comingSoon: String { String.tr("Localizable", "general.coming_soon") }
    /// Confirm
     static var confirm: String { String.tr("Localizable", "general.confirm") }
    /// Continue
     static var `continue`: String { String.tr("Localizable", "general.continue") }
    /// Continue Editing
     static var continueEditing: String { String.tr("Localizable", "general.continue_editing") }
    /// Create
     static var create: String { String.tr("Localizable", "general.create") }
    /// Decline
     static var decline: String { String.tr("Localizable", "general.decline") }
    /// Delete
     static var delete: String { String.tr("Localizable", "general.delete") }
    /// Delete Changes
     static var deleteChanges: String { String.tr("Localizable", "general.delete_changes") }
    /// Deselect all
     static var deselectAll: String { String.tr("Localizable", "general.deselect_all") }
    /// Done
     static var done: String { String.tr("Localizable", "general.done") }
    /// Download
     static var download: String { String.tr("Localizable", "general.download") }
    /// Edit
     static var edit: String { String.tr("Localizable", "general.edit") }
    /// End
     static var end: String { String.tr("Localizable", "general.end") }
    /// Error
     static var error: String { String.tr("Localizable", "general.error") }
    /// Expand
     static var expand: String { String.tr("Localizable", "general.expand") }
    /// Explore
     static var explore: String { String.tr("Localizable", "general.explore") }
    /// Favorite
     static var favorite: String { String.tr("Localizable", "general.favorite") }
    /// Finish
     static var finish: String { String.tr("Localizable", "general.finish") }
    /// 🔥🔥🔥
     static var fire: String { String.tr("Localizable", "general.fire") }
    /// Invite
     static var invite: String { String.tr("Localizable", "general.invite") }
    /// Let’s Go!
     static var letsGo: String { String.tr("Localizable", "general.lets_go") }
    /// Next
     static var next: String { String.tr("Localizable", "general.next") }
    /// No
     static var no: String { String.tr("Localizable", "general.no") }
    /// No data
     static var noData: String { String.tr("Localizable", "general.no_data") }
    /// Ok
     static var ok: String { String.tr("Localizable", "general.ok") }
    /// Okay
     static var okay: String { String.tr("Localizable", "general.okay") }
    /// Oops!
     static var oops: String { String.tr("Localizable", "general.oops") }
    /// Remove
     static var remove: String { String.tr("Localizable", "general.remove") }
    /// Replace
     static var replace: String { String.tr("Localizable", "general.replace") }
    /// Reset
     static var reset: String { String.tr("Localizable", "general.reset") }
    /// Retry
     static var retry: String { String.tr("Localizable", "general.retry") }
    /// Review
     static var review: String { String.tr("Localizable", "general.review") }
    /// Roll up
     static var rollUp: String { String.tr("Localizable", "general.roll_up") }
    /// Save
     static var save: String { String.tr("Localizable", "general.save") }
    /// Save to Files
     static var saveToFiles: String { String.tr("Localizable", "general.save_to_files") }
    /// Save to Gallery
     static var saveToGallery: String { String.tr("Localizable", "general.save_to_gallery") }
    /// Search
     static var search: String { String.tr("Localizable", "general.search") }
    /// Search
     static var searchPlaceholder: String { String.tr("Localizable", "general.search_placeholder") }
    /// See All
     static var seeAll: String { String.tr("Localizable", "general.see_all") }
    /// Select
     static var select: String { String.tr("Localizable", "general.select") }
    /// Select all
     static var selectAll: String { String.tr("Localizable", "general.select_all") }
    /// Select File
     static var selectFile: String { String.tr("Localizable", "general.select_file") }
    /// Send
     static var send: String { String.tr("Localizable", "general.send") }
    /// Share
     static var share: String { String.tr("Localizable", "general.share") }
    /// Show
     static var show: String { String.tr("Localizable", "general.show") }
    /// Show all
     static var showAll: String { String.tr("Localizable", "general.show_all") }
    /// Show more
     static var showMore: String { String.tr("Localizable", "general.show_more") }
    /// Sign In
     static var signIn: String { String.tr("Localizable", "general.sign_in") }
    /// Sign Out
     static var signOut: String { String.tr("Localizable", "general.sign_out") }
    /// Skip
     static var skip: String { String.tr("Localizable", "general.skip") }
    /// Sorting
     static var sorting: String { String.tr("Localizable", "general.sorting") }
    /// Submit
     static var submit: String { String.tr("Localizable", "general.submit") }
    /// Tap to close
     static var tapToClose: String { String.tr("Localizable", "general.tap_to_close") }
    /// Tap to back
     static var tapToBack: String { String.tr("Localizable", "general.tapToBack") }
    /// Thank you!
     static var thankyou: String { String.tr("Localizable", "general.thankyou") }
    /// Tip
     static var tip: String { String.tr("Localizable", "general.tip") }
    /// Update
     static var update: String { String.tr("Localizable", "general.update") }
    /// Use
     static var use: String { String.tr("Localizable", "general.use") }
    /// Verify
     static var verify: String { String.tr("Localizable", "general.verify") }
    /// Version
     static var version: String { String.tr("Localizable", "general.version") }
    /// Warning
     static var warning: String { String.tr("Localizable", "general.warning") }
    /// Yes
     static var yes: String { String.tr("Localizable", "general.yes") }
  }

   enum GitHub {
    /// found Top-%d repositories
     static func info(_ p1: Int) -> String {
      return String.tr("Localizable", "git_hub.info", p1)
    }
    /// More
     static var more: String { String.tr("Localizable", "git_hub.more") }
    /// Most popular repositories
     static var mostPopular: String { String.tr("Localizable", "git_hub.most_popular") }
    /// GitHub
     static var title: String { String.tr("Localizable", "git_hub.title") }
  }

   enum Popup {

     enum Languages {
      /// Choose your love
       static var title: String { String.tr("Localizable", "popup.languages.title") }
    }
  }

   enum Welcome {
    ///  and 
     static var and: String { String.tr("Localizable", "welcome.and") }
    /// Enter the app
     static var enterTeApp: String { String.tr("Localizable", "welcome.enter_te_app") }
    /// Go to Xapo
     static var goToXapo: String { String.tr("Localizable", "welcome.go_to_xapo") }
    /// iOS Test for Xapo bank
     static var info: String { String.tr("Localizable", "welcome.info") }
    /// Privacy policy
     static var privacy: String { String.tr("Localizable", "welcome.privacy") }
    /// Terms of use
     static var termsOfUse: String { String.tr("Localizable", "welcome.terms_of_use") }
    /// Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.
     static var textPlaceholder: String { String.tr("Localizable", "welcome.text_placeholder") }
    /// Welcome to iOS Test
     static var title: String { String.tr("Localizable", "welcome.title") }
    /// View Details
     static var viewDetails: String { String.tr("Localizable", "welcome.view_details") }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension String {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let localeId = Config.currentLanguage
    guard let path = Bundle.main.path(forResource: localeId, ofType: "lproj"),
        let bundle = Bundle(path: path) else {
        return NSLocalizedString(key, comment: "")
    }
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    let locale = Locale(identifier: localeId)
    return String(format: format, locale: locale, arguments: args)
  }
  static func i18NItem(_ key: String) -> String {
    return tr("LocalizedUI", key)
  }
}

private final class BundleToken {}
