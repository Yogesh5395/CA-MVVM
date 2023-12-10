//
//  SecondViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import UIKit

class ChildViewController: UIViewController {
    
    let containerView = UIView()
    let segmentedControl = UISegmentedControl(items: ["All", "Favourite"])
    var childTableViewController = UITableViewController()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems(leftButtonTitle: "", rightButtonTitle: "", logoImageName: ImageName.logoImageName, showLogoImage: false, backgroundColor: .white)
        
        configSearchController()
        setupSegmentedControl()
        setupContainerView()
        
        // Set up the child UITableViewController
        setupChildTableViewController()
    }
    
    func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupContainerView() {
        
        segmentedControl.layer.borderColor = .none
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Add the segmented control to the container view
        containerView.addSubview(segmentedControl)
        
        // Setup constraints for the container view
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalTo: segmentedControl.heightAnchor, constant: 16) // This is the height of segmentedControl plus some padding
        ])
        
        // Add left and right buttons to the container view
        let editButton = UIButton(type: .system)
        editButton.setTitle("Edit", for: .normal)
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)

        let iconButton = UIButton(type: .system)
        iconButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        iconButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(editButton)
        containerView.addSubview(iconButton)

        // Setup constraints for the buttons and segmented control
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            editButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            
            iconButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            iconButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            
            segmentedControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            segmentedControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupChildTableViewController() {
        // Add the UITableViewController as a child
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        
        guard let newRootVC = storyboard.instantiateViewController(withIdentifier: "BaseTableViewController") as? BaseTableViewController else {
            return
        }
        
        childTableViewController = newRootVC
        addChild(childTableViewController)
        
        // Set up the child's view
        childTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childTableViewController.view)
        
        // Add constraints for child's view
        NSLayoutConstraint.activate([
            childTableViewController.view.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            childTableViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            childTableViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            childTableViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        // Don't forget to call these lifecycle methods
        childTableViewController.didMove(toParent: self)
        
        // Additional setup if needed, e.g., setting the delegate and dataSource of the table view
        childTableViewController.tableView.delegate = self
        childTableViewController.tableView.dataSource = self
        
        // If you need to customize the UITableViewController further, do so here
        // For example, register cells or set up the header view
    }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // Add target for UIControl.Event.valueChanged
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        // Handle the segment change
        switch sender.selectedSegmentIndex {
        case 0:
            print("All selected")
            // Implement your code for the "All" segment
        case 1:
            print("Voicemail selected")
            // Implement your code for the "Voicemail" segment
        default:
            break
        }
    }
    
    @objc func editTapped() {
        // Handle edit action
    }
    
    @objc func addBarButtonTapped() {
        // Handle icon action
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChildViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows for the table
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "indexPath.row: \(indexPath.row)"
        return cell
    }
    
    // Implement other delegate and dataSource methods as needed
}

extension ChildViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        print("searchText: ",searchText)
    }
}
