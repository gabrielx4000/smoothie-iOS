import UIKit

public class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    
    public init(factory: SearchFactoryPresentationProtocol) {
        self.viewModel = factory.createSearchViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
}
