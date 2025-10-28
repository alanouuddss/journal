//
//  Card2.swift
//  Journal2
//
//  Created by AlAnoud Alsaaid on 01/05/1447 AH.
//

import SwiftUI

struct Card2: View {
    let it: Item2
    let accent: Color
    var onBookmark: () -> Void
    var onOpen: () -> Void
    var onDelete: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                Text(it.title).font(.system(size: 22, weight: .bold))
                Text(it.date, style: .date)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                if !it.content.isEmpty {
                    Text(it.content)
                        .font(.system(size: 15))
                        .lineLimit(3)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
            .padding(18)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 26))
            .contentShape(RoundedRectangle(cornerRadius: 26))
            .onTapGesture { onOpen() }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) { onDelete() } label: {
                    Label("Delete", systemImage: "trash")
                        .glassEffect()
                }
            }

            Button(action: onBookmark) {
                Image(systemName: it.isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(it.isBookmarked ? accent : .primary.opacity(0.9))
                    .padding(10)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .glassEffect()
            .padding(10)
        }
    }
}
