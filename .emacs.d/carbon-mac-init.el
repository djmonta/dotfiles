;;Carbon Emacs用設定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-language-environment "Japanese")
(setq default-process-codingsystem 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(add-hook 'set-language-environment-hook
(lambda ()
(when (equal "ja_JP.UTF-8" (getenv "LANG"))
(setq default-process-coding-system '(utf-8 . utf-8))
(setq default-file-name-coding-system 'utf-8))
(when (equal "Japanese" current-language-environment)
(setq default-buffer-file-coding-system 'utf-8))))

;; ansi-colorでエスケープシーケンスをfontifyする設定
;; http://d.hatena.ne.jp/rubikitch/20081102/1225601754
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;全てのバックアップファイルを/tmp以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "/tmp/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)