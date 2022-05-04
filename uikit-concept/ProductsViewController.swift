//
//  ProductsViewController.swift
//  uikit-concept
//
//  Created by Roger Pintó Diaz on 5/2/22.
//

import UIKit
import Combine
import SwiftUI

final class ProductsViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var viewModel: ProductsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init(with viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setupTableView()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            await viewModel.loadProducts()
        }
    }
    
    // MARK: - Combine bindings
    
    func setupBindings() {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.tableView.reloadData() }
            .store(in: &subscriptions)
    }
    
    // MARK: - UIView methods
    
    private func setTitle() {
        title = k.VCTitles.products
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: k.Cells.transactionCell)
    }

    private func showProductDetailView(for product: Product) {
        let productDetailView = ProductDetailView(product: product)
        let hostingController = UIHostingController(rootView: productDetailView)
        present(hostingController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: k.Cells.transactionCell, for: indexPath)
        cell.textLabel?.text = viewModel.products[indexPath.row].sku
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showProductDetailView(for: viewModel.products[indexPath.row])
    }
}
