//
//  KeyboardToolbarModifier.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

public struct KeyboardToolbarModifier: ViewModifier {
    let title: String
    let onDone: () -> Void
    
    init(title: String, onDone: @escaping () -> Void) {
        self.title = title
        self.onDone = onDone
    }
    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(title) {
                        onDone()
                    }
                    .tint(Color.red)
                }
            }
    }
}

public extension View {
    func withKeyboardToolbar(title: String = "Done", onDone: @escaping () -> Void) -> some View {
        self.modifier(KeyboardToolbarModifier(title: title, onDone: onDone))
    }
}

public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
