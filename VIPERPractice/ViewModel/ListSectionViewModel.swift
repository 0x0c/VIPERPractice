//
//  ListSectionViewModel.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

class ListSectionViewModel {
    // MARK: Lifecycle

    init(section: ListSection) {
        self.section = section
        items = section.items.map {
            ListCellViewModel(item: $0)
        }
    }

    // MARK: Internal

    let items: [ListCellViewModel]

    var title: String {
        return section.title
    }

    // MARK: Private

    private let section: ListSection
}
