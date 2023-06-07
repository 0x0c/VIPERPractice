//
//  ListSection.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

struct ListSection {
    let title: String
    let items: [ListItem]

    init(title: String, items: [ListItem]) {
        self.title = title
        self.items = items
    }
}
