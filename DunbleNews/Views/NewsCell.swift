//
//  NewsCell.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import SwiftUI

struct NewsCell: View {
    
    let item: NewsCellItem
    @State var isEmpty = false
    
    init(item: NewsCellItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 12) {
            movieImage()
            
            HStack {
                VStack(spacing: 12) {
                    label(text: item.owner)
                    
                    Text(item.title)
                        .modifier(AppViewBuilder(textColor: Color.textColor,
                                                 textFont: .subheadline,
                                                 alingment: .leading))
                        .padding(.horizontal)
                    
                    label(text: item.date)
                        .padding(.bottom)
                }
                Spacer()
            }
        }
        .background(Color.cellColor)
        .cornerRadius(8)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
    
    @ViewBuilder
    private func label(text: String) -> some View {
        HStack {
            Text(text)
                .modifier(AppViewBuilder(textColor: .gray,
                                         textFont: .footnote,
                                         alingment: .leading))
                .lineLimit(1)
            Spacer()
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        if let url = URL(string: item.imageUrl) {
            VStack {
                CacheAsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                       EmptyView()
                            .task {
                                isEmpty.toggle()
                            }
                    @unknown default:
                        fatalError()
                    }
                }
            }
            .frame(height: isEmpty ? 0 : 100)
        }
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        let item = NewsCellItem(imageUrl: "",
                                owner: "Reuters",
                                title: "French government rejects union demand to rethink pension bill - Reuters",
                                date: "2023-03-28T12:20:00Z".calculateTime())
        NewsCell(item: item)
            .previewLayout(.sizeThatFits)
    }
}
