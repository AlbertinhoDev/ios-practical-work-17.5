import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let service = Service()
    
    private var images: [UIImage] = []
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setupView()
        onLoad()
    }
    
    private func setupView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview()
        }
    }
    
    private func onLoad() {
        let dispatchGroup = DispatchGroup()
        
        for _ in 0...4 {
            dispatchGroup.enter()
            
            DispatchQueue.global().async {
                self.service.getImageURL { urlString, error in
                    guard let urlString = urlString else { return }
                    
                    let image = self.service.loadImage(urlString: urlString)

                    if let image = image {
                        self.images.append(image)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else {return}
            self.activityIndicator.stopAnimating()
            for i in 0...4 {
                self.imageView.image = self.images[i]
                self.stackView.addArrangedSubview(self.imageView)
            }
        }
        
     }
}

