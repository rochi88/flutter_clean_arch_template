.PHONY: all run_dev_web run_dev_mobile run_unit clean upgrade lint format build_dev_mobile help watch gen run_stg_mobile run_prd_mobile build_apk_dev build_apk_stg build_apk_prd build_bundle purge run_debug run_profile run_staging_linux run_staging_web run_staging_mobile run_qa_mobile build_apk_staging build_apk_qa build_apk_prod build_apk all_debug all_profile

all_debug: lint format run_debug

all_profile: lint format run_profile

# Adding a help file: https://gist.github.com/prwhite/8168133#gistcomment-1313022
help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

run_unit: ## Runs unit tests
	@echo "╠ Running the tests"
	@flutter test || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@dart run build_runner clean
	@flutter clean
	@flutter pub get

watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@dart run build_runner watch --delete-conflicting-outputs

build: ## Build the files for changes
	@echo "╠ Building the project..."
	@dart run build_runner build --delete-conflicting-outputs

gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@flutter pub get
	@dart run packages pub run build_runner build
	@dart run flutter_native_splash:create
	@dart run flutter_launcher_icons:main

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@dart run import_sorter:main

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	@git add .
	@git commit

run_debug:
	@flutter run --debug

run_profile:
	@flutter run --profile

run_staging_linux: ## Runs the mobile application in linux
	@flutter run -d linux -t lib/main_staging.dart

run_staging_web: ## Runs the web application in staging
	@echo "╠ Running the app"
	@flutter run -d chrome --dart-define=ENVIRONMENT=staging -t lib/main_staging.dart

run_staging_mobile: ## Runs the mobile application in staging
	@echo "╠ Running the app"
	@flutter run --flavor staging -t lib/main_staging.dart

run_qa_mobile: ## Runs the mobile application in qa
	@echo "╠ Running the app"
	@flutter run --flavor qa -t lib/main_qa.dart

run_prd_mobile: ## Runs the mobile application in prod
	@echo "╠ Running the app"
	@flutter run --flavor production -t lib/main.dart

build_apk_staging: ## Builds the mobile application in staging
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor staging -t lib/main_staging.dart

build_apk_qa: ## Builds the mobile application in staging
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor staging -t lib/main_qa.dart

build_apk_prod: ## Builds the mobile application in prod
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor production -t lib/main.dart

build_apk: ## Builds the mobile application in prod for distribution
	@flutter clean
	@flutter pub get
	@flutter build apk --release --obfuscate --split-debug-info=build/app/symbols

build_bundle: ## Builds the mobile application in prod for distribution
	@flutter clean
	@flutter pub get
	@flutter build appbundle --release --obfuscate --split-debug-info=build/app/symbols

purge: ## Purges the Flutter 
	@pod deintegrate
	@flutter clean
	@flutter pub get