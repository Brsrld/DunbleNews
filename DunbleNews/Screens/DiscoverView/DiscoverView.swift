//
//  DiscoverView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject private var viewModel: DiscoverViewModel
    
    init(service: NewsServiceable) {
        self._viewModel = ObservedObject(wrappedValue: DiscoverViewModel(service: service))
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
        NavigationLink(destination: SelectedDiscoverView(category: viewModel.defaultCategory,
                                                         service: viewModel.service)) {
            CategoriesCell(image: viewModel.defaultCategory.imageName,
                           title: viewModel.defaultCategory.title)
            .frame(height: geo.size.height / 4)
            .padding(.horizontal, 12)
        }
    }
    
    @ViewBuilder
    private func categories(geo: GeometryProxy) -> some View {
        StaggeredGrid(list: viewModel.allCategories,
                      columns: 2,
                      showsIndicator:false,
                      spacing: 12) { category in
            NavigationLink(destination: SelectedDiscoverView(category: category,
                                                             service: viewModel.service)) {
                CategoriesCell(image: category.imageName, title: category.title)
                    .frame(height: geo.size.height / 5)
                    .padding(.horizontal, 12)
            }
        }
                      .padding(.bottom, 2)
    }
    
    private func columnGrid() -> [GridItem] {
        return   [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(service: NewsService())
    }
}
