//
//  HomeView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    var body: some View {
        baseView()
    }
    
    init(service: NewsServiceable) {
        self._viewModel = ObservedObject(wrappedValue: HomeViewModel(service: service))
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .finished:
            NewsListView(news: viewModel.allNews,
                         isloading: $viewModel.isloading)
                .showTabBar()
        case .loading:
            ProgressView("Loading")
        case .error(error: let error):
            CustomStateView(image: "exclamationmark.transmission",
                            description: "Something get wrong !",
                            tintColor: .red)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error Message"),
                          message: Text(error),
                          dismissButton: Alert.Button.default(
                            Text("Ok"), action: {
                                viewModel.changeStateToEmpty()
                            }
                          ))
                }
        case .ready:
            ProgressView()
                .onAppear {
                    viewModel.serviceInitialize()
                }
        case .empty:
            CustomStateView(image: "newspaper",
                            description: "There is no data :(",
                            tintColor: .indigo)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(service: NewsService())
    }
}
