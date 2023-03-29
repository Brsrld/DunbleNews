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
    let alingment: TextAlignment
    
    init(textColor: Color = Color.black,
         textFont:Font,
         alingment:TextAlignment) {
        self.textColor = textColor
        self.textFont = textFont
        self.alingment = alingment
    }
    
    func body(content: Content) -> some View{
        content
            .font(textFont)
            .foregroundColor(textColor)
            .multilineTextAlignment(alingment)
            .fixedSize(horizontal: false, vertical: true)
    }
}
