import Lottie
import SnapKit
import UIKit

public class ConnectionViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 18
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "No internet connetion"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var textLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Check your internet connection and try again."
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var animationView = AnimationView()
    
    private let viewModel: ConnectionViewModel
    
    public init(viewModel: ConnectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        view.backgroundColor = .white
        
        buildStackView()
        makeConstraints()
        buildAnimationView()
    }
    
    private func makeConstraints() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        animationView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.width)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func buildStackView() {
        [animationView, titleLabel, textLabel, button].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func buildAnimationView() {
        let animation = Animation.named("90478-disconnect", bundle: Bundle(for: ConnectionViewController.self))
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.play()
    }
    
    @objc func didTapButton() {
        let animation = { [weak self] in
            guard let self = self else { return }
            
            self.button.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        }
        
        let completion: ((Bool) -> Void) = { [weak self] result in
            guard let self = self else { return }
            
            if result {
                self.button.transform = .identity
            }
            
            self.viewModel.retryConnection()
        }
        
        UIView.animate(withDuration: 0.09, delay: 0, options: .curveEaseOut, animations: animation, completion: completion)
    }
    
}
