//
//  HandlerErrors.swift
//  Runner
//
//  Created by Juan Diego Fajardo on 7/15/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

enum SpotifyPluginErrorCode: String {
    case args = "ARGS" // Arguments from method channel call
    case keyCast = "KEY_CAST" // If method channel args = Dict, key error OR key unpacking error
    case sdk = "SDK" // Error from SPT SDK
    case sdkResultUnpacking = "SDK_RESULT_UNPACKING" // Error unpacking sdk result
    case valueCast = "VALUE_CAST" // Error casting values in order to use them
}

func argsErrorForCall(_ call: FlutterMethodCall) -> FlutterError {
    let message = "Incorrect argument(s) for method \(call.method)."
    return flutterErrorWithCode(.args, message: message)
}

func keyCastError(_ key: String, expectedType: Any.Type) -> FlutterError {
    let message = "Error while extracting key \(key) and casting to type \(expectedType)."
    return flutterErrorWithCode(.keyCast, message: message)
}

func sdkError(_ underlyingError: Error) -> FlutterError {
    let message = "SDK Error: \(underlyingError.localizedDescription)"
    return flutterErrorWithCode(.sdk, message: message)
}

func unavailableSdkValueError(_ value: String) -> FlutterError {
    let message = "SDK Error: Value \(value) is unavailable."
    return flutterErrorWithCode(.sdk, message: message)
}

func customSdkErrorWithMessage(_ message: String) -> FlutterError {
    let detailedMessage = "SDK Error: \(message)"
    return flutterErrorWithCode(.sdk, message: detailedMessage)
}

func sdkResultUnpackingError(expectedType: Any.Type) -> FlutterError {
    let message = "Error while unpacking sdkResult to type \(expectedType)."
    return flutterErrorWithCode(.sdkResultUnpacking, message: message)
}

func valueCastError(_ variableName: String, expectedType: Any.Type) -> FlutterError {
    let message = "Error while casting \(variableName) to type \(expectedType)."
    return flutterErrorWithCode(.keyCast, message: message)
}


func flutterErrorWithCode(_ code: SpotifyPluginErrorCode, message: String?, details: Any? = nil) -> FlutterError {
    return FlutterError(code: code.rawValue, message: message, details: details)
}
