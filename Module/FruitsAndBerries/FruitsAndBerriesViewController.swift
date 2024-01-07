//
//  FruitsAndBerriesViewController.swift
//  iOS-Test
//

import UIKit
import SnapKit

protocol FruitsAndBerriesDisplayLogic: AnyObject {
  func display(model: FruitsAndBerriesModels.Load.ViewModel)
  func display(model: FruitsAndBerriesModels.Loading.ViewModel)
  func display(model: FruitsAndBerriesModels.Alert.ViewModel)
  func display(model: FruitsAndBerriesModels.SelectItem.ViewModel)
  func display(model: FruitsAndBerriesModels.LoadDetail.ViewModel)
}

class FruitsAndBerriesViewController: BaseViewController {
  
  // MARK: - Properties
  
  private lazy var tableView: UITableView = .init(frame: .zero, style: .plain) &> {
    $0.backgroundColor = .clear
    $0.dataSource = self
    $0.delegate = self
    $0.rowHeight = 150
    $0.separatorStyle = .none
  }
  
  private lazy var refreshBarButtonItem: UIBarButtonItem = .init() &> {
    $0.tintColor = UIColor(hex: "#FFFFFF")
    $0.image = UIImage(named: "ic_refresh")
  }
  
  private weak var detailVC: FruitsAndBerriesDetailsViewController?
  
  private var dataSource: [GroceryProductViewModel] = []
  
  var interactor: FruitsAndBerriesBusinessLogic?
  var router: FruitsAndBerriesRoutingLogic?
  
  // MARK: - Lifecycle
  
  override func loadView() {
    super.loadView()
    
    view = UIView()
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadData()
  }
  
  // MARK: - Override
  
  
  override func setupUI() {
    super.setupUI()
    
    refreshBarButtonItem.target = self
    refreshBarButtonItem.action = #selector(refreshAction)
    navigationItem.rightBarButtonItem = refreshBarButtonItem
    
    tableView.registerCell(forClass: GroceryProductTableViewCell.self)
  }
  
  // MARK: - Action
  
  @objc
  func refreshAction(_ sender: AnyObject) {
    loadData()
  }
  
  // MARK: - Private
  
  func loadData() {
    let request = FruitsAndBerriesModels.Load.Request()
    interactor?.load(request: request)
  }
  
}

extension FruitsAndBerriesViewController: FruitsAndBerriesDisplayLogic {
  
  func display(model: FruitsAndBerriesModels.Load.ViewModel) {
    dataSource = []
    tableView.reloadData()
    
    title = model.title
    dataSource = model.dataSource
    
    let section = IndexSet(integer: 0)
    tableView.reloadSections(section, with: .bottom)
  }
  
  func display(model: FruitsAndBerriesModels.Loading.ViewModel) {
    if let detailVC {
      detailVC.display(model: model)
      
      return
    }
    
    model.isLoading ? startAnimation() : stopAnimation()
  }
  
  func display(model: FruitsAndBerriesModels.Alert.ViewModel) {
    if let detailVC {
      detailVC.display(model: model)
      
      return
    }
    
    stopAnimation()
    
    showAlert(title: model.title, message: model.message)
  }
  
  func display(model: FruitsAndBerriesModels.SelectItem.ViewModel) {
    let viewController = FruitsAndBerriesDetailsViewController()
    viewController.interactor = interactor
    viewController.router = router
    
    detailVC = viewController
    
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  func display(model: FruitsAndBerriesModels.LoadDetail.ViewModel) { 
    detailVC?.display(model: model)
  }
  
}

// MARK: - UITableViewDelegate
extension FruitsAndBerriesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let request = FruitsAndBerriesModels.SelectItem.Request(indexPath: indexPath)
    
    interactor?.select(request: request)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

// MARK: - UITableViewDataSource
extension FruitsAndBerriesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forClass: GroceryProductTableViewCell.self, indexPath: indexPath)
    let cellViewModel = dataSource[indexPath.row]
    
    return cell &> {
      $0.mainColor = cellViewModel.mainColor
      $0.textColor = cellViewModel.textColor
      $0.text = cellViewModel.title
      $0.icon(with: cellViewModel.iconPath)
    }
  }
  
}

