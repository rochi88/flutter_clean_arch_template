.PHONY: all run_dev_web run_dev_mobile run_unit clean upgrade lint format build_dev_mobile help watch gen run_stg_mobile run_prd_mobile build_apk_dev build_apk_stg build_apk_prd build_bundle purge run_debug run_dev

all_dev: lint format run_dev

all_debug: lint format run_debug

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
	@flutter clean
	@flutter pub get

watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@dart pub run build_runner watch --delete-conflicting-outputs

build: ## Build the files for changes
	@echo "╠ Building the project..."
	@dart pub run build_runner build --delete-conflicting-outputs


gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@flutter pub get
	@flutter packages pub run build_runner build

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@flutter pub run import_sorter:main

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	git add .
	git commit

run_dev_web: ## Runs the web application in dev
	@echo "╠ Running the app"
	@flutter run -d chrome --dart-define=ENVIRONMENT=dev

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor development -t lib/main_dev.dart

run_stg_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor staging -t lib/main_stg.dart

run_prd_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor production -t lib/main.dart

build_apk_dev: ## Builds the mobile application in dev
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor development -t lib/main_dev.dart

build_apk_stg: ## Builds the mobile application in staging
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor staging -t lib/main_stg.dart

build_apk_prod: ## Builds the mobile application in prod
	@flutter clean
	@flutter pub get
	@flutter build apk --flavor production -t lib/main.dart

build_bundle: ## Builds the mobile application in prod for distribution
	@flutter clean
	@flutter pub get
	@flutter build appbundle

purge: ## Purges the Flutter 
	@pod deintegrate
	@flutter clean
	@flutter pub get

run_debug:
	@flutter run --debug

run_dev:
	@flutter run -d linux -t lib/main_dev.dart