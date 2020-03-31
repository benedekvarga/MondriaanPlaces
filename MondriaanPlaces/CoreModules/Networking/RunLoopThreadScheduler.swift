//
//  RunLoopThreadScheduler.swift
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation
import RxSwift

final class RunLoopThreadScheduler: ImmediateSchedulerType {
    private let thread: Thread
    private let target: ThreadTarget

    init(threadName: String) {
        self.target = ThreadTarget()
        self.thread = Thread(target: target, selector: #selector(ThreadTarget.threadEntryPoint), object: nil)
        self.thread.name = threadName
        self.thread.start()
    }

    deinit {
        thread.cancel()
    }

    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        let disposable = SingleAssignmentDisposable()
        var action: Action? = Action {
            guard !disposable.isDisposed else {
                return
            }
            disposable.setDisposable(action(state))
        }
        action?.perform(#selector(Action.performAction), on: thread, with: nil, waitUntilDone: false, modes: [RunLoop.Mode.default.rawValue])
        let actionDisposable = Disposables.create {
            action = nil
        }
        return Disposables.create(disposable, actionDisposable)
    }
}

private final class ThreadTarget: NSObject {
    @objc
    func threadEntryPoint() {
        let runLoop = RunLoop.current
        runLoop.add(Port(), forMode: .common)
        runLoop.run()
    }
}

private final class Action: NSObject {
    private let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    @objc
    func performAction() {
        action()
    }
}
