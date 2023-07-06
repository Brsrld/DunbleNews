//
//  View+Extensions.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 30.03.2023.
//

import SwiftUI
import UIKit

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    //ele bele
    
    func hideTabbar() -> some View {
        return self.modifier(HideTabbar())
    }
    
    func showTabBar() -> some View {
        return self.modifier(ShowTabBar())
    }
}
