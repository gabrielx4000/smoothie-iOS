import Combine
import SnapKit
import UIKit

public class FruitsViewController: UIViewController {
    
    private static let Identifier = "fruitCell"
    
    private let viewModel: FruitsViewModel
    
    private var cancellables = [AnyCancellable]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(FruitsTableViewCell.self, forCellReuseIdentifier: FruitsViewController.Identifier)
        tableView.allowsSelection = false
        return tableView
    }()
    
    public init(factory: FruitsFactoryPresentationProtocol) {
        self.viewModel = factory.createFruitsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backgroundPrimary.rawValue
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = false
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        title = "fruits_screen_title".localized
        
        buildTableView()
    }
    
    func buildTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalToSuperview()
        }
        
        viewModel.$fruits
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }
    
}

extension FruitsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fruits.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FruitsViewController.Identifier) as? FruitsTableViewCell ?? FruitsTableViewCell(style: .default, reuseIdentifier: FruitsViewController.Identifier)
        
        let fruit = viewModel.fruits[indexPath.row]
        
        cell.titleLabel.text = fruit.name
        
        return cell
    }
    
}
