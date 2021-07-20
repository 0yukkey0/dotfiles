#!/bin/bash

echo "Start Homebrew maintenance..."

echo "Update"
brew update

echo "Upgrade Homebrew"
brew upgrade

echo "Upgrade Homebrew Cask"
brew upgrade --cask

echo "Cleanup"
brew cleanup

echo "Check Homebrew"
brew doctor

echo "dump Brewfile"
brew bundle dump --force

echo "Finish."