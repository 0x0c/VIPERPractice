//
//  ListCellViewModel.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

class ListCellViewModel {
    let item: ListItem

    var title: String {
        return item.title
    }

    var subtitle: String {
        return item.subtitle
    }

    var thumbnailURL: URL? {
        return item.thumbnailURL
    }

    var backgroundColor: UIColor? {
        return UIColor(hexString: item.backgroundColorString)
    }
    
    var checked: Bool = false
    var indexPath: IndexPath?

    init(item: ListItem) {
        self.item = item
    }
}
