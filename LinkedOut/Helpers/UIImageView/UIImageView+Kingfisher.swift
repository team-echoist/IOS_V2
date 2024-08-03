//
//  UIImageView+Kingfisher.swift
//  LinkedOut
//
//  Created by 이상하 on 8/2/24.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift

public typealias ImageOptions = KingfisherOptionsInfo

public enum ImageResult {
    case success(UIImage)
    case failure(Error)

    var image: UIImage? {
        if case .success(let image) = self {
            return image
        } else {
            return nil
        }
    }

    var error: Error? {
        if case .failure(let error) = self {
            return error
        } else {
            return nil
        }
    }
}

extension UIImageView {
    @discardableResult
    public func setImage(
        with resource: Resource?,
        placeholder: UIImage? = nil,
        options: ImageOptions? = nil,
        progress: ((Int64, Int64) -> Void)? = nil,
        completion: ((ImageResult) -> Void)? = nil
    ) -> DownloadTask? {
        /*
        var options = options ?? []
        // GIF will only animates in the AnimatedImageView
        if self is AnimatedImageView == false {
            options.append(.onlyLoadFirstFrame)
        }
        
        let completionHandler: CompletionHandler = { image, error, cacheType, url in
            if let image = image {
                completion?(.success(image))
            } else if let error = error {
                completion?(.failure(error))
            }
        }
        return self.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: options,
            progressBlock: progress,
            completionHandler: completionHandler
        )
         */
        return nil
    }
}

extension Reactive where Base: UIImageView {
    public func image(placeholder: UIImage? = nil, options: ImageOptions) -> Binder<Resource?> {
        return Binder(self.base) { imageView, resource in
            imageView.setImage(with: resource, placeholder: placeholder, options: options)
        }
    }
}

extension KingfisherWrapper where Base: UIImageView {
    public func setLocalImage(withUrl url: URL?){
        if let url = url{
            do {
                let imageData = try Data(contentsOf: url)
                self.base.image = UIImage(data: imageData)
            } catch {
                print("Unable to load data: \(error)")
            }
        }
    }
}
