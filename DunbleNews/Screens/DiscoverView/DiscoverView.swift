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
        GeometryReader { geo in
            VStack(spacing: 12) {
                CategoriesCell(image: NewsCategories.general.imageName,
                               title: NewsCategories.general.title)
                    .frame(height: geo.size.height / 4)
                    .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columnGrid(), spacing: 12) {
                        ForEach(NewsCategories.allCases) { category in
                            CategoriesCell(image: category.imageName, title: category.title)
                                .frame(height: geo.size.height / 4)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
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
        DiscoverView()
    }
}
