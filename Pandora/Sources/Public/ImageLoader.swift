//
//  ImageLoader.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import UIKit

public protocol ImageLoaderProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTaskProtocol?
    func cancelTask(for url: URL)
}

public final class ImageLoader: ImageLoaderProtocol {
    public static let shared = ImageLoader(session: URLSession.shared)

    let imageCache = NSCache<NSString, UIImage>()
    let taskLock = NSLock()
    var runningTasks = [URL: URLSessionDataTaskProtocol]()

    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol) {
        self.session = session
        imageCache.countLimit = 1000
        imageCache.totalCostLimit = 5000 * 1024 * 1024

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearCache),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func loadImage(
        from url: URL,
        completion: @escaping (UIImage?) -> Void
    ) -> URLSessionDataTaskProtocol? {
        let urlString = url.absoluteString as NSString
        if let cachedImage = imageCache.object(forKey: urlString) {
            completion(cachedImage)
            return nil
        }

        cancelTask(for: url)

        let task = session.dataTask(url: url) { [weak self] data, response, error in
            guard
                let self,
                let data,
                let image = UIImage(data: data),
                error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            self.imageCache.setObject(image, forKey: urlString)

            self.taskLock.lock()
            self.runningTasks.removeValue(forKey: url)
            self.taskLock.unlock()

            DispatchQueue.main.async {
                completion(image)
            }
        }

        taskLock.lock()
        runningTasks[url] = task
        taskLock.unlock()

        task.resume()
        return task
    }

    public func cancelTask(for url: URL) {
        taskLock.lock()
        defer { taskLock.unlock() }

        guard let task = runningTasks[url] else { return }
        task.cancel()
        runningTasks.removeValue(forKey: url)
    }
}

extension ImageLoader {
    @objc
    internal func clearCache() {
        imageCache.removeAllObjects()
    }
}
