;; 10-mycustom.el
;; Last Modified: 2013/01/14-15:22:46

;; タブキーをスペース4つにする
(setq tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; タブ、行末空白、全角空白に色を付ける
;(defvar my-face-b-1 'my-face-b-1)
;(defvar my-face-b-2 'my-face-b-2)
;(defvar my-face-u-1 'my-face-u-1)
;(defface my-face-b-1 '((t (:background "gray"))) nil)
;(defface my-face-b-2 '((t (:background "gray26"))) nil)
;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;(defadvice font-lock-mode (before my-font-lock-mode ())
;(font-lock-add-keywords
;    major-mode
;    '(("\t" 0 my-face-b-2 append)
;      ("　" 0 my-face-b-1 append)
;      ("[ \t]+$" 0 my-face-u-1 append)
;     )))
;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;(ad-activate 'font-lock-mode)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; P74
;;; auto-install.el をインストールする
;;; リスト2●auto-installの設定例
;; (install-elisp "Http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;; タイムスタンプ書式
;; http://www.opensource.apple.com/source/emacs/emacs-51/emacs/lisp/time-stamp.el
(require 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "Last Modified: ")
(setq time-stamp-format "%04y/%02m/%02d-%02H:%02M:%02S")
(setq time-stamp-end " \\|$")

;;モードライン時間表示
(progn
  (setq display-time-24hr-format t)
  (setq display-time-format "%Y-%m-%d(%a) %H:%M")
  (setq display-time-day-and-date t)
  (setq display-time-interval 30)
  (display-time))

;;行番号表示
(autoload 'setnu-mode "setnu" nil t)
(global-set-key [f5] 'setnu-mode)

;; 最近使ったファイルを保存(M-x recentf-open-filesで開く)
(recentf-mode)

;; auto-save-buffers
;; http://namazu.org/~satoru/misc/auto-save/
(progn
  (require 'auto-save-buffers-enhanced)
  (run-with-idle-timer 3 t 'auto-save-buffers-enhanced))

;; kill-summary
;; http://mibai.tec.u-ryukyu.ac.jp/%7Eoshiro/Programs/elisp/kill-summary.el
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)

;;;試行錯誤用ファイルを開くための設定
(require 'open-junk-file)
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;;式の評価結果を注釈するための設定
; (require 'lispxmp)
;; emacs-lisp-modeでC-c C-dを押すと注釈される
; (define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;;;括弧の対応を保持して編集する設定
(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

;;自動バイトコンパイルを無効にするファイル名の正規表現
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2) ;すぐに表示したい
(setq eldoc-minor-mode-string "") ;モードラインにElDocと表示しない

;;釣り合いのとれる括弧をハイライトする
(show-paren-mode 1)
;;改行と同時にインデントも行う
(global-set-key "\C-m" 'newline-and-indent)
;; find-functionをキー割り当てする
(find-function-setup-keys)

