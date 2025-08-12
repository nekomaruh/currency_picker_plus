# Run tests
flutter test --coverage

# Generate report
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html

# Generate coverage badge
dart run test_coverage_badge --file ./coverage/lcov.info

