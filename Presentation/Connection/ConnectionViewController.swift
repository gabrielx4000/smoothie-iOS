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
        titleLabel.textColor = Color.textPrimary.rawValue
        titleLabel.text = "connection_screen_title".localized
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var textLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Color.textPrimary.rawValue
        titleLabel.text = "connection_screen_text".localized
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("connection_screen_button".localized, for: .normal)
        button.backgroundColor = Color.primary.rawValue
        button.tintColor = Color.actionTextOnColor.rawValue
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
        
        view.backgroundColor = Color.backgroundPrimary.rawValue
        
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
        animationView.animation = Animation.disconnect
        animationView.loopMode = .loop
        animationView.play()
    }
    
    @objc func didTapButton() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        
        feedbackGenerator.prepare()
        
        let animation = { [weak self] in
            guard let self = self else { return }
            
            feedbackGenerator.notificationOccurred(.success)
            
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
