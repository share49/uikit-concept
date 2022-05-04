//
//  ProductDetailView.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/3/22.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State var viewModel: ProductViewModel
    
    var body: some View {
        VStack {
            VStack() {
                Text(viewModel.title)
                    .font(.title)
                Text(viewModel.formattedTotalAmount)
            }.padding(.top)
            
            List {
                ForEach(viewModel.product.transactions) { transaction in
                    Text(transaction.description)
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transactions = [Transaction(sku: "123", amount: "12.95", currency: "EUR")]
        let product = Product(sku: "123", transactions: transactions)
        let viewModel = ProductViewModel(with: product, conversionRates: [])
        
        Group {
            ProductDetailView(viewModel: viewModel)
                .previewDevice("iPhone 13 max")
            
            ProductDetailView(viewModel: viewModel)
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13 mini")
        }
    }
}
