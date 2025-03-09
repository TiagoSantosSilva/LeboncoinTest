//
//  ImageLoader+SwiftUI.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import SwiftUI

public struct CachedImage: View {
    private let url: URL?
    private let thumbnail: URL?
    @StateObject private var loader = ImageLoaderObject()

    public init(
        url: URL?,
        thumbnail: URL?
    ) {
        self.url = url
        self.thumbnail = thumbnail
    }

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }
        }
        .cornerRadius(8)
        .onAppear {
            loader.load(url: url, thumbnailURL: thumbnail)
        }
        .onDisappear {
            loader.cancel()
        }
    }
}

public class ImageLoaderObject: ObservableObject {
    @Published var image: UIImage?

    private var imageTask: URLSessionDataTaskProtocol?
    private var thumbnailTask: URLSessionDataTaskProtocol?
    private var imageURL: URL?
    private var thumbnailURL: URL?

    public func load(url: URL?, thumbnailURL: URL?) {
        cancel()

        self.imageURL = url
        self.thumbnailURL = thumbnailURL

        if let thumbnailURL = thumbnailURL {
            thumbnailTask = ImageLoader.shared.loadImage(from: thumbnailURL) { [weak self] thumbnailImage in
                guard let self = self else { return }

                if let thumbnailImage = thumbnailImage {
                    DispatchQueue.main.async {
                        self.image = thumbnailImage
                    }
                }

                self.loadFullImage(from: url)
            }
        } else {
            loadFullImage(from: url)
        }
    }

    private func loadFullImage(from url: URL?) {
        guard let url = url else { return }

        imageTask = ImageLoader.shared.loadImage(from: url) { [weak self] fullImage in
            guard let self = self else { return }

            if let fullImage = fullImage {
                DispatchQueue.main.async {
                    self.image = fullImage
                }
            }
        }
    }

    public func cancel() {
        if let thumbnailURL = thumbnailURL {
            ImageLoader.shared.cancelTask(for: thumbnailURL)
        }

        if let imageURL = imageURL {
            ImageLoader.shared.cancelTask(for: imageURL)
        }

        thumbnailTask = nil
        imageTask = nil
    }

    deinit {
        cancel()
    }
}
