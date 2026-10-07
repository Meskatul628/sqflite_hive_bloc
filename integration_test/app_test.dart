import 'package:bloc_test_demo/features/home/widget/app_button.dart';
import 'package:bloc_test_demo/features/home/widget/app_text_field.dart';
import 'package:bloc_test_demo/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // ১. Integration Test বাইন্ডিং ইনিশিয়ালাইজ করা
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End (E2E) Login Flow Integration Test', () {
    testWidgets('লগইন ফ্লো স্বয়ংক্রিয়ভাবে টাইপ করে বাটনে ক্লিক করবে',
        (WidgetTester tester) async {
      // ২. পুরো অ্যাপকে শুরু করা (main.dart যেভাবে চলে)
      app.main();

      // ফ্রেম এবং ডিপেনডেন্সি রেন্ডার হওয়া পর্যন্ত অপেক্ষা করা
      await tester.pumpAndSettle();

      // ৩. ভেরিফাই করা যে অ্যাপ ওপেন হয়েছে এবং ফিল্ডগুলো আছে
      final textFields = find.byType(AppTextFormField);
      expect(textFields, findsNWidgets(2));
      expect(find.byType(AppButton), findsOneWidget);

      // ৪. অটোমেটেড ইউজার ইন্টারঅ্যাকশন:
      // ইমেইল টেক্সট ফিল্ডে ইমেইল টাইপ করা
      await tester.enterText(textFields.at(0), 'user@test.com');
      await tester.pumpAndSettle();

      // পাসওয়ার্ড টেক্সট ফিল্ডে পাসওয়ার্ড টাইপ করা
      await tester.enterText(textFields.at(1), 'password123');
      await tester.pumpAndSettle();

      // ৫. 'Log In' বাটনে ক্লিক/ট্যাপ করা
      final loginButton = find.text('Log In');
      await tester.tap(loginButton);

      // ফ্রেম আপডেট করা (রিকোয়েস্ট প্রসেস হওয়া পর্যন্ত অপেক্ষা)
      await tester.pump();

      // ৬. নিশ্চিত হওয়া যে ইউজার বাটনে ক্লিক করার পর অ্যাপ ক্র্যাশ করেনি এবং স্টেবল রয়েছে
      expect(find.byType(app.MyApp), findsOneWidget);
    });
  });
}
