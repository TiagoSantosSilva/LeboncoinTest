//
//  UIImageView+AdImageLoading.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora
import UIKit

extension UIImageView {
    private static let imageTaskKey = UnsafeRawPointer(bitPattern: "imageTask".hashValue)!
    private static let thumbnailTaskKey = UnsafeRawPointer(bitPattern: "thumbnailTask".hashValue)!

    private var imageTask: URLSessionDataTaskProtocol? {
        get { return objc_getAssociatedObject(self, UIImageView.imageTaskKey) as? URLSessionDataTaskProtocol }
        set { objc_setAssociatedObject(self, UIImageView.imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var thumbnailTask: URLSessionDataTaskProtocol? {
        get { return objc_getAssociatedObject(self, UIImageView.thumbnailTaskKey) as? URLSessionDataTaskProtocol }
        set { objc_setAssociatedObject(self, UIImageView.thumbnailTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func cancelImageLoading() {
        if let thumbnailURL = thumbnailTask?.originalRequest?.url {
            ImageLoader.shared.cancelTask(for: thumbnailURL)
        }

        if let imageURL = imageTask?.originalRequest?.url {
            ImageLoader.shared.cancelTask(for: imageURL)
        }

        thumbnailTask = nil
        imageTask = nil
    }

    func loadImage(
        from images: Ad.Images,
        with loader: ImageLoaderProtocol = ImageLoader.shared,
        placeholder: UIImage? = UIImage(systemName: "photo")
    ) {
        cancelImageLoading()

        if image == nil {
            image = placeholder
        }

        if let thumbnailURL = images.thumbnail {
            thumbnailTask = loader.loadImage(from: thumbnailURL) { [weak self] thumbnailImage in
                guard let self else { return }

                if let thumbnailImage = thumbnailImage {
                    UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
                        self.image = thumbnailImage
                    }
                }

                self.loadFullImage(from: images.small, placeholder: thumbnailImage ?? placeholder)
            }
        } else {
            loadFullImage(from: images.small, placeholder: placeholder)
        }
    }

    private func loadFullImage(
        from url: URL?,
        with loader: ImageLoaderProtocol = ImageLoader.shared,
        placeholder: UIImage?
    ) {
        guard let url else {
            guard image == nil else { return }
            return image = placeholder
        }

        imageTask = loader.loadImage(from: url) { [weak self] fullImage in
            guard let self else { return }

            if let fullImage {
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
                    self.image = fullImage
                }
            } else if image == nil {
                image = placeholder
            }
        }
    }
}
