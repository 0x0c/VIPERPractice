//
//  ListSectionViewModel.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

class ListSectionViewModel {
    private let section: ListSection
    var title: String {
        return section.title
    }
    let items: [ListCellViewModel]

    init(section: ListSection) {
        self.section = section
        self.items = section.items.map({
            ListCellViewModel(item: $0)
        })
    }
}
