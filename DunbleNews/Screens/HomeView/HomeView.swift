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
            news()
                .showTabBar()
        case .loading:
            ProgressView("Loading")
        case .error(error: let error):
            ProgressView("Loading")
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
    
    @ViewBuilder
    private func news() -> some View {
        StaggeredGrid(list: viewModel.allNews,
                      columns: 2,
                      showsIndicator: false,
                      spacing: 12) { news in
            NavigationLink {
                WebView(url: news.url ?? "", showLoading: $viewModel.isloading)
                    .overlay(viewModel.isloading ? ProgressView("Loading").toAnyView() : EmptyView().toAnyView())
                    .navigationTitle(news.source?.name ?? "")
                    .hideTabbar()
                    .ignoresSafeArea()
                
            } label: {
                NewsCell(item: NewsCellItem(imageUrl: news.urlToImage ?? "",
                                            owner: news.source?.name ?? "",
                                            title: news.title ?? "",
                                            date: "1 hour"))
            }
            .onAppear {
                viewModel.loadMoreContent(item: news)
            }
        }
    }
    
    private func columnGrid() -> [GridItem] {
        return   [
            GridItem(.flexible(minimum: 0), spacing: 0),
            GridItem(.flexible(minimum: 0), spacing: 0),
        ]
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
