#!/bin/bash

readonly DOT_DIRECTORY="${HOME}/dotfiles"
readonly SPECIFY_FILES="Brewfile" # 複数ファイルは""の中に半角スペース空けで入力しましょう

function deploy() {
  # ドットファイルとドットファイル以外の特定ファイルを回す
  for f in .??* ${SPECIFY_FILES}; do
    # 無視したいファイルやディレクトリを追加
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".gitmodules" ]] && continue
    [[ ${f} = ".DS_Store" ]] && continue
    [[ ${f} = ".travis.yml" ]] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
  done
  echo "Deploy dotfiles complete!"
}

deploy "$@"