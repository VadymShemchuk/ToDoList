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
    private var table: UITableView!
    private var button = UIButton()
    private var textView = UITextField()
    private var mainView = UIView()
    var tasks: [Ticket] = []
    var userTicket = Ticket()
    let defaults = UserDefaults.standard
    var titleFromPopUp: String?
    
    @objc func didSelectRow(index:Int, ticketTitle: String, ticketDescription: String?, ticketDate: Date?) {
        let secondController = secondViewController()
        secondController.receptionData = tasks[index].self
        secondController.returnedText = {[weak self] in
            self?.tasks[index] = $0
            if let data = try? PropertyListEncoder().encode(self?.tasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
            self?.table.reloadData()
        }
        navigationController?.pushViewController(secondController, animated: true)
    }
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "To Do List"
        setupTable()
        setupTaskButtonTollBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = defaults.data(forKey: "Saved tasks") {
            let savedTasks = try! PropertyListDecoder().decode([Ticket].self, from: data)
            tasks = savedTasks
        }
        table.reloadData()
    }
}

// MARK: - Private

private extension ViewController {
    
    func setupTable() {
        table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.estimatedRowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .systemGray5
        table.tableFooterView = UIView()
        table.separatorColor = UIColor.clear
        self.view.addSubview(table)
        table.snp.makeConstraints {
            $0.right.left.top.bottom.equalToSuperview()
        }
    }
    
    func setupTaskButtonTollBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Task", style: .done, target: self, action: #selector(addTask))
    }
    
    @objc func addTask() {
        let popUp = PopUpWindow()
        popUp.returnedPopUpText = { [weak self] in
            var emtyTitle: String
            if let userTitle = $0, !userTitle.isEmpty {
                emtyTitle = userTitle
            }
            else {
                emtyTitle = "New Task"
            }
            let ticket = Ticket.init(title: emtyTitle, description: nil, date: nil)
            self?.tasks.insert(ticket, at: 0)
            if let data = try? PropertyListEncoder().encode(self?.tasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
            self?.table.reloadData()
        }
        self.present(popUp, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as?
                CustomTableViewCell else {return UITableViewCell()}
        cell.titleLBL.text = tasks[indexPath.row].title
        cell.descrLBL.text = tasks[indexPath.row].description
        cell.dateLBL.text = tasks[indexPath.row].date?.formatted(date: .abbreviated, time: .shortened)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tasks.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            if let data = try? PropertyListEncoder().encode(tasks) {
                    UserDefaults.standard.set(data, forKey: "Saved tasks")
                }
        }
    }
}

// MARK: - table touch handling

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskString = "\(tasks[indexPath.row])"
        didSelectRow(index: indexPath.row, ticketTitle:taskString, ticketDescription: "", ticketDate: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overCurrentContext
    }
}

