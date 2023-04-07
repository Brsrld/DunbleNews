//
//  SearchView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(service: NewsServiceable) {
        self._viewModel = ObservedObject(wrappedValue: SearchViewModel(service: service))
    }
    
    var body: some View {
        baseView()
            .searchable(text: $viewModel.searchQuery,
                        placement: .toolbar,
                        prompt: "Search news")
            .onSubmit(of: .search) {
                viewModel.checkValidation()
            }
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .ready:
            CustomStateView(image: "magnifyingglass",
                            description: "Search Something",
                            tintColor: .gray)
        case .error(error: let error):
            CustomStateView(image: "exclamationmark.transmission",
                            description: "Something get wrong !",
                            tintColor: .red)
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Error"),
                      message: Text(error),
                      dismissButton: Alert.Button.default(
                        Text("Ok"), action: {
                            viewModel.changeStateToEmpty()
                        }
                      ))
            }
        case .finished:
            NewsListView(news: viewModel.news, isloading: $viewModel.isloading)
                .showTabBar()
        case .loading:
            ProgressView("Loading")
        case .empty:
            CustomStateView(image: "newspaper",
                            description: "There is no data :(",
                            tintColor: .indigo)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(service: NewsService())
    }
}
