//
//  NewsCell.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import SwiftUI

struct NewsCell: View {
    
    let item: NewsCellItem
    
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
                        .modifier(AppViewBuilder(textColor: .black,
                                                 textFont: .title3,
                                                 alingment: .leading))
                        .padding(.horizontal)
                    
                    label(text: item.date)
                        .padding(.bottom)
                    
                }
                Spacer()
            }
        }
        .background(Color(red: 211, green: 211, blue: 211))
        .cornerRadius(8)
        .padding(.horizontal)
        .shadow(radius: 2)
        
    }
    
    @ViewBuilder
    private func label(text: String) -> some View {
        HStack {
            Text(text)
                .modifier(AppViewBuilder(textColor: .gray,
                                         textFont: .footnote,
                                         alingment: .leading))
            Spacer()
        }
        .padding(.leading)
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        let url = URL(string: item.imageUrl)
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image("fail")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        let item = NewsCellItem(imageUrl: "https://www.reuters.com/resizer/-9uubUtwVpA0QW9zWGHoxPLwhBk=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PW5QFB7KPVL4HLO3EMDE3LUJFM.jpg",
                                owner: "Reuters",
                                title: "French government rejects union demand to rethink pension bill - Reuters",
                                date: "2023-03-28T12:20:00Z")
        NewsCell(item: item)
            .previewLayout(.sizeThatFits)
            //.frame(width: UIScreen.screenWidth / 2.1)
    }
}
