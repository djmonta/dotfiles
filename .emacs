;; Last Modified: 2008/11/15-03:19:11

;; ~/.emacs.d をロードパスに追加
(let ((default-directory "~/.emacs.d"))
  (setq load-path (cons default-directory load-path))
  (normal-top-level-add-subdirs-to-load-path))

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

;;-----------------------------------------------------------------
;; psvn.el subversion用
;;-----------------------------------------------------------------
(require 'psvn)

(define-key svn-status-mode-map "q" 'egg-self-insert-command)
(define-key svn-status-mode-map "Q" 'svn-status-bury-buffer)
(define-key svn-status-mode-map "p" 'svn-status-previous-line)
(define-key svn-status-mode-map "n" 'svn-status-next-line)
(define-key svn-status-mode-map "<" 'svn-status-examine-parent)

(add-hook 'dired-mode-hook
          '(lambda ()
             (require 'dired-x)
             ;;(define-key dired-mode-map "V" 'cvs-examine)
             (define-key dired-mode-map "V" 'svn-status)
             (turn-on-font-lock)
             ))

(setq svn-status-hide-unmodified t)

(setq process-coding-system-alist
      (cons '("svn" . utf-8) process-coding-system-alist))

;; save buffer list
;;  http://www.agusa.i.is.nagoya-u.ac.jp/person/sue/download/el/bufferlist/save-buffer-list.el
(progn
  (load-file "~/.emacs.d/save-buffer-list.el")
;  (require 'save-buffer-list)
  (run-with-idle-timer 60 t 'save-current-buffer-list)
  (load-buffer-list))


;; auto-save-buffers
;; http://namazu.org/~satoru/misc/auto-save/
(progn
  (require 'auto-save-buffers)
  (run-with-idle-timer 3 t 'auto-save-buffers))


(cond
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Mac用設定
((string-match "apple-darwin" system-configuration)

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;;Macで動くCarbon Emacsを半透明化して最大化する - suztomoの日記 <http://d.hatena.ne.jp/suztomo/20080923/1222149517>
;(add-hook 'window-setup-hook
;         (lambda ()
;;            (setq mac-autohide-menubar-on-maximize t)
;           (set-frame-parameter nil 'fullscreen 'fullboth)
;           ))

;; フルスクリーン
;(defun mac-toggle-max-window ()
;  (interactive)
;  (if (frame-parameter nil 'fullscreen)
;      (set-frame-parameter nil 'fullscreen nil)
;    (set-frame-parameter nil 'fullscreen 'fullboth)))

;; Carbon Emacsの設定で入れられた. メニューを隠したり．
(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )

;;ウィンドウサイズ位置指定
;(setq initial-frame-alist '((width . 80) (height . 50)
(setq initial-frame-alist '((width . 130) (height . 82)
(top . 0) (left . 620)))

;;Color&Tranceparent
(set-background-color "Black")
(set-foreground-color "LightGray")
(set-cursor-color "Gray")
(set-frame-parameter nil 'alpha 80)

;;フォントをbitstream vera sans mono 12ptに
(set-face-attribute 'default nil
                    :family "bitstream vera sans mono"
                    :height 120)

;;optionキーをMetaキーとして利用
(setq mac-option-modifier 'meta)

(mac-key-mode 1)

(require 'tramp)

;;省略ネーム
(setenv "X" "/ssh:monta@192.168.0.4:")
(setenv "XS" "/multi:ssh:monta@192.168.0.4:sudo:root@localhost:")
;;C-x C-f $X/path/to/file RET.


;;タイムスタンプ
(add-hook 'before-save-hook 'time-stamp)

);Mac用設定終わり
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Linux用設定
((string-match "linux" system-configuration)
;;Mule-UCS UTF-8
(require 'un-define)
(setq bitmap-alterable-charset 'tibetan-1-column)
(require 'jisx0213)

;; default encoding
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

(require 'color-theme)
(color-theme-initialize)
(color-theme-tty-dark)

(global-font-lock-mode t)  ;文字装飾(カラー強調)
(setq-default transient-mark-mode t) ;リージョンのハイライト
(tool-bar-mode nil) ;M-x tool-bar-mode で表示非表示を切り替え
(menu-bar-mode nil) ;メニューバー非表示

;;全てのバックアップファイルを~/tmp/backup以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "~/tmp/backup/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

;; 最近使ったファイルを保存(M-x recentf-open-filesで開く)
(recentf-mode)

;;タイムスタンプ
;(add-hook 'time-stamp write-file-hooks)
(if (not (memq 'time-stamp write-file-hooks))
    (setq write-file-hooks
    (cons 'time-stamp write-file-hooks)))

);Linux用設定終わり

);OS分岐終わり
