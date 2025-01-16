//
//  HomeView.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, Amrita")
                .font(.largeTitle)
                .fontWeight(.bold)
            Button {
                // add stuff
            } label: {
                Text("Pantry")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
                    .padding(.top, 4)
            }
            .padding(.top, 2.0)
                
            ForEach(1..<4) { i in
                PantryItemCard(name: "Hi \(i)", amount: 0, daysTillExpiry: 5)
            }
            Button {
                // add stuff
            } label: {
                Text("Suggested Recipes")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
                    .padding(.top, 4)
            }
            .padding([.top, .bottom], 10.0)
            ForEach(1..<4) { i in
                SuggestedRecipeCard(name: "Hi \(i)")
            }
                
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.leading, .trailing], 15)
        .padding(.top, 20)    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
