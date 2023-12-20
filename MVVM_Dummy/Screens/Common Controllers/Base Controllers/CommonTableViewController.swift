//
//  CommonTableViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 20/12/23.
//

import UIKit

class CommonTableViewController: UITableViewController {
    
    let containerView = UIView()
    let segmentedControl = UISegmentedControl(items: ["All", "Favourite"])
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSearchController()
        setupContainerView()
        setupSegmentedControl()
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
    
    @objc func editTapped() {}
    
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
}

// MARK: - SegmentedControl
extension CommonTableViewController {
    
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
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CommonTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Search Results
extension CommonTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        print("searchText: ",searchText)
    }
}
