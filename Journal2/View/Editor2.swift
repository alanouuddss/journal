//
//  Editor2.swift
//  Journal2
//
//  Created by AlAnoud Alsaaid on 01/05/1447 AH.
//

import SwiftUI

struct Editor2: View {
    @State var it: Item2
    let accent: Color
    var onSave: (Item2) -> Void
    var onCancel: () -> Void

    @State private var showAlert = false
    @FocusState private var focusTitle: Bool
    @FocusState private var focusBody: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button { showAlert = true } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(.ultraThinMaterial, in: Circle())
                }

                Spacer()

                Button {
                    it.title = it.title.trimmingCharacters(in: .whitespacesAndNewlines)
                    onSave(it)
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(accent, in: Circle())
                }
                .disabled(it.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(it.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)

            TextField("Title", text: $it.title)
                .font(.system(size: 32, weight: .bold))
                .focused($focusTitle)
                .submitLabel(.next)
                .onSubmit { focusBody = true }

            Text(it.date, style: .date)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)

            TextEditor(text: $it.content)
                .font(.system(size: 17))
                .frame(maxHeight: .infinity)
                .focused($focusBody)
        }
        .padding(.horizontal, 20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { focusTitle = true }
        }
        .alert("Are you sure you want to discard changes on this journal?",
               isPresented: $showAlert) {
            Button("Discard Changes", role: .destructive) { onCancel() }
            Button("Keep Editing", role: .cancel) { }
        }
        .ignoresSafeArea(.keyboard)
    }
}
