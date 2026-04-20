# ---- Completion ----
# 補完キー連打で候補順に自動補完
setopt auto_menu
# = 以降も補完 (例: --option=value)
setopt magic_equal_subst
# 単語途中からでも補完
setopt complete_in_word
# 補完後に後続文字を自動挿入 (環境変数等)
setopt auto_param_keys

# ---- Directory ----
# ディレクトリ名のみで cd
setopt auto_cd
# cd 時にディレクトリスタックへ自動プッシュ
setopt auto_pushd
# ディレクトリスタックの重複を無視
setopt pushd_ignore_dups

# ---- History ----
# 重複履歴は最新のみ残す
setopt hist_ignore_all_dups
# 保存時にも重複排除
setopt hist_save_no_dups
# 余分な空白を削除して保存
setopt hist_reduce_blanks
# タイムスタンプ付きで保存 (atuin 等への移行互換)
setopt extended_history
# !! 等のヒストリ展開は即実行せず確認
setopt hist_verify
# 他セッションと履歴を共有 (inc_append_history を内包)
setopt share_history

# ---- Misc ----
# # 以降をコメント扱い
setopt interactive_comments
# 実行後に右プロンプトを消す (p10k 用)
setopt transient_rprompt
# rm * の前に 10 秒待機 (タイポ保険)
setopt rm_star_wait

# ---- Beep ----
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# ---- Terminal ----
# Ctrl-S で端末をフリーズさせない
setopt no_flow_control
