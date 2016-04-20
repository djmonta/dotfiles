;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mac用設定
;; Last Modified: 2015/01/22-15:44:44

;; ansi-colorでエスケープシーケンスをfontifyする設定
;; http://d.hatena.ne.jp/rubikitch/20081102/1225601754
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Command-Key and Option-Key
;(setq ns-command-modifier (quote meta))
;(setq ns-alternate-modifier (quote super))

;;optionキーをMetaキーとして利用
(setq mac-option-modifier 'meta)
;(setq mac-command-modifier 'super)

;(mac-key-mode 1)

;; ドラッグドロップで新たにファイルを開く
(define-key global-map [ns-drag-file] 'ns-find-file)

;(fringe-mode 0) ;横の余白みたいなやつ消す

;;ツールバーを消す
(tool-bar-mode 0)

;; Show line number

;;メニューバーにファイルパスを表示する
(setq frame-title-format
	  (format "%%f - Emacs@%s" (system-name)))

;;ウィンドウサイズ位置指定
;(setq initial-frame-alist '((width . 80) (height . 50)
(setq initial-frame-alist '((width . 270) (height . 71)
(top . 0) (left . 0)))

;;縦二分割
;; (when (>= emacs-major-version 23)
;;   (split-window-horizontally))

;;Color&Tranceparent
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)

(set-frame-parameter nil 'alpha 80)

;;フォント設定
;; Ricty {{{2 (http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html)
(set-face-attribute 'default nil
                   :family "Ricty"
                   :height 135)
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

;;Powerline
(require 'powerline)
(powerline-default-theme)

;;ELScreen
;(load "elscreen" "ElScreen" t)

;;twittering-mode
;;(load "50-twitter")

;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

;;最小の e2wm 設定例
;(require 'e2wm)
;(global-set-key (kbd "M-+") 'e2wm:start-management)
