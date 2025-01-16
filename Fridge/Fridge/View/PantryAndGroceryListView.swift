//
//  PantryAndGroceryListView.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import SwiftUI

struct PantryAndGroceryListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, Amrita")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Text("Pantry")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 2.0)
                Button {
                    // add stuff
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.black)
                }
                .padding(.top, 4)

            }
            ForEach(1..<4) { i in
                PantryItemCard(name: "Hi \(i)", amount: 0, daysTillExpiry: 5)
            }
            HStack {
                Text("Suggested Recipes")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 2.0)
                Button {
                    // add stuff
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.black)
                }
                .padding(.top, 4)
            }
            ForEach(1..<4) { i in
                SuggestedRecipeCard(name: "Hi \(i)")
            }
                
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.leading, .trailing], 15)
        .padding(.top, 20)

    }
}

struct PantryAndGroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        PantryAndGroceryListView()
    }
}
