//
//  ViewController.swift
//  M17_Concurrency
//
//  Created by Maxim NIkolaev on 08.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let service = Service()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 220, y: 220, width: 140, height: 140))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        onLoad()
    }

    private func onLoad() {
        service.getImageURL { urlString, error in
            guard
                let urlString = urlString
            else {
                return
            }
            
            let image = self.service.loadImage(urlString: urlString)
            self.imageView.image = image
            
            self.activityIndicator.stopAnimating()
        }
    }
}

