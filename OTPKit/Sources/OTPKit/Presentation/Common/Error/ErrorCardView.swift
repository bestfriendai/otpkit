//
//  ErrorCardView.swift
//  OTPKit
//
//  Created by Manu on 2025-07-06.
//

import SwiftUI

struct ErrorCardView: View {
    let message: String
    let onDismiss: () -> Void

    @Environment(\.otpTheme) private var theme

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.title2)

                Text("Error")
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            }

            Text(message)
                .font(.subheadline)
                .foregroundColor(theme.secondaryColor)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .cardStyle(cornerRadius: 12, backgroundColor: .background)
        .padding(.horizontal)
    }
}

#Preview {
    ErrorCardView(message: "Something went wrong while planning your trip", onDismiss: {
        // Preview dismiss action
    })
        .preferredColorScheme(.dark)
}
