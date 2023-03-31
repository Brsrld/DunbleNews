//
//  CategoriesCell.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import SwiftUI

struct CategoriesCell: View {
    
    let image: String
    let title: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
            VStack {
                Spacer()
                HStack {
                    Text(title)
                        .modifier(AppViewBuilder(textColor: .white,
                                                 textFont: .subheadline,
                                                 alingment: .leading))
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.bottom, 8)
            }
        }
        .cornerRadius(8)
        .shadow(radius: 8)
    }
}

struct CategoriesCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesCell(image: "tec", title: "Technology")
            .previewLayout(.sizeThatFits)
    }
}
