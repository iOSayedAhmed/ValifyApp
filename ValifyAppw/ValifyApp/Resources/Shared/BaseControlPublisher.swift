//
//  BaseControlPublisher.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import Foundation
import Combine
import UIKit

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }

    func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}

struct UIControlPublisher<Control: UIControl>: Publisher {

    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

enum GestureType {
    case tap(UITapGestureRecognizer = .init())
    case swipe(UISwipeGestureRecognizer = .init())
    case longPress(UILongPressGestureRecognizer = .init())
    case pan(UIPanGestureRecognizer = .init())
    case pinch(UIPinchGestureRecognizer = .init())
    case edge(UIScreenEdgePanGestureRecognizer = .init())
    
    func get() -> UIGestureRecognizer {
        switch self {
        case let .tap(tapGesture):
            return tapGesture
        case let .swipe(swipeGesture):
            return swipeGesture
        case let .longPress(longPressGesture):
            return longPressGesture
        case let .pan(panGesture):
            return panGesture
        case let .pinch(pinchGesture):
            return pinchGesture
        case let .edge(edgePanGesture):
            return edgePanGesture
        }
    }
}

struct GesturePublisher: Publisher {
    typealias Output = GestureType
    typealias Failure = Never
    private let view: UIView
    private let gestureType: GestureType
    
    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, GesturePublisher.Failure == S.Failure, GesturePublisher.Output == S.Input {
        let subscription = GestureSubscription(
            subscriber: subscriber,
            view: view,
            gestureType: gestureType
        )
        subscriber.receive(subscription: subscription)
    }
}

class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
    private var subscriber: S?
    private var gestureType: GestureType
    private var view: UIView
    
    init(subscriber: S, view: UIView, gestureType: GestureType) {
        self.subscriber = subscriber
        self.view = view
        self.gestureType = gestureType
        configureGesture(gestureType)
    }
    
    private func configureGesture(_ gestureType: GestureType) {
        let gesture = gestureType.get()
        gesture.addTarget(self, action: #selector(handler))
        view.addGestureRecognizer(gesture)
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc
    private func handler() {
        _ = subscriber?.receive(gestureType)
    }
}

extension UIStackView {
    func stackGesture(_ gestureType: GestureType = .tap()) ->
    GesturePublisher {
        .init(view: self, gestureType: gestureType)
    }
}
