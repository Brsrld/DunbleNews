//
//  TabbarView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct TabbarView: View {
    @State var menuItemType: MenuItemType = .discover
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Colors.tabbarTextColor ?? .red]
        navBarAppearance.titleTextAttributes = [.foregroundColor:  Colors.tabbarTextColor ?? .red]
    }
    
    var body: some View {
        TabView(selection: $menuItemType) {
            TabItemView(MenuItemType.home) {
                HomeView()
            }
            TabItemView(MenuItemType.discover) {
                DiscoverView()
            }
            TabItemView(MenuItemType.search) {
                SearchView()
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
