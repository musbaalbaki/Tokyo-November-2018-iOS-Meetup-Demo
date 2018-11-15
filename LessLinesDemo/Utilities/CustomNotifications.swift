//
//  CustomNotifications.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation

let center = NotificationCenter.default

struct NotificationDescriptor<A> {
    let name: Notification.Name
    let convert: (Notification) -> A
}

struct CustomNotificationDescriptor<A> {
    let name: Notification.Name
}

class Token {
    let token: NSObjectProtocol
    let center: NotificationCenter
    init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }
    
    deinit {
        center.removeObserver(token)
    }
}

extension NotificationCenter {
    func addObserver<A>(descriptor: NotificationDescriptor<A>, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil, using: { note in
            block(descriptor.convert(note))
        })
        return Token(token: token, center: self)
    }
    
    func addObserver<A>(descriptor: CustomNotificationDescriptor<A>, queue: OperationQueue? = nil, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: queue, using: { note in
            block(note.object as! A)
        })
        return Token(token: token, center: self)
    }
    
    func post<A>(descriptor: CustomNotificationDescriptor<A>, value: A) {
        post(name: descriptor.name, object: value)
    }
}
