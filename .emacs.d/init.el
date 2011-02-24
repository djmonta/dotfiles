;; Last Modified: 2011/02/24-11:08:54

;; ~/.emacs.d をロードパスに追加
;(let ((default-directory "~/.emacs.d"))
;  (setq load-path (cons default-directory load-path))
;  (normal-top-level-add-subdirs-to-load-path))

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WEB+DB v58 設定
;;; P74
;;; インストール環境を整備する
;;; リスト1●init.elを作成
;;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf")

;;; conf ディレクトリ内の設定ファイルの読み込み方法の例
;; ~/.emacs.d/conf/init-anything.el というファイルを読み込む場合
;; (load "init-anything")
;; で読み込み可能です。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(require 'emacs-type)
;; Emacs の種類バージョンを判別するための変数を定義
;; @see http://github.com/elim/dotemacs/blob/master/init.el
(defun x->bool (elt) (not (not elt)))
(defvar emacs22-p (equal emacs-major-version 22))
(defvar emacs23-p (equal emacs-major-version 23))
(defvar darwin-p (eq system-type 'darwin))
(defvar ns-p (featurep 'ns))
(defvar carbon-p (and (eq window-system 'mac) emacs22-p))
(defvar mac-p (and (eq window-system 'mac) emacs23-p))
(defvar linux-p (eq system-type 'gnu/linux))
(defvar colinux-p (when linux-p
                    (let ((file "/proc/modules"))
                      (and
                       (file-readable-p file)
                       (x->bool
                        (with-temp-buffer
                          (insert-file-contents file)
                          (goto-char (point-min))
                          (re-search-forward "^cofuse\.+" nil t)))))))
(defvar cygwin-p (eq system-type 'cygwin))
(defvar nt-p (eq system-type 'windows-nt))
(defvar meadow-p (featurep 'meadow))
(defvar windows-p (or cygwin-p nt-p meadow-p))


;; default encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-process-codingsystem 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

(cond
 (mac-p
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
 (windows-p
  (setq file-name-coding-system 'sjis)
  (setq locale-coding-system 'utf-8))
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8))
)

;; 環境依存設定
(cond
 (carbon-p (require 'carbon-mac-init))
 (ns-p (require 'cocoa-mac-init))
 (linux-p (require 'linux-init))
)

;; ansi-colorでエスケープシーケンスをfontifyする設定
;; http://d.hatena.ne.jp/rubikitch/20081102/1225601754
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(require 'my-custom)
(require 'init-git)
(require 'init-psvn)
(require 'init-tramp)
(require 'init-color-theme)
(require 'init-clmemo)
(require 'init-shell-pop)

;; Platform-dependent OS別ファイル読み込み
;; (setq os-init-file
;;       (cond ((eq window-system 'mac) "carbon-mac-init.el")
;; 			((eq window-system 'ns) "cocoa-mac-init.el")
;; 			((eq system-type 'gnu/linux) "linux-init.el")))
;; (if os-init-file
;;   (load-file (concat user-emacs-directory os-init-file)))