//
//  ViewController.swift
//  NFCWallet
//
//  Created by Imran Hajiyev on 17.09.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tagReader = TagNFCReader()
    let ndfeReader = NFCNDFEReader()
    
    let readTagButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Read NFC"
        button.configuration?.baseBackgroundColor = .systemBlue
        return button
    }()
    
    let readNDFEButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Read NDFE NFC"
        button.configuration?.baseBackgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemBackground
        self.setupButtons()
    }

    private func setupButtons() {
        self.view.addSubview(readTagButton)
        self.view.addSubview(readNDFEButton)
        
        self.readTagButton.addTarget(self, action: #selector(readNFC), for: .touchUpInside)
        self.readNDFEButton.addTarget(self, action: #selector(readNFCNDFE), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.readTagButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.readTagButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.readNDFEButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.readNDFEButton.topAnchor.constraint(equalToSystemSpacingBelow: self.readTagButton.bottomAnchor, multiplier: 2)
        ])
    }
    
    @objc func readNFC() {
        print("Ready to read Tag NFC!")
        ndfeReader.stopScanning()
        tagReader.beginScanning()
    }
    
    @objc func readNFCNDFE() {
        print("Ready to read NDFE NFC!")
        tagReader.stopScanning()
        ndfeReader.beginScanning()
    }
}

