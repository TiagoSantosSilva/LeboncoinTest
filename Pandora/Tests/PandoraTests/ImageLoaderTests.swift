//
//  ImageLoaderTests.swift
//  Pandora
//
//  Created by Tiago Silva on 09/03/2025.
//

import UIKit
import Testing
@testable import Pandora

@Suite
final class ImageLoaderTests {
    private var imageLoader: ImageLoader!
    private var mockSession: MockURLSession!
    private var mockDataTask: MockURLSessionDataTask!

    init() {
        mockSession = MockURLSession()
        mockDataTask = MockURLSessionDataTask()

        mockSession.dataTaskHandler = { url, completion in
            self.mockDataTask.completion = completion
            self.mockSession.lastDataTask = self.mockDataTask
            return self.mockDataTask
        }

        imageLoader = ImageLoader(session: mockSession)
    }

    @Test("Loading image from cache returns cached image without creating network task")
    func testImageLoadingFromCache() async throws {
        let url = URL(string: "https://example.com/image.jpg")!
        let expectedImage = UIImage(systemName: "photo")!

        imageLoader.imageCache.setObject(expectedImage, forKey: url.absoluteString as NSString)

        var receivedImage: UIImage?
        _ = imageLoader.loadImage(from: url) { image in
            receivedImage = image
        }

        await Task.yield()

        #expect(receivedImage == expectedImage)
        #expect(mockSession.lastDataTask == nil)
    }

    @Test("Loading image from network succeeds and caches the result")
    func testImageLoadingFromNetwork() async throws {
        let url = URL(string: "https://example.com/image.jpg")!
        let imageData = createTestImageData()

        mockSession.data = imageData
        mockSession.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let completionTask = Task<UIImage?, Never> { () -> UIImage? in
            await withCheckedContinuation { continuation in
                _ = imageLoader.loadImage(from: url) { image in
                    continuation.resume(returning: image)
                }

                if let completion = mockDataTask.completion {
                    completion(imageData, mockSession.response, nil)
                }
            }
        }

        let receivedImage = await completionTask.value

        #expect(receivedImage != nil)
        #expect(mockSession.lastDataTask != nil)

        let cachedImage = imageLoader.imageCache.object(forKey: url.absoluteString as NSString)
        #expect(cachedImage != nil)
    }

    @Test("Loading image with network error returns nil")
    func testImageLoadingFailure() async throws {
        let url = URL(string: "https://example.com/badimage.jpg")!
        let error = NSError(domain: "test", code: 404, userInfo: nil)

        mockSession.error = error

        var receivedImage: UIImage?
        _ = imageLoader.loadImage(from: url) { image in
            receivedImage = image
        }

        if let completion = mockDataTask.completion {
            completion(nil, nil, error)
        }

        await Task.yield()

        #expect(receivedImage == nil)
    }

    @Test("Task cancellation removes task from tracking and marks it as cancelled")
    func testTaskCancellation() {
        let url = URL(string: "https://example.com/image.jpg")!

        _ = imageLoader.loadImage(from: url) { _ in }

        #expect(!mockDataTask.isCancelled)

        imageLoader.cancelTask(for: url)

        #expect(mockDataTask.isCancelled)

        imageLoader.taskLock.lock()
        let hasTask = imageLoader.runningTasks[url] != nil
        imageLoader.taskLock.unlock()

        #expect(!hasTask)
    }

    @Test("Memory warning clears the image cache")
    func testCacheClearingOnMemoryWarning() {
        let url = URL(string: "https://example.com/image.jpg")!
        let expectedImage = UIImage(systemName: "photo")!

        imageLoader.imageCache.setObject(expectedImage, forKey: url.absoluteString as NSString)

        #expect(imageLoader.imageCache.object(forKey: url.absoluteString as NSString) != nil)

        NotificationCenter.default.post(name: UIApplication.didReceiveMemoryWarningNotification, object: nil)

        #expect(imageLoader.imageCache.object(forKey: url.absoluteString as NSString) == nil)
    }

    @Test("Concurrent access to image loader doesn't crash")
    func testConcurrentAccess() async throws {
        let url1 = URL(string: "https://example.com/image1.jpg")!
        let url2 = URL(string: "https://example.com/image2.jpg")!

        let imageData = createTestImageData()

        let mockTasks = (0..<20).map { _ in MockURLSessionDataTask() }
        var taskIndex = 0

        let originalHandler = mockSession.dataTaskHandler
        mockSession.dataTaskHandler = { url, completion in
            let task = mockTasks[taskIndex]
            task.completion = completion
            taskIndex += 1
            return task
        }

        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 0..<10 {
                group.addTask {
                    let url = i % 2 == 0 ? url1 : url2
                    _ = self.imageLoader.loadImage(from: url) { _ in }

                    if let index = mockTasks.firstIndex(where: {
                        $0.completion != nil && !$0.isCancelled
                    }) {
                        mockTasks[index].completion?(imageData, nil, nil)
                    }
                }

                group.addTask {
                    let url = i % 2 == 0 ? url1 : url2
                    self.imageLoader.cancelTask(for: url)
                }
            }

            for try await _ in group { }
        }

        mockSession.dataTaskHandler = originalHandler
    }
}

private extension ImageLoaderTests {
    func createTestImageData() -> Data {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        let image = renderer.image { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        return image.pngData()!
    }
}
