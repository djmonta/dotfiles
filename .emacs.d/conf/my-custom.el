;; my-custom.el
;; Last Modified: 2012/06/21-08:36:45

;; タブキーをスペース4つにする
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; タブ、行末空白、全角空白に色を付ける
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
(font-lock-add-keywords
    major-mode
    '(("\t" 0 my-face-b-2 append)
      ("　" 0 my-face-b-1 append)
      ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;タイムスタンプ書式
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

;; auto-save-buffers
;; http://namazu.org/~satoru/misc/auto-save/
(progn
  (require 'auto-save-buffers)
  (run-with-idle-timer 3 t 'auto-save-buffers))

;; kill-summary
;; http://mibai.tec.u-ryukyu.ac.jp/%7Eoshiro/Programs/elisp/kill-summary.el
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)

;;; P74
;;; auto-install.el をインストールする
;;; リスト2●auto-installの設定例
;; (install-elisp "Http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;;試行錯誤用ファイルを開くための設定
(require 'open-junk-file) 
;; C-x C-zで試行錯誤ファイルを開く
(global-set-key (kbd "C-x C-z") 'open-junk-file) 

(provide 'my-custom)