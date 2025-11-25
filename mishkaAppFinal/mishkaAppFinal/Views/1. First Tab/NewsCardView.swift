//
//  NewsCardView.swift
//  mishkaAppFinal
//
//  Created by Roman on 20.11.25.
//

import SwiftUI

struct NewsCardView: View {
    let post: NewsPost

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(post.title)
                    .font(.headline)
                Spacer()
                Text(post.timestamp.formattedRu())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemFill))
                    .frame(height: 160)

                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(.secondary)
            }

            Text(post.text)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)

        }
        .padding(.vertical, 8)
    }
}
