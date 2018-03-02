//
//  CustomizeItemViewController.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/1/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import UIKit

class CustomizeItemViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = VariantsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupTableView()
        fetchData()
        reloadViews()
    }
    
    private func fetchData() {
        viewModel.reloadData { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func reloadViews() {
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([section], with: .fade)
            self?.tableView.endUpdates()
        }
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 96
        tableView.separatorStyle = .none
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.register(VariationCell.nib,
                           forCellReuseIdentifier: VariationCell.identifier)
        tableView.register(CustomizeItemCell.nib,
                           forHeaderFooterViewReuseIdentifier: CustomizeItemCell.identifier)
    }

    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CustomizeItemViewController: VariantsViewModelDelegate {
    func incompatibleCombinationSelected() {
        let okAction = UIAlertAction(title: "Okay",
                                     style: .default,
                                     handler: nil)
        let alertController = UIAlertController(title: "Sorry!", message: "This combination is not allowed!", preferredStyle: .alert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
