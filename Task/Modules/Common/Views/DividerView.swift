//
//  DividerView.swift
//  Task
//
//  Created by apple on 08/10/25.
//


import SwiftUI

// MARK: - Divider View
struct DividerView: View {
    let height: CGFloat
    
    init(height: CGFloat = 1) {
        self.height = height
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: height)
    }
}
