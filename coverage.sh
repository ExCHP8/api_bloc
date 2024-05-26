#!/bin/sh

# Run tests with coverage
flutter test --coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open the report in the default browser
open coverage/html/index.html