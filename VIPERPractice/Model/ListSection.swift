//
//  ListSection.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

struct ListSection {
    // MARK: Lifecycle

    init(title: String, items: [ListItem]) {
        self.title = title
        self.items = items
    }

    // MARK: Internal

    let title: String
    let items: [ListItem]
}
