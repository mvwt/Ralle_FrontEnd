//
//  Purchasing.swift
//  RALLE app
//
//  Created by Michael Thomas on 6/28/25.
//

@MainActor
class StoreViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedProdcutsIDs = set<String>()
    
    func fetchProducts() async {
        do {
            let result = try await Product.products(for: products = result)
        } catch {
            print("Failed to fetch products \(error)")
        }
    }
    
    func purhcase 
}
