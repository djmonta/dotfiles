;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mac用設定
;; Last Modified: 2013/09/21-10:36:22

;;ATOK2013
(setq default-input-method "MacOSX")
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok26.Japanese" `title "漢")
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok26.Japanese" `cursor-type 'box)
(mac-set-input-method-parameter "com.justsystems.inputmethod.atok26.Japanese" `cursor-color "magenta")

;; ansi-colorでエスケープシーケンスをfontifyする設定
;; http://d.hatena.ne.jp/rubikitch/20081102/1225601754
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; PATH
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; Command-Key and Option-Key
;(setq ns-command-modifier (quote meta))
;(setq ns-alternate-modifier (quote super))

;;optionキーをMetaキーとして利用
(setq mac-option-modifier 'meta)

;(mac-key-mode 1)

;; ドラッグドロップで新たにファイルを開く
(define-key global-map [ns-drag-file] 'ns-find-file)

(fringe-mode 0) ;横の余白みたいなやつ消す

;;ツールバーを消す
(tool-bar-mode 0)

; Show line number
;; (require 'wb-line-number)
;; (setq truncate-partial-width-windows nil)
;; (set-scroll-bar-mode nil)
;; (setq wb-line-number-scroll-bar nil)
;; (wb-line-number-toggle)

;;メニューバーにファイルパスを表示する
(setq frame-title-format
	  (format "%%f - Emacs@%s" (system-name)))

;;ウィンドウサイズ位置指定
;(setq initial-frame-alist '((width . 80) (height . 50)
(setq initial-frame-alist '((width . 184) (height . 71)
(top . 0) (left . 620)))

;;縦二分割
(when (>= emacs-major-version 23)
 (split-window-horizontally))

;;Color&Tranceparent
;; (set-background-color "Black")
;; (set-foreground-color "LightGray")
;; (set-cursor-color "Gray")
(set-frame-parameter nil 'alpha 80)

;;フォントをbitstream vera sans mono 12ptに
;(set-face-attribute 'default nil
;                    :family "Monaco"
;                    :height 120)

;;フォント設定
;(when (>= emacs-major-version 23)
; (set-fontset-font
;  (frame-parameter nil 'font)
;  'japanese-jisx0208
;  '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
;
; (set-fontset-font
;  (frame-parameter nil 'font)
;  'mule-unicode-0100-24ff
;  '("monaco" . "iso10646-1"))
; (setq face-font-rescale-alist
;      '(("^-apple-hiragino.*" . 1.2)
;        (".*osaka-bold.*" . 1.2)
;        (".*osaka-medium.*" . 1.2)
;        (".*courier-bold-.*-mac-roman" . 1.0)
;        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;        (".*monaco-bold-.*-mac-roman" . 0.9)
;        ("-cdac$" . 1.3))))

;; Ricty {{{2 (http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html)
(set-face-attribute 'default nil
                   :family "Ricty"
                   :height 135)
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

;; zencoding-mode
; (require 'zencoding-mode)
; (add-hook 'xml-mode-hook 'zencoding-mode)
; (add-hook 'sgml-mode-hook 'zencoding-mode)
; (add-hook 'html-mode-hook 'zencoding-mode)
; (define-key zencoding-mode-keymap (kbd "<C-return>") nil)
; (define-key zencoding-mode-keymap (kbd "<S-return>") 'zencoding-expand-line)

;;ELScreen
;(load "elscreen" "ElScreen" t)

;;twittering-mode
;;(load "50-twitter")

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)
