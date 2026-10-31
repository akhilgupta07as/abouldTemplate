#!/usr/bin/env bash
set -e

echo "=================================================="
echo "  Abould ADA — Automated Test Suite Execution"
echo "=================================================="

START_TIME=$(date +%s)

if [ "$1" == "--coverage" ]; then
  echo "Running test suite with code coverage..."
  flutter test --coverage
else
  flutter test
fi

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo "--------------------------------------------------"
echo "  TEST RUN STATUS: PASSED"
echo "  Execution Duration: ${DURATION}s"
echo "=================================================="
