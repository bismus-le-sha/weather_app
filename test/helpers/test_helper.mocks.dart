// Mocks generated by Mockito 5.4.5 from annotations
// in weather_app/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i19;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i20;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i18;
import 'package:shared_preferences/shared_preferences.dart' as _i15;
import 'package:weather_app/core/error/failures.dart' as _i8;
import 'package:weather_app/core/service/periodic_weather_handler/periodic_weather_handler.dart'
    as _i14;
import 'package:weather_app/core/usecase/usecase.dart' as _i31;
import 'package:weather_app/core/util/network/network_info.dart' as _i16;
import 'package:weather_app/features/location/data/datasources/local_location_data_source.dart'
    as _i21;
import 'package:weather_app/features/location/data/datasources/remote_location_data_source.dart'
    as _i23;
import 'package:weather_app/features/location/data/models/location_model.dart'
    as _i22;
import 'package:weather_app/features/location/domain/entities/location.dart'
    as _i24;
import 'package:weather_app/features/location/domain/repositories/location_repository.dart'
    as _i6;
import 'package:weather_app/features/location/domain/usecases/add_favorite_location.dart'
    as _i27;
import 'package:weather_app/features/location/domain/usecases/get_favorite_location_list.dart'
    as _i30;
import 'package:weather_app/features/location/domain/usecases/get_location_list.dart'
    as _i25;
import 'package:weather_app/features/location/domain/usecases/params/favorite_location_params.dart'
    as _i28;
import 'package:weather_app/features/location/domain/usecases/params/location_params.dart'
    as _i26;
import 'package:weather_app/features/location/domain/usecases/remove_favorite_location.dart'
    as _i29;
import 'package:weather_app/features/weather/data/data_sources/local_data_source.dart'
    as _i11;
import 'package:weather_app/features/weather/data/data_sources/remote_data_source.dart'
    as _i10;
import 'package:weather_app/features/weather/data/models/weather_model.dart'
    as _i3;
import 'package:weather_app/features/weather/domain/entities/weather.dart'
    as _i9;
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart'
    as _i4;
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart'
    as _i12;
import 'package:weather_app/features/weather/domain/usecases/params/weater_params.dart'
    as _i13;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeWeatherModel_1 extends _i1.SmartFake implements _i3.WeatherModel {
  _FakeWeatherModel_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeWeatherRepository_2 extends _i1.SmartFake
    implements _i4.WeatherRepository {
  _FakeWeatherRepository_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDuration_5 extends _i1.SmartFake implements Duration {
  _FakeDuration_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeLocationRepository_6 extends _i1.SmartFake
    implements _i6.LocationRepository {
  _FakeLocationRepository_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i4.WeatherRepository {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>> getCurrentWeather(
    String? cityName,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getCurrentWeather, [cityName]),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>>.value(
                  _FakeEither_0<_i8.Failure, _i9.WeatherEntity>(
                    this,
                    Invocation.method(#getCurrentWeather, [cityName]),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>>);
}

/// A class which mocks [WeatherRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRemoteDataSource extends _i1.Mock
    implements _i10.WeatherRemoteDataSource {
  MockWeatherRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i3.WeatherModel> getCurrentWeather(String? cityName) =>
      (super.noSuchMethod(
            Invocation.method(#getCurrentWeather, [cityName]),
            returnValue: _i7.Future<_i3.WeatherModel>.value(
              _FakeWeatherModel_1(
                this,
                Invocation.method(#getCurrentWeather, [cityName]),
              ),
            ),
          )
          as _i7.Future<_i3.WeatherModel>);
}

/// A class which mocks [WeatherLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherLocalDataSource extends _i1.Mock
    implements _i11.WeatherLocalDataSource {
  MockWeatherLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<void> cacheWeather(String? cityName, _i3.WeatherModel? weather) =>
      (super.noSuchMethod(
            Invocation.method(#cacheWeather, [cityName, weather]),
            returnValue: _i7.Future<void>.value(),
            returnValueForMissingStub: _i7.Future<void>.value(),
          )
          as _i7.Future<void>);

  @override
  _i7.Future<_i3.WeatherModel> getLastWeather(String? cityName) =>
      (super.noSuchMethod(
            Invocation.method(#getLastWeather, [cityName]),
            returnValue: _i7.Future<_i3.WeatherModel>.value(
              _FakeWeatherModel_1(
                this,
                Invocation.method(#getLastWeather, [cityName]),
              ),
            ),
          )
          as _i7.Future<_i3.WeatherModel>);
}

/// A class which mocks [GetCurrentWeather].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCurrentWeather extends _i1.Mock implements _i12.GetCurrentWeather {
  MockGetCurrentWeather() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WeatherRepository get weatherRepository =>
      (super.noSuchMethod(
            Invocation.getter(#weatherRepository),
            returnValue: _FakeWeatherRepository_2(
              this,
              Invocation.getter(#weatherRepository),
            ),
          )
          as _i4.WeatherRepository);

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>> call(
    _i13.WeatherParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>>.value(
                  _FakeEither_0<_i8.Failure, _i9.WeatherEntity>(
                    this,
                    Invocation.method(#call, [params]),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, _i9.WeatherEntity>>);
}

/// A class which mocks [PeriodicWeatherUpdater].
///
/// See the documentation for Mockito's code generation for more information.
class MockPeriodicWeatherUpdater extends _i1.Mock
    implements _i14.PeriodicWeatherUpdater {
  MockPeriodicWeatherUpdater() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Stream<_i2.Either<_i8.Failure, _i9.WeatherEntity>> start(
    String? cityName,
    Duration? interval,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#start, [cityName, interval]),
            returnValue:
                _i7.Stream<_i2.Either<_i8.Failure, _i9.WeatherEntity>>.empty(),
          )
          as _i7.Stream<_i2.Either<_i8.Failure, _i9.WeatherEntity>>);

  @override
  void stop() => super.noSuchMethod(
    Invocation.method(#stop, []),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreferences extends _i1.Mock implements _i15.SharedPreferences {
  MockSharedPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> getKeys() =>
      (super.noSuchMethod(
            Invocation.method(#getKeys, []),
            returnValue: <String>{},
          )
          as Set<String>);

  @override
  Object? get(String? key) =>
      (super.noSuchMethod(Invocation.method(#get, [key])) as Object?);

  @override
  bool? getBool(String? key) =>
      (super.noSuchMethod(Invocation.method(#getBool, [key])) as bool?);

  @override
  int? getInt(String? key) =>
      (super.noSuchMethod(Invocation.method(#getInt, [key])) as int?);

  @override
  double? getDouble(String? key) =>
      (super.noSuchMethod(Invocation.method(#getDouble, [key])) as double?);

  @override
  String? getString(String? key) =>
      (super.noSuchMethod(Invocation.method(#getString, [key])) as String?);

  @override
  bool containsKey(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#containsKey, [key]),
            returnValue: false,
          )
          as bool);

  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(#getStringList, [key]))
          as List<String>?);

  @override
  _i7.Future<bool> setBool(String? key, bool? value) =>
      (super.noSuchMethod(
            Invocation.method(#setBool, [key, value]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> setInt(String? key, int? value) =>
      (super.noSuchMethod(
            Invocation.method(#setInt, [key, value]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> setDouble(String? key, double? value) =>
      (super.noSuchMethod(
            Invocation.method(#setDouble, [key, value]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> setString(String? key, String? value) =>
      (super.noSuchMethod(
            Invocation.method(#setString, [key, value]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> setStringList(String? key, List<String>? value) =>
      (super.noSuchMethod(
            Invocation.method(#setStringList, [key, value]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> remove(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#remove, [key]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> commit() =>
      (super.noSuchMethod(
            Invocation.method(#commit, []),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<bool> clear() =>
      (super.noSuchMethod(
            Invocation.method(#clear, []),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<void> reload() =>
      (super.noSuchMethod(
            Invocation.method(#reload, []),
            returnValue: _i7.Future<void>.value(),
            returnValueForMissingStub: _i7.Future<void>.value(),
          )
          as _i7.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i16.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected =>
      (super.noSuchMethod(
            Invocation.getter(#isConnected),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i5.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#head, [url], {#headers: headers}),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(#head, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#get, [url], {#headers: headers}),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(#get, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #post,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #post,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #put,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #put,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #patch,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #patch,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i17.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #delete,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #delete,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#read, [url], {#headers: headers}),
            returnValue: _i7.Future<String>.value(
              _i18.dummyValue<String>(
                this,
                Invocation.method(#read, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<String>);

  @override
  _i7.Future<_i19.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#readBytes, [url], {#headers: headers}),
            returnValue: _i7.Future<_i19.Uint8List>.value(_i19.Uint8List(0)),
          )
          as _i7.Future<_i19.Uint8List>);

  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
            Invocation.method(#send, [request]),
            returnValue: _i7.Future<_i5.StreamedResponse>.value(
              _FakeStreamedResponse_4(
                this,
                Invocation.method(#send, [request]),
              ),
            ),
          )
          as _i7.Future<_i5.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
    Invocation.method(#close, []),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [InternetConnection].
///
/// See the documentation for Mockito's code generation for more information.
class MockInternetConnection extends _i1.Mock
    implements _i20.InternetConnection {
  MockInternetConnection() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get enableStrictCheck =>
      (super.noSuchMethod(
            Invocation.getter(#enableStrictCheck),
            returnValue: false,
          )
          as bool);

  @override
  Duration get checkInterval =>
      (super.noSuchMethod(
            Invocation.getter(#checkInterval),
            returnValue: _FakeDuration_5(
              this,
              Invocation.getter(#checkInterval),
            ),
          )
          as Duration);

  @override
  _i7.Future<bool> get hasInternetAccess =>
      (super.noSuchMethod(
            Invocation.getter(#hasInternetAccess),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<_i20.InternetStatus> get internetStatus =>
      (super.noSuchMethod(
            Invocation.getter(#internetStatus),
            returnValue: _i7.Future<_i20.InternetStatus>.value(
              _i20.InternetStatus.connected,
            ),
          )
          as _i7.Future<_i20.InternetStatus>);

  @override
  _i7.Stream<_i20.InternetStatus> get onStatusChange =>
      (super.noSuchMethod(
            Invocation.getter(#onStatusChange),
            returnValue: _i7.Stream<_i20.InternetStatus>.empty(),
          )
          as _i7.Stream<_i20.InternetStatus>);

  @override
  void setIntervalAndResetTimer(Duration? duration) => super.noSuchMethod(
    Invocation.method(#setIntervalAndResetTimer, [duration]),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [LocalLocationDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalLocationDataSource extends _i1.Mock
    implements _i21.LocalLocationDataSource {
  MockLocalLocationDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<void> addFavoriteLocation(_i22.LocationModel? location) =>
      (super.noSuchMethod(
            Invocation.method(#addFavoriteLocation, [location]),
            returnValue: _i7.Future<void>.value(),
            returnValueForMissingStub: _i7.Future<void>.value(),
          )
          as _i7.Future<void>);

  @override
  _i7.Future<List<_i22.LocationModel>> getFavoriteLocationList() =>
      (super.noSuchMethod(
            Invocation.method(#getFavoriteLocationList, []),
            returnValue: _i7.Future<List<_i22.LocationModel>>.value(
              <_i22.LocationModel>[],
            ),
          )
          as _i7.Future<List<_i22.LocationModel>>);

  @override
  _i7.Future<void> removeFavoriteLocation(_i22.LocationModel? location) =>
      (super.noSuchMethod(
            Invocation.method(#removeFavoriteLocation, [location]),
            returnValue: _i7.Future<void>.value(),
            returnValueForMissingStub: _i7.Future<void>.value(),
          )
          as _i7.Future<void>);
}

/// A class which mocks [RemoteLocationDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteLocationDataSource extends _i1.Mock
    implements _i23.RemoteLocationDataSource {
  MockRemoteLocationDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i22.LocationModel>> getLocationList(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#getLocationList, [query]),
            returnValue: _i7.Future<List<_i22.LocationModel>>.value(
              <_i22.LocationModel>[],
            ),
          )
          as _i7.Future<List<_i22.LocationModel>>);
}

/// A class which mocks [LocationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationRepository extends _i1.Mock
    implements _i6.LocationRepository {
  MockLocationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>
  getListLocation(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#getListLocation, [query]),
            returnValue: _i7.Future<
              _i2.Either<_i8.Failure, List<_i24.LocationEntity>>
            >.value(
              _FakeEither_0<_i8.Failure, List<_i24.LocationEntity>>(
                this,
                Invocation.method(#getListLocation, [query]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>
  getFavoritestLocationList() =>
      (super.noSuchMethod(
            Invocation.method(#getFavoritestLocationList, []),
            returnValue: _i7.Future<
              _i2.Either<_i8.Failure, List<_i24.LocationEntity>>
            >.value(
              _FakeEither_0<_i8.Failure, List<_i24.LocationEntity>>(
                this,
                Invocation.method(#getFavoritestLocationList, []),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, void>> addFavoritestLocation(
    _i22.LocationModel? location,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#addFavoritestLocation, [location]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, void>>.value(
              _FakeEither_0<_i8.Failure, void>(
                this,
                Invocation.method(#addFavoritestLocation, [location]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, void>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, void>> removeFavoritestLocation(
    _i22.LocationModel? location,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#removeFavoritestLocation, [location]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, void>>.value(
              _FakeEither_0<_i8.Failure, void>(
                this,
                Invocation.method(#removeFavoritestLocation, [location]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, void>>);
}

/// A class which mocks [GetLocationList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLocationList extends _i1.Mock implements _i25.GetLocationList {
  MockGetLocationList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.LocationRepository get locationRepository =>
      (super.noSuchMethod(
            Invocation.getter(#locationRepository),
            returnValue: _FakeLocationRepository_6(
              this,
              Invocation.getter(#locationRepository),
            ),
          )
          as _i6.LocationRepository);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>> call(
    _i26.LocationParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue: _i7.Future<
              _i2.Either<_i8.Failure, List<_i24.LocationEntity>>
            >.value(
              _FakeEither_0<_i8.Failure, List<_i24.LocationEntity>>(
                this,
                Invocation.method(#call, [params]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>);
}

/// A class which mocks [AddFavoriteLocation].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddFavoriteLocation extends _i1.Mock
    implements _i27.AddFavoriteLocation {
  MockAddFavoriteLocation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.LocationRepository get locationRepository =>
      (super.noSuchMethod(
            Invocation.getter(#locationRepository),
            returnValue: _FakeLocationRepository_6(
              this,
              Invocation.getter(#locationRepository),
            ),
          )
          as _i6.LocationRepository);

  @override
  _i7.Future<_i2.Either<_i8.Failure, void>> call(
    _i28.FavoriteLocationParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, void>>.value(
              _FakeEither_0<_i8.Failure, void>(
                this,
                Invocation.method(#call, [params]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, void>>);
}

/// A class which mocks [RemoveFavoriteLocation].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveFavoriteLocation extends _i1.Mock
    implements _i29.RemoveFavoriteLocation {
  MockRemoveFavoriteLocation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.LocationRepository get locationRepository =>
      (super.noSuchMethod(
            Invocation.getter(#locationRepository),
            returnValue: _FakeLocationRepository_6(
              this,
              Invocation.getter(#locationRepository),
            ),
          )
          as _i6.LocationRepository);

  @override
  _i7.Future<_i2.Either<_i8.Failure, void>> call(
    _i28.FavoriteLocationParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, void>>.value(
              _FakeEither_0<_i8.Failure, void>(
                this,
                Invocation.method(#call, [params]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, void>>);
}

/// A class which mocks [GetFavoriteLocationList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoriteLocationList extends _i1.Mock
    implements _i30.GetFavoriteLocationList {
  MockGetFavoriteLocationList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.LocationRepository get locationRepository =>
      (super.noSuchMethod(
            Invocation.getter(#locationRepository),
            returnValue: _FakeLocationRepository_6(
              this,
              Invocation.getter(#locationRepository),
            ),
          )
          as _i6.LocationRepository);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>> call(
    _i31.NoParams? params,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#call, [params]),
            returnValue: _i7.Future<
              _i2.Either<_i8.Failure, List<_i24.LocationEntity>>
            >.value(
              _FakeEither_0<_i8.Failure, List<_i24.LocationEntity>>(
                this,
                Invocation.method(#call, [params]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i24.LocationEntity>>>);
}
