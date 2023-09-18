//
//  NFCNDFEReader.swift
//  NFCWallet
//
//  Created by Imran Hajiyev on 17.09.23.
//

import CoreNFC

class NFCNDFEReader: NSObject, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    
    func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("This device doesn't support tag scanning")
            return
        }

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near the card. NDFE Scanning."
        session?.begin()
    }
    
    func stopScanning() {
        session?.invalidate()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print(messages)
        print(messages.isEmpty)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NDFE Session Invalidated.")
        
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
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("NDFE Session Active...")
        print(session)
    }
}
