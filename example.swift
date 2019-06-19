/*
                     Copyright (c) 2019, Vuzix Corporation
                             All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 *  Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

 *  Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

 *  Neither the name of Vuzix Corporation nor the names of
    its contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.

     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */



/*
  This is a very simple example of how to use the connectivity framework for Vuzix smart glasses.
  This example is a basic chat app that can send text input to the glasses.  If glasses respond we can capture that text and display in our UITextView.
  Requires a UIViewController containing a UITextField for input, UITextView for reading, and
  a UIButton for sending the input.
  Also would need an Android app that responds to the intents running on the glasses, using the Android Connectivity lib (see https://www.vuzix.com/Developer/KnowledgeBase/Detail/1098)
 */


import UIKit
import VuzixConnectivity // Import Connectivity framework

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton:UIButton!
    
    
    let connectivity = Connectivity.shared
    
    private var isConnected = false {
        didSet {
            sendButton.isEnabled = isConnected
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        
        if connectivity.isConnected == false {
            // kick of a request to connect to glasses.
            connectivity.requestConnection()
        }
        else {
            self.textView.text = "--Connected to Blade!"
        }
        
        setupBroadcastReceivers()
        
        // Add observer of the Connectivity States and respond to them appropriately
        NotificationCenter.default.addObserver(forName: Connectivity.connectivityStateChanged, object: nil, queue: nil) { [weak self] (notification) in
            if let state = notification.userInfo?["state"] as? ConnectivityState {
                if state == ConnectivityState.connected {
                    self?.textView.text = "--Connected to Blade!"
                    isConnected = true
                    return
                }
                else if state == ConnectivityState.searchingForDevice {
                    self?.textView.text = "--Searching for Device"
                }
                else if state == ConnectivityState.connecting {
                    self?.textView.text = "--Connecting to Device"
                }
                isConnected = false
            }
        }
    }
    
    private func setupBroadcastReceivers() {
        
        // Add BroadcastReceivers to recieve response from glasses.
        let messageReceiver = BroadcastReceiver { [weak self] (intent: Intent) in
            if let message = intent.extras?.getValueForKey(key: "message") as? String {
                DispatchQueue.main.async {
                    let text = self?.textView.text ?? ""
                    self?.textView.text = "\(text)\n👓: \(message)"
                }
            }
        }
        connectivity.registerReceiver(intentAction: "com.vuzix.a3rdparty.action.MESSAGE", receiver: messageReceiver)
        
    }
    
    @IBAction func send(_ sender: Any) {
        
        guard connectivity.isConnected else {
            print("not connected")
            return
        }
        
        // Example of sending a broadcast intent to glasses.
        var intent = Intent(action: "com.vuzix.a3rdparty.action.MESSAGE")
        intent.addExtra(key: "message", value: textField.text ?? "")
        intent.package = "com.vuzix.a3rdparty"
        connectivity.broadcast(intent: intent)
        
        let text = textView.text ?? ""
        textView.text = "\(text)\n📱: \(textField.text ?? "")"
        
        textField.text = ""
    }
}


