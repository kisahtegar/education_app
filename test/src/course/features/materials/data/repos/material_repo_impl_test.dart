import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_src.dart';
import 'package:education_app/src/course/features/materials/data/models/resource_model.dart';
import 'package:education_app/src/course/features/materials/data/repos/material_repo_impl.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMaterialRemoteDataSrc extends Mock implements MaterialRemoteDataSrc {}

void main() {
  late MaterialRemoteDataSrc remoteDataSource;
  late MaterialRepoImpl repoImpl;

  final tResource = ResourceModel.empty();

  setUp(() {
    remoteDataSource = MockMaterialRemoteDataSrc();
    repoImpl = MaterialRepoImpl(remoteDataSource);
    registerFallbackValue(tResource);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('addMaterial', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSource.addMaterial(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.addMaterial(tResource);

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSource.addMaterial(tResource)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.addMaterial(any())).thenThrow(tException);

        final result = await repoImpl.addMaterial(tResource);

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );

        verify(() => remoteDataSource.addMaterial(tResource)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getMaterials', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSource.getMaterials(any())).thenAnswer(
          (_) async => [tResource],
        );

        final result = await repoImpl.getMaterials('courseId');

        expect(result, isA<Right<dynamic, List<Resource>>>());

        verify(() => remoteDataSource.getMaterials('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.getMaterials(any())).thenThrow(tException);

        final result = await repoImpl.getMaterials('courseId');

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );

        verify(() => remoteDataSource.getMaterials('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
