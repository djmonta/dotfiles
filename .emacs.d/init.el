;; Last Modified: 2011/02/23-00:19:52

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

;; system-type predicates
;;(require 'emacs-type)
;(defun x->bool (elt) (not (not elt)))
;(setq darwin-p  (eq system-type 'darwin)
;	  ns-p      (eq window-system 'ns)
;	  carbon-p  (eq window-system 'mac)
;	  linux-p   (eq system-type 'gnu/linux)
;	  cygwin-p  (eq system-type 'cygwin)
;	  nt-p      (eq system-type 'windows-nt)
;	  meadow-p  (featurep 'meadow)
;	  windows-p (or cygwin-p nt-p meadow-p))

(load "my-custom")
(load "init-psvn")
(load "init-tramp")
(load "init-color-theme")
(load "init-clmemo")
(load "init-shell-pop")
(load "init-twitter")

;; Platform-dependent
(setq os-init-file
      (cond ((eq window-system 'mac) "carbon-mac-init.el")
			((eq window-system 'ns) "cocoa-mac-init.el")
			((eq window-system 'w32) "win-init.el")
			((eq system-type 'gnu/linux) "linux-init.el")))
(if os-init-file
  (load-file (concat user-emacs-directory os-init-file)))