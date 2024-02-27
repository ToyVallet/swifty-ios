import Foundation
import SwiftUI

extension Font {
    
    public static var headline1: Font {
        return Font.custom("NotoSansKR-Bold", size: 27)
    }
    
    public static var body1: Font {
        return Font.custom("NotoSansKR-Regular", size: 17)
    }
    public static var headline2: Font {
        return Font.custom("NotoSansKR-Bold", size: 22)
    }
    public static var body2: Font {
        return Font.custom("NotoSansKR-Medium", size: 15)
    }
    public static var body3: Font {
        return Font.custom("NotoSansKR-Regular", size: 20)
    }
    
    
    public static var number1: Font {
        return Font.custom("NotoSansKR-Medium", size: 23)
    }
    public static var numericKeypad: Font {
        return Font.custom("NotoSansKR-SemiBold", size: 36)
    }
    public static var number2: Font {
        return Font.custom("NotoSansKR-Bold", size: 36)
    }
    
    
    public static var tabbar: Font {
        return Font.custom("NotoSansKR-Medium", size: 12)
    }
    
    
    
    
    
    
    
    
    /// Create a font with the headline text style.
    public static var head_line: Font {
        return Font.custom("NotoSansKR-Regular", size: 18)
    }
    
    /// Create a font with the subheadline text style.
    public static var sub_head_line: Font {
        return Font.custom("NotoSansKR-Regular", size: 14)
    }
    
    /// Create a font with the body text style.
    public static var body: Font {
        return Font.custom("NotoSansKR-Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    /// Create a font with the callout text style.
    public static var callout: Font {
        return Font.custom("NotoSansKR-Bold", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    /// Create a font with the footnote text style.
    public static var foot_note: Font {
        return Font.custom("NotoSansKR-Regular", size: 14)
    }
    
    /// Create a font with the caption text style.
    public static var context: Font {
        return Font.custom("NotoSansKR-Bold", size: 14)
    }
    
    
    public static var textfield_leading: Font {
        return Font.custom("NotoSansKR-Bold", size: 18)
    }
    
    public static var podium_id: Font {
        return Font.custom("NotoSansKR-Regular", size: 16)
    }
    public static var podium_level: Font {
        return Font.custom("NotoSansKR-Regular", size: 15)
    }
    public static var podium_footer: Font {
        return Font.custom("NotoSansKR-Regular", size: 14)
    }
    
    
    
    public static var player_tier_pill: Font {
        return Font.custom("NotoSansKR-Bold", size: 10)
    }
    public static var player_id: Font {
        return Font.custom("NotoSansKR-Bold", size: 16)
    }
    public static var player_id_info: Font {
        return Font.custom("NotoSansKR-Bold", size: 16)
    }
    public static var player_vid_info: Font {
        return Font.custom("NotoSansKR-Regular", size: 16)
    }
    public static var player_vid_description: Font {
        return Font.custom("NotoSansKR-Regular", size: 13)
    }
    
    
    public static var login_button: Font {
        return Font.custom("NotoSansKR-Bold", size: 14)
    }
    public static var login_textfield: Font {
        return Font.custom("NotoSansKR-Bold", size: 13)
    }
    
    public static var tabbar_item: Font {
        return Font.custom("NotoSansKR-Light", size: 10)
    }
    
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "NotoSansKR-Bold"
        switch weight {
        case .bold: font = "NotoSansKR-Bold"
        case .heavy: font = "NotoSansKR-ExtraBold"
        case .light: font = "NotoSansKR-Light"
        case .medium: font = "NotoSansKR-Regular"
        case .semibold: font = "NotoSansKR-SemiBold"
        case .thin: font = "NotoSansKR-Light"
        case .ultraLight: font = "NotoSansKR-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
