//
//  ListRepository.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import Foundation

protocol ListRepositoryInterface {
    func loadSection() async throws -> [ListSection]
}
