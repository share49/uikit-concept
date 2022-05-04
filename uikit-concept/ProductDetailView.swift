//
//  ProductDetailView.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/3/22.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State var product: Product
    
    var body: some View {
        VStack {
            HStack {
                Text("Transactions for \(product.sku)")
                Spacer()
                Text("Total amount: €")
            }.padding()
            
            List {
                ForEach(product.transactions) { transaction in
                    Text("\(transaction.amount) \(transaction.currency.lowercased())")
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transactions = [Transaction(sku: "123", amount: "12.95", currency: "EUR")]
        let product = Product(sku: "123", transactions: transactions)
        
        Group {
            ProductDetailView(product: product)
                .previewDevice("iPhone 13 max")
            
            ProductDetailView(product: product)
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13 mini")
        }
    }
}
