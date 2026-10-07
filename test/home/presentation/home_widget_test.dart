import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_event.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_state.dart';
import 'package:bloc_test_demo/features/home/presentation/home.dart';
import 'package:bloc_test_demo/features/home/widget/app_button.dart';
import 'package:bloc_test_demo/features/home/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// UI টেস্টের জন্য আমরা BLoC-কে Mock করব যাতে UI-তে ইচ্ছামতো স্টেট পাঠাতে পারি
class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  late MockSignInBloc mockSignInBloc;

  setUp(() {
    mockSignInBloc = MockSignInBloc();
  });

  // টেস্টের জন্য হেল্পার উইজেট (যাতে BlocProvider এবং MaterialApp থাকে)
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<SignInBloc>.value(
        value: mockSignInBloc,
        child: Home(),
      ),
    );
  }

  group('Home Screen Widget Tests', () {
    // টেস্ট ১: স্ক্রিনে প্রাথমিক সব উইজেট দেখা যাচ্ছে কিনা
    testWidgets('ইমেইল ফিল্ড, পাসওয়ার্ড ফিল্ড এবং লগইন বাটন রেন্ডার হওয়া উচিত',
        (WidgetTester tester) async {
      // BLoC এর প্রাথমিক স্টেট ইনিশিয়াল রাখা হলো
      when(() => mockSignInBloc.state).thenReturn(const SignInInitail());

      // tester.pumpWidget দিয়ে উইজেট স্ক্রিনে রেন্ডার করা হলো
      await tester.pumpWidget(createWidgetUnderTest());

      // যাচাই করা হচ্ছে যে ২টা টেক্সট ফিল্ড ও ১টা বাটন আছে
      expect(find.byType(AppTextFormField), findsNWidgets(2));
      expect(find.text('Log In'), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });

    // টেস্ট ২: ইউজার ইনপুট দিলে এবং লগইন বাটনে ট্যাপ করলে BLoC-এ ইভেন্ট যায় কিনা
    testWidgets('ইমেইল ও পাসওয়ার্ড লিখে বাটনে ট্যাপ করলে LoginEvent ট্রিগার হয়',
        (WidgetTester tester) async {
      when(() => mockSignInBloc.state).thenReturn(const SignInInitail());

      await tester.pumpWidget(createWidgetUnderTest());

      // ১. টেক্সট ফিল্ডগুলোতে লেখা টাইপ করা
      final textFields = find.byType(AppTextFormField);
      await tester.enterText(textFields.at(0), 'user@test.com');
      await tester.enterText(textFields.at(1), 'secret123');

      // ২. 'Log In' বাটনে ট্যাপ করা
      await tester.tap(find.text('Log In'));
      await tester.pump(); // ফ্রেম আপডেট করার জন্য

      // ৩. ভেরিফাই করা যে BLoC-এ সঠিক ডেটা সহ LoginEvent পাঠানো হয়েছে
      verify(() => mockSignInBloc.add(
            const LoginEvent(
              email: 'user@test.com',
              password: 'secret123',
            ),
          )).called(1);
    });

    // টেস্ট ৩: স্টেট যখন SignInLoading, তখন UI-তে CircularProgressIndicator দেখানো উচিত
    testWidgets('SignInLoading স্টেটে লোডিং ইন্ডিকেটর দেখা যাওয়া উচিত',
        (WidgetTester tester) async {
      when(() => mockSignInBloc.state).thenReturn(const SignInLoading());

      await tester.pumpWidget(createWidgetUnderTest());

      // স্ক্রিনে CircularProgressIndicator দৃশ্যমান কিনা তা যাচাই
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // টেস্ট ৪: স্টেট যখন SingInsuscess, তখন সফল মেসেজ দেখানো উচিত
    testWidgets('SingInsuscess স্টেটে সফল মেসেজ স্ক্রিনে দেখানো উচিত',
        (WidgetTester tester) async {
      final successResponse = SignInResponse(
        statusCode: 200,
        message: 'স্বাগতম!',
        data: Data(user: User(email: 'user@test.com')),
      );

      when(() => mockSignInBloc.state).thenReturn(
        SingInsuscess(signInResponse: successResponse),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // স্ক্রিনে মেসেজ ও ইমেইল দেখা যাচ্ছে কিনা তা যাচাই
      expect(find.text('Message: স্বাগতম!'), findsOneWidget);
      expect(find.text('user@test.com'), findsOneWidget);
    });
  });
}
