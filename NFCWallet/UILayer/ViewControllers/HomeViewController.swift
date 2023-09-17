//
//  ViewController.swift
//  NFCWallet
//
//  Created by Imran Hajiyev on 17.09.23.
//

import UIKit

class HomeViewController: UIViewController {

    let readButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Read NFC"
        button.configuration?.baseBackgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemBackground
        self.setupButton()
    }

    private func setupButton() {
        self.view.addSubview(readButton)
        
        self.readButton.addTarget(self, action: #selector(readNFC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.readButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.readButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc func readNFC() {
        print("Ready to read NFC types!")
    }
}

