//
//  PantryItemCard.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import SwiftUI

struct PantryItemCard: View {
    var name = "Default"
    var amount = 0
    var daysTillExpiry = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 47.0)
                .frame(width: .infinity)
            .foregroundColor(.clear)
            .background(Color(red: 0.92, green: 0.92, blue: 0.92))
            .cornerRadius(9)
            
            HStack {
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 30)
                        .background(Color(red: 0.84, green: 0.84, blue: 0.84))
                        .cornerRadius(9)
                    Text("\(amount)")
                }
                
                Text(name)
                    .padding(.leading, 8.0)
                Spacer()
            }
            .padding([.leading, .trailing], 10)
            //.padding(.trailing, 23)
        
        }

       
    }
}

struct PantryItemCard_Previews: PreviewProvider {
    static var previews: some View {
        PantryItemCard()
    }
}
