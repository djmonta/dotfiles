;; Last Modified: 2016/04/20-22:29:46

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))

;; バイトコンパイル（より新しい方を読み込む）
(setq load-prefer-newer t)
