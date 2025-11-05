//
//  SearchBar.swift
//  OTPKit
//
//  Created by Manu on 2025-07-14.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    let onSearchTextChange: (String) -> Void

    @FocusState private var isSearchFocused: Bool
    @Environment(\.otpTheme) private var theme

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(theme.secondaryColor)
                .font(.system(size: 16))

            TextField("Search for places", text: $searchText)
                .focused($isSearchFocused)
                .font(.system(size: 16))
                .textFieldStyle(PlainTextFieldStyle())
                .onChange(of: searchText) { _, newValue in
                    onSearchTextChange(newValue)
                }
                .accessibilityLabel("Search for places")
                .accessibilityHint("Enter a location name or address to search")

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    onSearchTextChange("")
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(theme.secondaryColor)
                        .font(.system(size: 16))
                })
                .accessibilityLabel("Clear search")
                .accessibilityHint("Tap to clear the search field")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// Preview
struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""

    static var previews: some View {
        SearchBar(
            searchText: $searchText,
            onSearchTextChange: { _ in
                // Preview search change
            }
        )
        .padding()
    }
}
