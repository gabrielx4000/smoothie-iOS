import UIKit

public class HomeViewController: UIViewController {

    private let viewModel: HomeViewModel

    public init(factory: HomeFactoryPresentationProtocol) {
        self.viewModel = factory.createHomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
}
