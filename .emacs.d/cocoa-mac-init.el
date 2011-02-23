;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mac用設定
;; Last Modified: 2011/02/23-09:06:26

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

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;;全てのバックアップファイルを/tmp以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "/tmp/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(fringe-mode 0) ;横の余白みたいなやつ消す

;;ツールバーを消す
(tool-bar-mode 0)

;;メニューバーにファイルパスを表示する
(setq frame-title-format
	  (format "%%f - Emacs@%s" (system-name)))

;;縦二分割
(when (>= emacs-major-version 23)
 (split-window-horizontally))

;;ウィンドウサイズ位置指定
;(setq initial-frame-alist '((width . 80) (height . 50)
(setq initial-frame-alist '((width . 180) (height . 82)
(top . 0) (left . 620)))

;;Color&Tranceparent
(set-background-color "Black")
(set-foreground-color "LightGray")
(set-cursor-color "Gray")
(set-frame-parameter nil 'alpha 80)

;;フォントをbitstream vera sans mono 12ptに
;(set-face-attribute 'default nil
;                    :family "Monaco"
;                    :height 120)

;;フォント設定
(when (>= emacs-major-version 23)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
;  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  '("Hiragino Maru Gothic Pro" . "utf-8"))

 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
;  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  '("Hiragino Maru Gothic Pro" . "utf-8"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3))))

;;optionキーをMetaキーとして利用
;(setq mac-option-modifier 'meta)

;(mac-key-mode 1)

(require 'zencoding-mode)
(add-hook 'xml-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode)
(define-key zencoding-mode-keymap (kbd "<C-return>") nil)
(define-key zencoding-mode-keymap (kbd "<S-return>") 'zencoding-expand-line)

;;ELScreen
(load "elscreen" "ElScreen" t)

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

;;Mew
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
