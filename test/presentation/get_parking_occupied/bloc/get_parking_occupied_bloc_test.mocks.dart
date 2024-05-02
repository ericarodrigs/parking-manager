// Mocks generated by Mockito 5.4.4 from annotations
// in parking_manager/test/presentation/get_parking_occupied/bloc/get_parking_occupied_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:parking_manager/parking_manager/domain/entities/parking_entity.dart'
    as _i6;
import 'package:parking_manager/parking_manager/domain/repositories/parking_repository.dart'
    as _i3;
import 'package:parking_manager/shared/errors/failure.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ParkingRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockParkingRepository extends _i1.Mock implements _i3.ParkingRepository {
  MockParkingRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>> getHistory(
          String? dateSearch) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHistory,
          [dateSearch],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.ParkingEntity>>(
          this,
          Invocation.method(
            #getHistory,
            [dateSearch],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>>
      getParkingOccupied() => (super.noSuchMethod(
            Invocation.method(
              #getParkingOccupied,
              [],
            ),
            returnValue: _i4
                .Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.ParkingEntity>>(
              this,
              Invocation.method(
                #getParkingOccupied,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ParkingEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> registerParking(
          _i6.ParkingEntity? parkingEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerParking,
          [parkingEntity],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #registerParking,
            [parkingEntity],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> updateParking(
          _i6.ParkingEntity? parkingEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateParking,
          [parkingEntity],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #updateParking,
            [parkingEntity],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
