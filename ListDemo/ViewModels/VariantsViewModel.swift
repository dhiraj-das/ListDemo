//
//  VariantsViewModel.swift
//  ListDemo
//
//  Created by Dhiraj Das on 3/2/18.
//  Copyright © 2018 Dhiraj Das. All rights reserved.
//

import Foundation
import UIKit

protocol VariantsViewModelItem {
    var groupTitle: String { get }
    var variations: [Variation] { get set }
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
    var groupId: String { get }
}

extension VariantsViewModelItem {
    var isCollapsible: Bool {
        return true
    }
}

protocol VariantsViewModelDelegate: class {
    func incompatibleCombinationSelected()
}

class VariantsViewModel: NSObject {
    
    private let service = VariantService()
    var items = [VariantsViewModelItem]()
    var excludedPairs: [Int: [ExcludedCombination]] = [:]
    weak var delegate: VariantsViewModelDelegate?
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    func reloadData(completion: @escaping ((_ success: Bool) -> Void)) {
        service.fetchData { (variants, error) in
            if let _ = error {
                completion(false)
                return
            }
            guard let _variants = variants else {
                completion(false)
                return
            }
            for variantGroup in _variants.variantGroups {
                self.items.append(variantGroup)
            }
            self.excludedPairs = _variants.excludedPairs
            completion(true)
        }
    }
}

extension VariantsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        guard item.isCollapsible else {
            return item.rowCount
        }
        
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VariationCell.identifier) as? VariationCell else { return UITableViewCell() }
        let item = items[indexPath.section]
        cell.sectionIndex = indexPath.section
        cell.item = item.variations[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension VariantsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomizeItemCell.identifier) as? CustomizeItemCell {
            let item = items[section]
            headerView.item = item
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
}

extension VariantsViewModel: CustomizeItemCellDelegate {
    func toggleSection(header: CustomizeItemCell, section: Int) {
        var item = items[section]
        if item.isCollapsible {
            items[section].isCollapsed = !item.isCollapsed
            header.setCollapsed(collapsed: !item.isCollapsed)
            reloadSections?(section)
        }
    }
}

extension VariantsViewModel: VariationCellDelegate {
    func selected(itemId: String, sectionIndex: Int) {
        var newData = [Variation]()
        for var variation in items[sectionIndex].variations {
            variation.isSelected = variation.id == itemId
            newData.append(variation)
        }
        var tempVariantGroups = items
        tempVariantGroups[sectionIndex].variations = newData
        guard areSelectionsIncompatible(variantGroups: tempVariantGroups) == false else {
            delegate?.incompatibleCombinationSelected()
            return
        }
        
        items[sectionIndex].variations = newData
        reloadSections?(sectionIndex)
    }
    
    private func areSelectionsIncompatible(variantGroups: [VariantsViewModelItem]) -> Bool {
        let selectedPairs = selectedVariationIdPairs(variantGroups: variantGroups)
        for (_, array) in excludedPairs {
            let selectedPairsSet = Set(selectedPairs)
            let excludedPairsSet = Set(array)
            if excludedPairsSet.isSubset(of: selectedPairsSet) {
                return true
            }
        }
        return false
    }
    
    private func selectedVariationIdPairs(variantGroups: [VariantsViewModelItem]) -> [ExcludedCombination] {
        var selectedVariationPairs: [ExcludedCombination] = []
        for variantGroup in variantGroups {
            for variation in variantGroup.variations {
                guard variation.isSelected else {
                    continue
                }
                let selectedPair = ExcludedCombination(groupId: variantGroup.groupId,
                                                       variationId: variation.id)
                selectedVariationPairs.append(selectedPair)
            }
        }
        return selectedVariationPairs
    }
}


