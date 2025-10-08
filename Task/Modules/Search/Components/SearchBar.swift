//
//  SearchBar.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 20) {

            TextField("Search", text: $text)
                .padding(.leading,20)
                .font(.system(size: 14))
                .foregroundColor(Color.black)
                .lineLimit(1)
                .frame(height: 56)
                .background(Color.blue.opacity(0.08))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
    }
}

