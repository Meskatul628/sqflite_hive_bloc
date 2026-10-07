import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:bloc_test_demo/features/home/domin/usecash/signin_useca.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_event.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 1. Mocking: আমরা SigninUseca-এর একটি ডামি/মক তৈরি করব
class MockSigninUseca extends Mock implements SigninUseca {}

void main() {
  late MockSigninUseca mockSigninUseca;
  late SignInBloc signInBloc;

  // setUp() প্রতিটা টেস্ট চলার আগে একবার করে এক্সিকিউট হয় (Clean state রাখার জন্য)
  setUp(() {
    mockSigninUseca = MockSigninUseca();
    signInBloc = SignInBloc(signinUseca: mockSigninUseca);
  });

  // tearDown() প্রতিটা টেস্ট শেষে BLoC ক্লোজ করার জন্য
  tearDown(() {
    signInBloc.close();
  });

  group('SignInBloc Unit Tests', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testParams = SignInPrams(email: testEmail, password: testPassword);

    final testResponse = SignInResponse(
      statusCode: 200,
      success: true,
      message: 'Login Successful',
    );

    // টেস্ট ১: ইনিশিয়াল স্টেট ঠিক আছে কিনা
    test('প্রাথমিক স্টেট (initial state) SignInInitail হওয়া উচিত', () {
      expect(signInBloc.state, equals(const SignInInitail()));
    });

    // টেস্ট ২: সফল লগইনের ফ্লো (blocTest ব্যবহার করে)
    blocTest<SignInBloc, SignInState>(
      'লগইন সফল হলে [SignInLoading, SingInsuscess] স্টেট আসবে',
      build: () {
        // Arrange: মক ইউজকেস কী রিটার্ন করবে তা ঠিক করে দেওয়া
        when(() => mockSigninUseca(testParams))
            .thenAnswer((_) async => Right(testResponse));
        return signInBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(
        email: testEmail,
        password: testPassword,
      )),
      expect: () => [
        const SignInLoading(),
        SingInsuscess(signInResponse: testResponse),
      ],
      verify: (_) {
        // নিশ্চিত হওয়া যে ইউজকেসটি ঠিক প্যারামিটার দিয়ে ঠিক ১ বার কল হয়েছে
        verify(() => mockSigninUseca(testParams)).called(1);
      },
    );

    // টেস্ট ৩: লগইন ব্যর্থ হওয়ার ফ্লো (Failure)
    blocTest<SignInBloc, SignInState>(
      'লগইন ব্যর্থ হলে [SignInLoading, SignInFailure] স্টেট আসবে',
      build: () {
        // Arrange: সার্ভার এরর রিটার্ন করানো
        when(() => mockSigninUseca(testParams))
            .thenAnswer((_) async => Left(ServerFailure(message: 'Invalid credentials')));
        return signInBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(
        email: testEmail,
        password: testPassword,
      )),
      expect: () => [
        const SignInLoading(),
        const SignInFailure(message: 'Invalid credentials'),
      ],
      verify: (_) {
        verify(() => mockSigninUseca(testParams)).called(1);
      },
    );
  });
}
