# rent-asst-test-results

Archive of automated UI test results for the RentAsst mobile app (Patrol tests run on Xcode Cloud). Results are committed here automatically after each run; this repo contains no application code.

## Layout

```
<platform>/<date>/<run>/
├── allure-results/     # raw Allure result files (input for reports)
├── results.xcresult/   # Xcode result bundle
└── meta.json           # run metadata
```

Example: `ios/2026-10-28/20261028_053339_b29/`

`meta.json` records the platform, run id, date, device/OS, branch, commit, workflow, build number, and the total/failed test counts.

## Generating Allure reports

Requires the [Allure CLI](https://allurereport.org/docs/) on your `PATH`.

```bash
bash generate_reports.sh
```

This runs `allure generate <run>/allure-results -o allure_reports/<platform>/<date>/<run> --clean` for every run, so each run gets its own report, e.g. `allure_reports/ios/2026-10-28/20261028_053339_b29`.

To open one report:

```bash
allure open allure_reports/ios/2026-10-28/20261028_053339_b29
```

## Related

Tests and the CI workflow live in the `RentalMobile` repo (`patrol_test/`, `ios/ci_scripts/`).
