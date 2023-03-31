//
//  DiscoverView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject var viewModel: DiscoveryViewModel
    
    init() {
        self._viewModel = ObservedObject(wrappedValue: DiscoveryViewModel())
    }
    
    var body: some View {
        baseView()
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .ready:
            GeometryReader { geo in
                VStack(spacing: 12) {
                    defaulCategory(geo: geo)
                    categories(geo: geo)
                }
                .showTabBar()
            }
        }
    }
    
    @ViewBuilder
    private func defaulCategory(geo: GeometryProxy) -> some View {
        NavigationLink(destination: SelectedDiscoverView(category: viewModel.defaultCategory.title.lowercased())) {
            CategoriesCell(image: viewModel.defaultCategory.imageName,
                           title: viewModel.defaultCategory.title)
            .frame(height: geo.size.height / 4)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func categories(geo: GeometryProxy) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columnGrid(), spacing: 12) {
                ForEach(NewsCategories.allCases) { category in
                    if category != viewModel.defaultCategory {
                        NavigationLink(destination: SelectedDiscoverView(category: category.title.lowercased())) {
                            CategoriesCell(image: category.imageName, title: category.title)
                               .frame(height: geo.size.height / 4)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func columnGrid() -> [GridItem] {
        return   [
            GridItem(.flexible(minimum: 10, maximum: 200)),
            GridItem(.flexible(minimum: 10, maximum: 200))
        ]
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
