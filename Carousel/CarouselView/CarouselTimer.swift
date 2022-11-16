//
//  CarouselTimer.swift
//  Alarm
//
//  Created by Joey Zhang on 2022/11/15.
//

import Foundation

class CarouselTimer {
    private var timer: Timer?
    private var tick: Int
    private var tickAction: ((Int) -> ())?

    init() {
        self.timer = nil
        self.tick = 0
        self.tickAction = nil
    }

    func start(interval: TimeInterval) {
        timer = Timer.scheduledTimer(
            timeInterval: interval,
            target: self,
            selector: #selector(timerDidFire(_:)),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: .tracking)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        tick = 0
    }

    func onTick(action: @escaping (Int) -> ()) {
        tickAction = action
    }

    @objc private func timerDidFire(_ timer: Timer) {
        tick += 1
        tickAction?(tick)
    }
}
