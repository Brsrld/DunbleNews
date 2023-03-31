//
//  HomeView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    var body: some View {
        baseView()
    }
    
    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewModel())
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
           ErrorView()
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error Message"),
                          message: Text(error),
                          dismissButton: Alert.Button.default(
                            Text("Ok"), action: {
                                viewModel.changeStateToReady()
                            }
                          ))
                }
        case .ready:
            ProgressView()
                .onAppear {
                    viewModel.serviceInitialize()
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
