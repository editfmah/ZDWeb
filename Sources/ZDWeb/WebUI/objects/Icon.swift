//
//  Icon.swift
//
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

// Define the Icon Size, Weight, and Style Enums
public enum IconSize: String {
    case xsmall = "fa-xs"
    case small = "fa-sm"
    case large = "fa-lg"
    case x2 = "fa-2x"
    case x3 = "fa-3x"
    case x4 = "fa-4x"
    case x5 = "fa-5x"
    case x6 = "fa-6x"
    case x7 = "fa-7x"
    case x8 = "fa-8x"
    case x9 = "fa-9x"
    case x10 = "fa-10x"
}

// Define the WebIconProperties Protocol
public protocol WebIconProperties: GenericProperties {
    func color(_ color: WebColor) -> Self
    func size(_ size: IconSize) -> Self
}

// Implement the WebIconProperties Protocol
public extension WebIconProperties {
    @discardableResult
    func color(_ color: WebColor) -> Self {
        script("""
            if (\(builderId)) {
                \(builderId).style.color = '\(color.rgba)';
            }
        """)
        return self
    }
    
    @discardableResult
    func size(_ size: IconSize) -> Self {
        script("""
            if (\(builderId)) {
                \(builderId).classList.remove('fa-xs', 'fa-sm', 'fa-lg', 'fa-2x', 'fa-3x', 'fa-4x', 'fa-5x', 'fa-6x', 'fa-7x', 'fa-8x', 'fa-9x', 'fa-10x');
                \(builderId).classList.add('\(size.rawValue)');
            }
        """)
        return self
    }
    
}

// Define the Icon Control Class
public class Icon : WebElement, WebIconProperties {
    private var iconClass: FontAwesomeIcon
    
    @discardableResult
    public init(_ icon: FontAwesomeIcon) {
        self.iconClass = icon
        super.init()
        
        declare("i", identifier: icon.rawValue + " " + self.builderId, id: self.builderId) {}
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}

public enum FontAwesomeIcon: String {
 
    case addressBook = "fa-address-book fa-solid"
    case addressCard = "fa-address-card fa-solid"
    case adjust = "fa-adjust fa-solid"
    case alignCenter = "fa-align-center fa-solid"
    case alignJustify = "fa-align-justify fa-solid"
    case alignLeft = "fa-align-left fa-solid"
    case alignRight = "fa-align-right fa-solid"
    case anchor = "fa-anchor fa-solid"
    case angleDoubleDown = "fa-angle-double-down fa-solid"
    case angleDoubleLeft = "fa-angle-double-left fa-solid"
    case angleDoubleRight = "fa-angle-double-right fa-solid"
    case angleDoubleUp = "fa-angle-double-up fa-solid"
    case angleDown = "fa-angle-down fa-solid"
    case angleLeft = "fa-angle-left fa-solid"
    case angleRight = "fa-angle-right fa-solid"
    case angleUp = "fa-angle-up fa-solid"
    case archive = "fa-archive fa-solid"
    case arrowCircleDown = "fa-arrow-circle-down fa-solid"
    case arrowCircleLeft = "fa-arrow-circle-left fa-solid"
    case arrowCircleRight = "fa-arrow-circle-right fa-solid"
    case arrowCircleUp = "fa-arrow-circle-up fa-solid"
    case arrowDown = "fa-arrow-down fa-solid"
    case arrowLeft = "fa-arrow-left fa-solid"
    case arrowRight = "fa-arrow-right fa-solid"
    case arrowUp = "fa-arrow-up fa-solid"
    case arrowsAlt = "fa-arrows-alt fa-solid"
    case asterisk = "fa-asterisk fa-solid"
    case at = "fa-at fa-solid"
    case award = "fa-award fa-solid"
    case backspace = "fa-backspace fa-solid"
    case backward = "fa-backward fa-solid"
    case balanceScale = "fa-balance-scale fa-solid"
    case ban = "fa-ban fa-solid"
    case barcode = "fa-barcode fa-solid"
    case bars = "fa-bars fa-solid"
    case bell = "fa-bell fa-solid"
    case bellSlash = "fa-bell-slash fa-solid"
    case bold = "fa-bold fa-solid"
    case book = "fa-book fa-solid"
    case bookmark = "fa-bookmark fa-solid"
    case briefcase = "fa-briefcase fa-solid"
    case building = "fa-building fa-solid"
    case bullhorn = "fa-bullhorn fa-solid"
    case bullseye = "fa-bullseye fa-solid"
    case calendar = "fa-calendar fa-solid"
    case calendarAlt = "fa-calendar-alt fa-solid"
    case calendarCheck = "fa-calendar-check fa-solid"
    case calendarMinus = "fa-calendar-minus fa-solid"
    case calendarPlus = "fa-calendar-plus fa-solid"
    case calendarTimes = "fa-calendar-times fa-solid"
    case camera = "fa-camera fa-solid"
    case cameraRetro = "fa-camera-retro fa-solid"
    case caretDown = "fa-caret-down fa-solid"
    case caretLeft = "fa-caret-left fa-solid"
    case caretRight = "fa-caret-right fa-solid"
    case caretUp = "fa-caret-up fa-solid"
    case chartArea = "fa-chart-area fa-solid"
    case chartBar = "fa-chart-bar fa-solid"
    case chartLine = "fa-chart-line fa-solid"
    case chartPie = "fa-chart-pie fa-solid"
    case check = "fa-check fa-solid"
    case checkCircle = "fa-check-circle fa-solid"
    case checkSquare = "fa-check-square fa-solid"
    case chevronCircleDown = "fa-chevron-circle-down fa-solid"
    case chevronCircleLeft = "fa-chevron-circle-left fa-solid"
    case chevronCircleRight = "fa-chevron-circle-right fa-solid"
    case chevronCircleUp = "fa-chevron-circle-up fa-solid"
    case chevronDown = "fa-chevron-down fa-solid"
    case chevronLeft = "fa-chevron-left fa-solid"
    case chevronRight = "fa-chevron-right fa-solid"
    case chevronUp = "fa-chevron-up fa-solid"
    case circle = "fa-circle fa-solid"
    case clipboard = "fa-clipboard fa-solid"
    case clipboardCheck = "fa-clipboard-check fa-solid"
    case clipboardList = "fa-clipboard-list fa-solid"
    case clock = "fa-clock fa-solid"
    case clone = "fa-clone fa-solid"
    case cloud = "fa-cloud fa-solid"
    case code = "fa-code fa-solid"
    case cog = "fa-cog fa-solid"
    case cogs = "fa-cogs fa-solid"
    case columns = "fa-columns fa-solid"
    case comment = "fa-comment fa-solid"
    case commentAlt = "fa-comment-alt fa-solid"
    case commentDots = "fa-comment-dots fa-solid"
    case comments = "fa-comments fa-solid"
    case compass = "fa-compass fa-solid"
    case copy = "fa-copy fa-solid"
    case creditCard = "fa-credit-card fa-solid"
    case crop = "fa-crop fa-solid"
    case cube = "fa-cube fa-solid"
    case database = "fa-database fa-solid"
    case desktop = "fa-desktop fa-solid"
    case dotCircle = "fa-dot-circle fa-solid"
    case download = "fa-download fa-solid"
    case edit = "fa-edit fa-solid"
    case ellipsisH = "fa-ellipsis-h fa-solid"
    case ellipsisV = "fa-ellipsis-v fa-solid"
    case envelope = "fa-envelope fa-solid"
    case envelopeOpen = "fa-envelope-open fa-solid"
    case exclamation = "fa-exclamation fa-solid"
    case exclamationCircle = "fa-exclamation-circle fa-solid"
    case exclamationTriangle = "fa-exclamation-triangle fa-solid"
    case expand = "fa-expand fa-solid"
    case expandArrowsAlt = "fa-expand-arrows-alt fa-solid"
    case externalLinkAlt = "fa-external-link-alt fa-solid"
    case eye = "fa-eye fa-solid"
    case eyeSlash = "fa-eye-slash fa-solid"
    case file = "fa-file fa-solid"
    case fileAlt = "fa-file-alt fa-solid"
    case fileArchive = "fa-file-archive fa-solid"
    case fileAudio = "fa-file-audio fa-solid"
    case fileCode = "fa-file-code fa-solid"
    case fileExcel = "fa-file-excel fa-solid"
    case fileImage = "fa-file-image fa-solid"
    case filePdf = "fa-file-pdf fa-solid"
    case filePowerpoint = "fa-file-powerpoint fa-solid"
    case fileVideo = "fa-file-video fa-solid"
    case fileWord = "fa-file-word fa-solid"
    case film = "fa-film fa-solid"
    case filter = "fa-filter fa-solid"
    case flag = "fa-flag fa-solid"
    case folder = "fa-folder fa-solid"
    case folderOpen = "fa-folder-open fa-solid"
    case font = "fa-font fa-solid"
    case forward = "fa-forward fa-solid"
    case frown = "fa-frown fa-solid"
    case gamepad = "fa-gamepad fa-solid"
    case gavel = "fa-gavel fa-solid"
    case gift = "fa-gift fa-solid"
    case globe = "fa-globe fa-solid"
    case graduationCap = "fa-graduation-cap fa-solid"
    case hashtag = "fa-hashtag fa-solid"
    case heart = "fa-heart fa-solid"
    case history = "fa-history fa-solid"
    case home = "fa-home fa-solid"
    case hospital = "fa-hospital fa-solid"
    case hourglass = "fa-hourglass fa-solid"
    case iCursor = "fa-i-cursor fa-solid"
    case image = "fa-image fa-solid"
    case inbox = "fa-inbox fa-solid"
    case info = "fa-info fa-solid"
    case infoCircle = "fa-info-circle fa-solid"
    case key = "fa-key fa-solid"
    case keyboard = "fa-keyboard fa-solid"
    case language = "fa-language fa-solid"
    case laptop = "fa-laptop fa-solid"
    case leaf = "fa-leaf fa-solid"
    case lemon = "fa-lemon fa-solid"
    case lifeRing = "fa-life-ring fa-solid"
    case lightbulb = "fa-lightbulb fa-solid"
    case link = "fa-link fa-solid"
    case list = "fa-list fa-solid"
    case listAlt = "fa-list-alt fa-solid"
    case locationArrow = "fa-location-arrow fa-solid"
    case lock = "fa-lock fa-solid"
    case lockOpen = "fa-lock-open fa-solid"
    case magic = "fa-magic fa-solid"
    case magnet = "fa-magnet fa-solid"
    case map = "fa-map fa-solid"
    case mapMarker = "fa-map-marker fa-solid"
    case mapMarkerAlt = "fa-map-marker-alt fa-solid"
    case mapPin = "fa-map-pin fa-solid"
    case mapSigns = "fa-map-signs fa-solid"
    case medkit = "fa-medkit fa-solid"
    case meh = "fa-meh fa-solid"
    case microchip = "fa-microchip fa-solid"
    case microphone = "fa-microphone fa-solid"
    case microphoneSlash = "fa-microphone-slash fa-solid"
    case minus = "fa-minus fa-solid"
    case minusCircle = "fa-minus-circle fa-solid"
    case minusSquare = "fa-minus-square fa-solid"
    case mobile = "fa-mobile fa-solid"
    case moneyBill = "fa-money-bill fa-solid"
    case moon = "fa-moon fa-solid"
    case mousePointer = "fa-mouse-pointer fa-solid"
    case music = "fa-music fa-solid"
    case newspaper = "fa-newspaper fa-solid"
    case objectGroup = "fa-object-group fa-solid"
    case objectUngroup = "fa-object-ungroup fa-solid"
    case paperPlane = "fa-paper-plane fa-solid"
    case paperclip = "fa-paperclip fa-solid"
    case paste = "fa-paste fa-solid"
    case pause = "fa-pause fa-solid"
    case pauseCircle = "fa-pause-circle fa-solid"
    case pen = "fa-pen fa-solid"
    case penAlt = "fa-pen-alt fa-solid"
    case penSquare = "fa-pen-square fa-solid"
    case pencilAlt = "fa-pencil-alt fa-solid"
    case percent = "fa-percent fa-solid"
    case phone = "fa-phone fa-solid"
    case phoneSlash = "fa-phone-slash fa-solid"
    case phoneSquare = "fa-phone-square fa-solid"
    case photoVideo = "fa-photo-video fa-solid"
    case pieChart = "fa-pie-chart fa-solid"
    case plane = "fa-plane fa-solid"
    case play = "fa-play fa-solid"
    case playCircle = "fa-play-circle fa-solid"
    case plug = "fa-plug fa-solid"
    case plus = "fa-plus fa-solid"
    case plusCircle = "fa-plus-circle fa-solid"
    case plusSquare = "fa-plus-square fa-solid"
    case print = "fa-print fa-solid"
    case puzzlePiece = "fa-puzzle-piece fa-solid"
    case qrcode = "fa-qrcode fa-solid"
    case question = "fa-question fa-solid"
    case questionCircle = "fa-question-circle fa-solid"
    case quoteLeft = "fa-quote-left fa-solid"
    case quoteRight = "fa-quote-right fa-solid"
    case random = "fa-random fa-solid"
    case receipt = "fa-receipt fa-solid"
    case redo = "fa-redo fa-solid"
    case redoAlt = "fa-redo-alt fa-solid"
    case reply = "fa-reply fa-solid"
    case replyAll = "fa-reply-all fa-solid"
    case rss = "fa-rss fa-solid"
    case rssSquare = "fa-rss-square fa-solid"
    case save = "fa-save fa-solid"
    case search = "fa-search fa-solid"
    case searchMinus = "fa-search-minus fa-solid"
    case searchPlus = "fa-search-plus fa-solid"
    case share = "fa-share fa-solid"
    case shareAlt = "fa-share-alt fa-solid"
    case shareAltSquare = "fa-share-alt-square fa-solid"
    case shareSquare = "fa-share-square fa-solid"
    case shieldAlt = "fa-shield-alt fa-solid"
    case shoppingCart = "fa-shopping-cart fa-solid"
    case signInAlt = "fa-sign-in-alt fa-solid"
    case signOutAlt = "fa-sign-out-alt fa-solid"
    case signal = "fa-signal fa-solid"
    case sitemap = "fa-sitemap fa-solid"
    case slidersH = "fa-sliders-h fa-solid"
    case smile = "fa-smile fa-solid"
    case sort = "fa-sort fa-solid"
    case sortAlphaDown = "fa-sort-alpha-down fa-solid"
    case sortAlphaUp = "fa-sort-alpha-up fa-solid"
    case sortAmountDown = "fa-sort-amount-down fa-solid"
    case sortAmountUp = "fa-sort-amount-up fa-solid"
    case sortDown = "fa-sort-down fa-solid"
    case sortNumericDown = "fa-sort-numeric-down fa-solid"
    case sortNumericUp = "fa-sort-numeric-up fa-solid"
    case sortUp = "fa-sort-up fa-solid"
    case spaceShuttle = "fa-space-shuttle fa-solid"
    case spinner = "fa-spinner fa-solid"
    case square = "fa-square fa-solid"
    case star = "fa-star fa-solid"
    case starHalf = "fa-star-half fa-solid"
    case stickyNote = "fa-sticky-note fa-solid"
    case stop = "fa-stop fa-solid"
    case stopCircle = "fa-stop-circle fa-solid"
    case stopwatch = "fa-stopwatch fa-solid"
    case streetView = "fa-street-view fa-solid"
    case strikethrough = "fa-strikethrough fa-solid"
    case `subscript` = "fa-subscript fa-solid"
    case suitcase = "fa-suitcase fa-solid"
    case sun = "fa-sun fa-solid"
    case superscript = "fa-superscript fa-solid"
    case sync = "fa-sync fa-solid"
    case syncAlt = "fa-sync-alt fa-solid"
    case table = "fa-table fa-solid"
    case tablet = "fa-tablet fa-solid"
    case tachometerAlt = "fa-tachometer-alt fa-solid"
    case tag = "fa-tag fa-solid"
    case tags = "fa-tags fa-solid"
    case tasks = "fa-tasks fa-solid"
    case taxi = "fa-taxi fa-solid"
    case terminal = "fa-terminal fa-solid"
    case textHeight = "fa-text-height fa-solid"
    case textWidth = "fa-text-width fa-solid"
    case th = "fa-th fa-solid"
    case thLarge = "fa-th-large fa-solid"
    case thList = "fa-th-list fa-solid"
    case thumbsDown = "fa-thumbs-down fa-solid"
    case thumbsUp = "fa-thumbs-up fa-solid"
    case thumbtack = "fa-thumbtack fa-solid"
    case ticketAlt = "fa-ticket-alt fa-solid"
    case times = "fa-times fa-solid"
    case timesCircle = "fa-times-circle fa-solid"
    case tint = "fa-tint fa-solid"
    case toggleOff = "fa-toggle-off fa-solid"
    case toggleOn = "fa-toggle-on fa-solid"
    case toolbox = "fa-toolbox fa-solid"
    case trademark = "fa-trademark fa-solid"
    case trash = "fa-trash fa-solid"
    case trashAlt = "fa-trash-alt fa-solid"
    case tree = "fa-tree fa-solid"
    case trophy = "fa-trophy fa-solid"
    case truck = "fa-truck fa-solid"
    case tv = "fa-tv fa-solid"
    case umbrella = "fa-umbrella fa-solid"
    case undo = "fa-undo fa-solid"
    case undoAlt = "fa-undo-alt fa-solid"
    case university = "fa-university fa-solid"
    case unlock = "fa-unlock fa-solid"
    case unlockAlt = "fa-unlock-alt fa-solid"
    case upload = "fa-upload fa-solid"
    case user = "fa-user fa-solid"
    case userAlt = "fa-user-alt fa-solid"
    case userCircle = "fa-user-circle fa-solid"
    case userPlus = "fa-user-plus fa-solid"
    case userTimes = "fa-user-times fa-solid"
    case users = "fa-users fa-solid"
    case video = "fa-video fa-solid"
    case videoSlash = "fa-video-slash fa-solid"
    case volumeDown = "fa-volume-down fa-solid"
    case volumeMute = "fa-volume-mute fa-solid"
    case volumeOff = "fa-volume-off fa-solid"
    case volumeUp = "fa-volume-up fa-solid"
    case wifi = "fa-wifi fa-solid"
    case wrench = "fa-wrench fa-solid"
    case flask = "fa-flask fa-solid"
    case rocket = "fa-rocket fa-solid"
    case headset = "fa-headset fa-solid"
    case handshake = "fa-handshake fa-solid"
    case handshakeAlt = "fa-handshake-alt fa-solid"
}
