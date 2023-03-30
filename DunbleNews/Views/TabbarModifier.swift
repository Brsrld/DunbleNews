//
//  TabbarModifier.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 30.03.2023.
//

import Foundation
import UIKit
import SwiftUI

struct HideTabbar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.hiddenTabBar()
        }
    }
}

struct ShowTabBar: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.showTabBar()
        }
    }
}

struct Tool {
    static func findTabbar() -> UITabBar?
    {
        let allSubviews = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews()
        var tba:UITabBar? = nil
        allSubviews?.forEach({ v in
            if let tabBar = v as? UITabBar {
                tba = tabBar
            }
        })
        return tba
    }
    
    static func showTabBar() {
        if let tabBar = findTabbar(){
            tabBar.isHidden = false
        }
    }

    static func hiddenTabBar() {
        if let view = findTabbar()  {
            view.isHidden = true
        }
    }
}
