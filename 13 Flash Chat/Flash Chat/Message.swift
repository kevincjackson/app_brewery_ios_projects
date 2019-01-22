//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

class Message {
    
    var sender = ""
    var messageBody = ""

    init(messageBody: String, sender: String) {
        self.messageBody = messageBody
        self.sender = sender
    }
}
