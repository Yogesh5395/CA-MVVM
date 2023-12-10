//
//  ProductTableTableViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 07/12/23.
//

import UIKit

class BaseTableViewController: UITableViewController {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchText = searchController.searchBar.text
//        print("searchcontroller: ",searchText)
//    }
    

    let containerView = UIView()
    let segmentedControl = UISegmentedControl(items: ["All", "Voicemail"])
    
    let titleLabel = UILabel()
//    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems(leftButtonTitle: "", rightButtonTitle: "", logoImageName: ImageName.logoImageName, showLogoImage: false, backgroundColor: .white)
        
        setupTitleAndSearchBar()
    }
    
    private func setupTitleAndSearchBar() {
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Products"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        // Configure the searchBar
//        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "search title"
//        headerView.addSubview(searchController.searchBar)
        
        // Define the containerView for Auto Layout
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = containerView
        containerView.addSubview(headerView)
        
        // Constraints for the containerView
        containerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        
        // Constraints for the headerView
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        // Constraints for the titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
        ])
        
        // Constraints for the searchBar
//        NSLayoutConstraint.activate([
//            searchController.searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            searchController.searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            searchController.searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
//            searchController.searchBar.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
//        ])
        
        // Set the bottom constraint for the headerView to the containerView
        let bottomConstraint = headerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        
        // Layout the headerView to calculate its size
        tableView.tableHeaderView?.setNeedsLayout()
        tableView.tableHeaderView?.layoutIfNeeded()
        
        // Update the frame of the tableHeaderView based on the layout
        tableView.tableHeaderView?.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        // Set the height of the containerView to be the calculated height of the headerView
        containerView.heightAnchor.constraint(equalToConstant: tableView.tableHeaderView?.frame.height ?? 0).isActive = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame of the tableHeaderView to ensure it sizes correctly
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            // Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }

    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}
