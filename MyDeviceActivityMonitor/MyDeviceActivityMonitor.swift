//
//  MyDeviceActivityMonitor.swift
//  MyDeviceActivityMonitor
//
//  Created by Ipman on 22/05/2024.
//

import DeviceActivity
import SwiftUI

@main
struct MyDeviceActivityMonitor: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
