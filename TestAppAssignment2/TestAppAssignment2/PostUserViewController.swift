//
//  PostTweetViewController.swift
//  TestAppAssignment2
//
//  Created by Mitchell Holmes on 2019/02/26.
//  Copyright © 2019 Mitchell Holmes. All rights reserved.
//

import Foundation
import UIKit
import MitchHolmesSynchronousPosterGetter

class PostUserViewController: UIViewController {
    let baseURL = "http://jsonplaceholder.typicode.com/posts"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var userDetailsTextView: UITextView!
    @IBAction private func postUserTapped(_ sender: Any) {
        if  let userFirstName = firstNameTextField.text,
            let userLastName = lastNameTextField.text {
            let user = ["name": userFirstName, "surname": userLastName]
            DispatchQueue.global().async {
                let user = TweetService.postUser(url: self.baseURL, body: user)
                self.updateUI(user: user)
            }
        }
    }
    func updateUI(user: TweetService.User) {
        DispatchQueue.main.async { [weak self] in
            self?.userDetailsTextView.text = "User ID: \(user.id) \nFirst Name: \(user.name) \nLast name: \(user.surname)"
        }
    }
}
