BASE_HREF = '/website/'
GITHUB_REPO = git@github.com:Andengzkii/website.git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

deploy-web:
	@echo "Clean existing repository"
	flutter Clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Versions $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push --u --force origin main

	cd ..//..
	@echo " Finished Deploy"

.PHONY: deploy-web