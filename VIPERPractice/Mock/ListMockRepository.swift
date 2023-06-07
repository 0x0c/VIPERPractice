//
//  ListMockRepository.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

final class ListMockRepository: ListRepositoryInterface {
    func loadSection() async throws -> [ListSection] {
        try await Task.sleep(for: .seconds(Int.random(in: 1...3)))
        var sections = [ListSection]()
        for index in 0...Int.random(in: 0...5) {
            var items = [ListItem]()
            for _ in 0...Int.random(in: 0...5) {
                items.append(
                    ListItem(
                        title: "title",
                        subtitle: "subtitle",
                        thumbnailURL: URL(
                            string: "https://dummyimage.com/60x60/\(UIColor.random().toHex())/ffffff"
                        ),
                        backgroundColorString: UIColor.random().toHex()
                    )
                )
            }
            sections.append(
                ListSection(
                    title: "Section \(index)",
                    items: items
                )
            )
        }
        return sections
    }
}
