//
//  SuggestedRecipeCard.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import SwiftUI

struct SuggestedRecipeCard: View {
    var name = "Default"
    var servings = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 47.0)
                .frame(width: .infinity)
                .background(Color(red: 0.84, green: 0.84, blue: 0.84))
                .cornerRadius(9)
            
            HStack {
                Text(name)
                Spacer()
                Text("\(servings) servings")
            }
            .padding([.leading, .trailing], 15)
            //.padding(28.0)
        }
        //.border(.green)
    }
}

struct SuggestedRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedRecipeCard()
    }
}
