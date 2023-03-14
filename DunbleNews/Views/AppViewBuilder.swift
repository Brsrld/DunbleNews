//
//  AppViewBuilder.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct AppViewBuilder: ViewModifier {

    let textColor: Color
    let textFont: Font
    let lineLimit: Int
    let alingment: TextAlignment
    
    init(textColor: Color = Color.black,
         textFont:Font,
         linelimit:Int = 1,
         alingment:TextAlignment) {
        self.textColor = textColor
        self.textFont = textFont
        self.lineLimit = linelimit
        self.alingment = alingment
    }
    
    func body(content: Content) -> some View{
        content
            .font(textFont)
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
            .multilineTextAlignment(alingment)
    }
}
