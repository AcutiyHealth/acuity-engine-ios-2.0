//
//  UIFont+Extensions.swift
//  learnIt
//
//  Created by Ratnesh's Macbook Air on 04/02/20.
//  Copyright © 2020 TechGadol. All rights reserved.
//

import UIKit

/*
 Family: SFProDisplay Rounded Font names: [
 "SFProDisplayRounded-BoldItalic",
 "SFProDisplayRounded-MediumItalic",
 "SFProDisplayRounded-BookItalic",
 "SFProDisplayRounded-Book",
 "SFProDisplayRounded-Light",
 "SFProDisplayRounded-LightItalic",
 "SFProDisplayRounded-Bold",
 "SFProDisplayRounded-Medium"]
 */

extension UIFont {
    enum SFProDisplayWeight: String {
        case boldItalic = "SFProDisplay-BoldItalic"
        case heavyItalic = "SFProDisplay-HeavyItalic"
        case lightItalic = "SFProDisplay-LightItalic"
        case mediumItalic = "SFProDisplay-MediumItalic"
        case thinItalic = "SFProDisplay-ThinItalic"
        case regular = "SFProDisplay-Regular"
        case semiBold = "SFProDisplay-Semibold"
        case bold = "SFProDisplay-Bold"
        case medium = "SFProDisplay-Medium"
        case italic = "BrushScriptMT-Italic"
    }
    
    static func SFProDisplay(ofSize size: CGFloat = UIFont.labelFontSize, weight: SFProDisplayWeight) -> UIFont {
        guard let customFont = UIFont(name: weight.rawValue, size: size) else {
            fatalError("""
                Failed to load the "\(weight.rawValue)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
        //return UIFontMetrics.default.scaledFont(for: customFont)
    }
}


extension UIFont {
    static func SFProDisplayBold(of size: CGFloat = 20) -> UIFont {
        return UIFont.SFProDisplay(ofSize: size, weight: .bold)
    }
    
    static func SFProDisplaySemiBold(of size: CGFloat = 14) -> UIFont {
        return UIFont.SFProDisplay(ofSize: size, weight: .semiBold)
    }
    static func SFProDisplayMedium(of size: CGFloat = 14) -> UIFont {
        return UIFont.SFProDisplay(ofSize: size, weight: .medium)
    }
    static func SFProDisplayBoldItalic(of size: CGFloat = 14) -> UIFont {
        return UIFont.SFProDisplay(ofSize: size, weight: .italic)
    }
    static func SFProDisplayRegular(of size: CGFloat = 14) -> UIFont {
        return UIFont.SFProDisplay(ofSize: size, weight: .regular)
    }
    static func PoppinsDisplayRegular(of size: CGFloat = 14) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.SFProDisplay(ofSize: size, weight: .semiBold)
    }
    static func PoppinsDisplayBold(of size: CGFloat = 14) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.SFProDisplay(ofSize: size, weight: .semiBold)
    }
}
