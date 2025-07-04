//
//  Combine+UIKit.swift
//  TripPlus
//
//  Created by 유대상 on 1/8/25.
//

import Foundation
import Combine
import UIKit

public protocol CombineCompatible {}

// MARK: - UIControl
public extension UIControl {
    final class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let input: Control

        public init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.input = input
            input.addTarget(self, action: #selector(eventHandler), for: event)
        }

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }

    struct Publisher<Output: UIControl>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never

        let output: Output
        let event: UIControl.Event

        public init(output: Output, event: UIControl.Event) {
            self.output = output
            self.event = event
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIControl: CombineCompatible {}

public extension CombineCompatible where Self: UIControl {
    func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
        .init(output: self, event: event)
    }
}

// MARK: - UIBarButtonItem
public extension UIBarButtonItem {
    final class Subscription<SubscriberType: Subscriber, Input: UIBarButtonItem>: Combine.Subscription where SubscriberType.Input == Input {
        private var subscriber: SubscriberType?
        private let input: Input

        public init(subscriber: SubscriberType, input: Input) {
            self.subscriber = subscriber
            self.input = input
            input.target = self
            input.action = #selector(eventHandler)
        }

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }

    struct Publisher<Output: UIBarButtonItem>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never

        let output: Output

        public init(output: Output) {
            self.output = output
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIBarButtonItem: CombineCompatible {
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }

    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }

    public convenience init(title: String?, style: UIBarButtonItem.Style, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }

    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }
}

public extension CombineCompatible where Self: UIBarButtonItem {
    var publisher: UIBarButtonItem.Publisher<UIBarButtonItem> {
        .init(output: self)
    }
}



// MARK: - UITapGestureRecognizer
public class GestureSubscription<S: Subscriber>: Subscription where S.Input == UITapGestureRecognizer {
    private var subscriber: S?
    private weak var gestureRecognizer: UITapGestureRecognizer?

    public init(subscriber: S, gestureRecognizer: UITapGestureRecognizer) {
        self.subscriber = subscriber
        self.gestureRecognizer = gestureRecognizer
        gestureRecognizer.addTarget(self, action: #selector(handleGesture))
    }

    public func request(_ demand: Subscribers.Demand) {}
    public func cancel() { subscriber = nil }

    @objc private func handleGesture() {
        guard let gesture = gestureRecognizer else { return }
        _ = subscriber?.receive(gesture)
    }
}

public struct GesturePublisher: Publisher {
    public typealias Output = UITapGestureRecognizer
    public typealias Failure = Never

    private let gestureRecognizer: UITapGestureRecognizer

    public init(gestureRecognizer: UITapGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, UITapGestureRecognizer == S.Input {
        let subscription = GestureSubscription(subscriber: subscriber, gestureRecognizer: gestureRecognizer)
        subscriber.receive(subscription: subscription)
    }
}

public extension UITapGestureRecognizer {
    var tapPublisher: GesturePublisher {
        return GesturePublisher(gestureRecognizer: self)
    }
}

