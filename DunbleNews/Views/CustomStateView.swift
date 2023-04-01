//
//  CustomStateView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import SwiftUI

struct CustomStateView: View {
    let image: String
    let description: String
    let tintColor: Color?
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 64, height: 64)
                .tint(tintColor)
            Text(description)
                .modifier(AppViewBuilder(textColor: Color.textColor,
                                         textFont: .title3,
                                         alingment: .center))
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStateView(image: "exclamationmark.transmission",
                        description: "There is no news !",
                        tintColor: .red)
    }
}
