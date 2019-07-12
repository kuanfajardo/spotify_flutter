import 'package:flutter/services.dart';

abstract class Codecable {
  Map<String, dynamic> encode();
  static Codecable decode(Map<String, dynamic> codecResult) => null;
}

class Decoder {
  // Invariant: Keys to _decoders have to be types that implement Codecable
  Map<Type, Function> _decoders = {};

  static Decoder instance = Decoder._();

  Decoder._();

  // Ideally, we would write T extends Codecable, but (1) that would stop us 
  // from being able to use invokeListMethod to call both 
  // _invokeListMethodBuiltIn and _invokeListMethodCustom from same function;
  // and (2) _decoders invariant guarantees keys are Codecable
  T decode<T>(Map<String, dynamic> codecResult) {
    return this._decoders[T](codecResult);
  }

  void registerCodecable<T extends Codecable>(Codecable decoder(Map<String,
      dynamic> codecResult)) {
    this._decoders[T] = decoder;
  }

  bool canDecodeCustomType(Type t) {
    return instance._decoders.containsKey(t);
  }

  bool canDecodeBuiltInType(Type t) {
    // For StandardMessageCodec; Note: other types are supported, just not used
    // by this API
    List<Type> supportedTypes = [bool, double, int, num, Null,];
    return supportedTypes.contains(t);
  }
}

const MethodChannel _channel = const MethodChannel('spotify');

Future<T> invokeMethod<T>(String methodName, [dynamic args]) async {
  if (T == List) {
    throw ArgumentError.value(T, 'T (expected type of channel method call)',
        'Use the invokeListMethod() function to get a typed List from a '
            'platform channel method call.');
  }

  if (T == Map) {
    throw ArgumentError.value(T, 'T (expected type of channel method call)',
        'Define a custom class that extends Codecable rather than using a Map '
            'with platform channels.');
  }

  // Built-In
  if (Decoder.instance.canDecodeBuiltInType(T)) {
    return _invokeMethodBuiltIn<T>(methodName, args);
  }

  // Custom, Codecable, AND registered
  if (Decoder.instance.canDecodeCustomType(T)) {
    return _invokeMethodCustom<T>(methodName, args);
  }

  // Custom, not registered
  throw ArgumentError.value(T, 'T (expected type of channel method call)',
      'Either T is not Codecable, or you forgot to register T with the '
          'Decoder. See [Codecable] or [Decoder.registerCodecable()]');
}

Future<List<T>> invokeListMethod<T>(String methodName,
    [dynamic args]) async {
  // Built-In
  if (Decoder.instance.canDecodeBuiltInType(T)) {
    return _invokeListMethodBuiltIn<T>(methodName, args);
  }

  // Custom, Codecable, AND registered
  if (Decoder.instance.canDecodeCustomType(T)) {
    return _invokeListMethodCustom<T>(methodName, args);
  }

  // Custom, not registered
  throw ArgumentError.value(T, 'T (expected type of channel method call)',
      'Either T is not Codecable, or you forgot to register T with the '
          'Decoder. See [Codecable] or [Decoder.registerCodecable()]');
}

Future<T> _invokeMethodBuiltIn<T>(String methodName, [dynamic args])
async {
  return await _channel.invokeMethod<T>(methodName, args);
}

Future<T> _invokeMethodCustom<T>(String methodName, [dynamic args])
async {
  Map codecResult = await _channel.invokeMethod<Map>(methodName, args);
  return Decoder.instance.decode<T>(codecResult as Map<String, dynamic>);
}

Future<List<T>> _invokeListMethodBuiltIn<T>(String methodName, [dynamic args])
async {
  return await _channel.invokeListMethod<T>(methodName, args);
}

Future<List<T>> _invokeListMethodCustom<T>(String methodName, [dynamic args])
async {
  List<Map> codecResult = await _channel.invokeListMethod<Map>(methodName,
      args);
  return codecResult.map((Map elt) {
    return Decoder.instance.decode<T>(elt as Map<String, dynamic>);
  }).toList();
}