//
//  RetryableErrorView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import SwiftUI

struct RetryableErrorView: View {
    let title: String
    let message: String
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }, label: {
            VStack {
                ThemedText(title, fontStyle: .title3)
                ThemedText(message, fontStyle: .subheadline)
                ThemedText("Tap the screen to try again.", fontStyle: .subheadline)
                    .padding(.top, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
}

#Preview {
    RetryableErrorView(title: "An error occurred", message: "Test Error", action: {
        print("Retry tapped")
    })
}
