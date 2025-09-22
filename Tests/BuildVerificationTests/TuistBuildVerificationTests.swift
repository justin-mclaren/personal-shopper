import XCTest
import Foundation

final class TuistBuildVerificationTests: XCTestCase {
    func testProjectGeneratesAndBuilds() throws {
        #if os(macOS)
        let root = repositoryRoot()

        guard commandExists("tuist", at: root) else {
            XCTFail("Tuist CLI is not installed or not available in PATH. Install Tuist to run build verification tests.")
            return
        }

        guard commandExists("xcodebuild", at: root) else {
            XCTFail("xcodebuild is not available. Install Xcode command line tools to run build verification tests.")
            return
        }

        let fileManager = FileManager.default
        let dependenciesManifest = root.appendingPathComponent("Tuist/Dependencies.swift").path
        if fileManager.fileExists(atPath: dependenciesManifest) {
            try runOrFail("tuist", arguments: ["install"], at: root)
        }

        try runOrFail("tuist", arguments: ["fetch"], at: root)
        try runOrFail("tuist", arguments: ["generate"], at: root)

        let workspacePath = root.appendingPathComponent("AIShopperBrowser.xcworkspace").path
        XCTAssertTrue(
            fileManager.fileExists(atPath: workspacePath),
            "Expected Tuist to generate a workspace at \(workspacePath)"
        )

        try runOrFail(
            "tuist",
            arguments: [
                "build",
                "--scheme", "AIShopperBrowser-Debug",
                "--skip-cache"
            ],
            at: root
        )
        #else
        throw XCTSkip("Build verification tests require macOS.")
        #endif
    }
}

// MARK: - Helpers

private func repositoryRoot(filePath: String = #filePath) -> URL {
    var url = URL(fileURLWithPath: filePath)
    for _ in 0..<3 {
        url.deleteLastPathComponent()
    }
    return url
}

@discardableResult
private func runOrFail(_ command: String, arguments: [String] = [], at directory: URL) throws -> CommandOutput {
    do {
        return try runCommand(command, arguments: arguments, at: directory)
    } catch {
        XCTFail("\(error)")
        throw error
    }
}

private func commandExists(_ command: String, at directory: URL) -> Bool {
    (try? runCommand("which", arguments: [command], at: directory)) != nil
}

private struct CommandOutput {
    let stdout: String
    let stderr: String
    let exitCode: Int32
}

private enum CommandError: Error, CustomStringConvertible {
    case failed(command: String, arguments: [String], output: CommandOutput)
    case launchFailed(command: String, arguments: [String], underlying: Error)

    var description: String {
        switch self {
        case let .failed(command, arguments, output):
            let invocation = ([command] + arguments).joined(separator: " ")
            return "Command `\(invocation)` exited with code \(output.exitCode).\nSTDOUT:\n\(output.stdout)\nSTDERR:\n\(output.stderr)"
        case let .launchFailed(command, arguments, underlying):
            let invocation = ([command] + arguments).joined(separator: " ")
            return "Failed to launch command `\(invocation)`: \(underlying)"
        }
    }
}

@discardableResult
private func runCommand(_ command: String, arguments: [String] = [], at directory: URL) throws -> CommandOutput {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = [command] + arguments
    process.currentDirectoryURL = directory
    process.environment = ProcessInfo.processInfo.environment

    let stdoutPipe = Pipe()
    let stderrPipe = Pipe()
    process.standardOutput = stdoutPipe
    process.standardError = stderrPipe

    do {
        try process.run()
    } catch {
        throw CommandError.launchFailed(command: command, arguments: arguments, underlying: error)
    }

    process.waitUntilExit()

    let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
    let stderrData = stderrPipe.fileHandleForReading.readDataToEndOfFile()

    let output = CommandOutput(
        stdout: String(data: stdoutData, encoding: .utf8) ?? "",
        stderr: String(data: stderrData, encoding: .utf8) ?? "",
        exitCode: process.terminationStatus
    )

    guard process.terminationStatus == 0 else {
        throw CommandError.failed(command: command, arguments: arguments, output: output)
    }

    return output
}
