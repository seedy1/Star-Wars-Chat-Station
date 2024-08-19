//
//  ChatViewController.swift
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController{
    
    // TODO: replace with external db later
    var messages: [Message] = [
//        Message(sender: "1@g.com", body: "Hi"),
//        Message(sender: "fake@ysl.co", body: "you ready?"),
//        Message(sender: "1@g.com", body: "lets do it")
    ]
    let db = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dark side 1nly"
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        fetchDBMessages()

    }
    
    
    
    func fetchDBMessages(){
//        db.collection(Constants.FStore.collectionName).getDocuments { querySnapshot, err in
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { querySnapshot, err in
            self.messages = []
            if let e = err{
                print("FireStore error adding data", e)
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for docs in snapshotDocuments{
                        let data = docs.data()
                        if let msgSender = data[Constants.FStore.senderField] as? String, let msg = data[Constants.FStore.bodyField] as? String{
                            self.messages.append(Message(sender: msgSender, body: msg))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    // send data to external db
    @IBAction func sendPressed(_ sender: UIButton){
        if let msgBody = messageTextfield.text, let msgSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: msgSender, Constants.FStore.bodyField: msgBody, Constants.FStore.dateField: Date().timeIntervalSince1970]) { err in
                if let e = err{
                    print("FireStore error adding data", e)
                }else{
                    print("success")
                }
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        navigationController?.popToRootViewController(animated: true)
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
}

//extension ChatViewController: UITableViewDelegate{
//    
//}

