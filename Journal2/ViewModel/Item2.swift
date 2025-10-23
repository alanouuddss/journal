//
//  Item2.swift
//  Journal2
//
//  Created by AlAnoud Alsaaid on 01/05/1447 AH.
//

import Foundation

struct Item2: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool
    var audioURL: URL?

    init(id: UUID = UUID(),
         title: String,
         content: String,
         date: Date = .now,
         isBookmarked: Bool = false,
         audioURL: URL? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.isBookmarked = isBookmarked
        self.audioURL = audioURL
    }
}
