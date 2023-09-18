//
//  TagNFCReader.swift
//  NFCWallet
//
//  Created by Imran Hajiyev on 18.09.23.
//

import CoreNFC

class TagNFCReader: NSObject, NFCTagReaderSessionDelegate {
    var session: NFCTagReaderSession?
    
    func beginScanning() {
        guard NFCTagReaderSession.readingAvailable else {
            print("This device doesn't support tag scanning")
            return
        }
        
        session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
        session?.alertMessage = "Hold your iPhone near the card. Ordinary scanning."
        session?.begin()
    }
    
    func stopScanning() {
        session?.invalidate()
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        guard let tag = tags.first else {
            session.invalidate(errorMessage: "No NFC tag found")
            print("No tag found.")
            return
        }
        
        print(tags)
        print(tag)
        
        session.connect(to: tag) { error in
            if error != nil {
                session.invalidate(errorMessage: "Error connecting to NFC tag.")
                return
            }
            
            print("Connected to NFC tag")
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("Tag Session Invalidated.")
        
        // Check the invalidation reason from the returned error.
        if let readerError = error as? NFCReaderError {
            // Show an alert when the invalidation reason is not because of a
            // successful read during a single-tag read session, or because the
            // user canceled a multiple-tag read session from the UI or
            // programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                print(error.localizedDescription)
            }
        }
        
        // To read new tags, a new session instance is required.
        self.session = nil
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("Tag Session Active...")
        print(session)
    }
}
