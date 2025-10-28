//
//  Intro2.swift
//  Journal2
//
//  Created by AlAnoud Alsaaid on 01/05/1447 AH.
//
import SwiftUI

struct Intro2: View {
    @AppStorage("notes.v1") private var rawNotes: Data = Data()
    @AppStorage("sortMode") private var sortMode = 1

    @State private var items: [Item2] = []
    @State private var search = ""
    @State private var editing: Item2? = nil
    @State private var itemToDelete: Item2? = nil
    @State private var showDeleteAlert = false

    private let accent = Color(red: 212/255, green: 200/255, blue: 255/255)

    private var displayed: [Item2] {
        var arr = items
        if !search.isEmpty {
            arr = arr.filter { $0.title.localizedCaseInsensitiveContains(search) || $0.content.localizedCaseInsensitiveContains(search) }
        }
        if sortMode == 0 {
            arr.sort { ($0.isBookmarked ? 0:1, $0.date) < ($1.isBookmarked ? 0:1, $1.date) }
        } else {
            arr.sort { $0.date > $1.date }
        }
        return arr
    }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack(alignment: .firstTextBaseline) {
                Text("Journal").font(.system(size: 34, weight: .bold))
                Spacer()
                HStack(spacing: 18) {
                    Menu {
                        Picker("Sort", selection: $sortMode) {
                            Text("Sort by Bookmark").tag(0)
                            Text("Sort by Entry Date").tag(1)
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 17, weight: .semibold))
                    }
                    Button { editing = Item2(title: "", content: "") } label: {
                        Image(systemName: "plus").font(.system(size: 17, weight: .semibold))
                    }
                }
                .padding(.horizontal, 14)
                .frame(height: 44)
                .background(.ultraThinMaterial, in: Capsule())
                .tint(.primary)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)

            // MARK: Empty / List
            if items.isEmpty && search.isEmpty {
                VStack(spacing: 0) {
                    Image("Splashpage2").resizable().scaledToFit().frame(width: 150, height: 150)
                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(accent)
                        .padding(.top, 20)
                    Text("Craft your personal diary, tap the\nplus icon to begin")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(displayed) { it in
                        Card2(
                            it: it,
                            accent: accent,
                            onBookmark: { toggleBookmark(id: it.id) },
                            onOpen: { editing = it },
                            onDelete: { itemToDelete = it; showDeleteAlert = true }
                        )
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init(top: 8, leading: 20, bottom: 8, trailing: 20))
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }

            // MARK: Search Bar (with mic icon)
            VStack(spacing: 6) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").font(.system(size: 16))
                    TextField("Search", text: $search)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Spacer()
                    Image(systemName: "mic.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                }
                .foregroundColor(.primary.opacity(0.9))
                .frame(height: 44)
                .padding(.horizontal, 14)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 18)
        }
        .onAppear(perform: load)
        .fullScreenCover(item: $editing) { it in
            Editor2(it: it, accent: accent) { saved in
                upsert(saved); editing = nil
            } onCancel: { editing = nil }
            .ignoresSafeArea(.keyboard)
        }
        .alert("Delete Journal?",
               isPresented: $showDeleteAlert,
               presenting: itemToDelete) { it in
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { delete(it) }
        } message: { _ in
            Text("Are you sure you want to delete this journal?")
        }
    }

    // MARK: Data Ops
    private func load() {
        guard !rawNotes.isEmpty,
              let arr = try? JSONDecoder().decode([Item2].self, from: rawNotes) else { return }
        items = arr
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) { rawNotes = data }
    }

    private func upsert(_ it: Item2) {
        if let i = items.firstIndex(where: { $0.id == it.id }) {
            items[i] = it
        } else {
            items.insert(it, at: 0)
        }
        save()
    }

    private func delete(_ it: Item2) {
        items.removeAll { $0.id == it.id }
        save()
    }

    private func toggleBookmark(id: UUID) {
        guard let i = items.firstIndex(where: { $0.id == id }) else { return }
        items[i].isBookmarked.toggle()
        save()
    }
}
