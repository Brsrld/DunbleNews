//
//  SelectedDiscoverView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import SwiftUI

struct SelectedDiscoverView: View {
    @StateObject private var viewModel: SelectedDiscoverViewModel
    
    var body: some View {
        baseView()
            .navigationTitle(viewModel.category.capitalized)
    }
    
    init(category: String) {
        self._viewModel = StateObject(wrappedValue: SelectedDiscoverViewModel(category: category))
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .finished:
            NewsListView(news: viewModel.news,
                         isloading: $viewModel.isloading)
            .hideTabbar()
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

struct SelectedDiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedDiscoverView(category: "technology")
    }
}
