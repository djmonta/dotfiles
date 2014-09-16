;; 10-mycustom.el
;; Last Modified: 2014/09/16-17:54:40

;; タブキーをスペース4つにする
(setq tab-width 4)
(setq indent-line-function 'indent-relative-maybe)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;;モードライン時間表示
(progn
  (require 'time)
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
  (setq auto-save-buffers-enhanced-interval 3)
  (auto-save-buffers-enhanced t))

;; タイムスタンプ書式
;; http://www.opensource.apple.com/source/emacs/emacs-51/emacs/lisp/time-stamp.el
(require 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "Last Modified: ")
(setq time-stamp-format "%04y/%02m/%02d-%02H:%02M:%02S")
(setq time-stamp-end " \\|$")

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
;(setq eldoc-idle-delay 0.2) ;すぐに表示したい
(setq eldoc-minor-mode-string "") ;モードラインにElDocと表示しない

;;釣り合いのとれる括弧をハイライトする
(show-paren-mode 1)
;;改行と同時にインデントも行う
(global-set-key "\C-m" 'newline-and-indent)
;; find-functionをキー割り当てする
(find-function-setup-keys)

;; root ファイルを開くときにsudoで
(defun file-root-p (filename)
  "Return t if file FILENAME created by root."
  (eq 0 (nth 2 (file-attributes filename))))
 
(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))
 
(add-hook 'find-file-hook
          'th-rename-tramp-buffer)
 
(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-root-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))
 
(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))
