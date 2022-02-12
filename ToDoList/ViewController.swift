//
//  ViewController.swift
//  ToDoList
//
//  Created by Vadym Shemchuk on 09.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var userTasks: [Ticket] = []
    //lazy var userTicket = Ticket(ticketID:)
    let defaults = UserDefaults.standard
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray5
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.right.left.top.bottom.equalToSuperview()
        }
        return tableView
    }()
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTaskButtonTollBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = defaults.data(forKey: "Saved tasks") {
            let savedTasks = try! PropertyListDecoder().decode([Ticket].self, from: data)
            userTasks = savedTasks
        }
            self.tableView.reloadData()
    }
    
}

// MARK: - Private

private extension ViewController {

    
    
    
    func setupTaskButtonTollBar(){
        navigationItem.title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Task", style: .done, target: self, action: #selector(addTask))
    }
    
    @objc func addTask() {
        let popUp = PopUpWindow()
        popUp.transmittedPopUpText = { [weak self] in
            var emptyTitle: String
            if let userTitle = $0, !userTitle.isEmpty {
                emptyTitle = userTitle
            }
            else {
                emptyTitle = "New Task"
            }
            let ticket = Ticket.init(title: emptyTitle, description: nil, date: nil)
            self?.userTasks.insert(ticket, at: 0)
            if let data = try? PropertyListEncoder().encode(self?.userTasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
            self?.tableView.reloadData()
        }
        self.present(popUp, animated: true, completion: nil)
    }
    
    @objc func didSelectRow(index:Int, ticketTitle: String, ticketDescription: String?, ticketDate: Date?) {
        let secondController = SecondViewController()
        secondController.receivedTicket = userTasks[index].self
        secondController.transmittedTicket = {[weak self] in
            self?.userTasks[index] = $0
            if let data = try? PropertyListEncoder().encode(self?.userTasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(secondController, animated: true)
    }
    
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as?
                CustomTableViewCell else {return UITableViewCell()}
        cell.titleLabel.text = userTasks[indexPath.row].title
        cell.descriptionLabel.text = userTasks[indexPath.row].description
        cell.dateLabel.text = userTasks[indexPath.row].date?.formatted(date: .abbreviated, time: .shortened)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            userTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            if let data = try? PropertyListEncoder().encode(userTasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
        }
    }
    
}

// MARK: - table touch handling

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskString = "\(userTasks[indexPath.row])"
        didSelectRow(index: indexPath.row, ticketTitle:taskString, ticketDescription: "", ticketDate: nil)
    }
    
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overCurrentContext
    }
}

