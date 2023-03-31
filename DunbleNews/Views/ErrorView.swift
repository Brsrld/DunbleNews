//
//  ErrorView.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName:"exclamationmark.transmission")
                .resizable()
                .frame(width: 64, height: 64)
            Text("Something Get Wrong !")
                .modifier(AppViewBuilder(textFont: .title3, alingment: .center))
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(8)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
