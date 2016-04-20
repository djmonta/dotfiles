;; Last Modified: 2015/01/29-14:57:17

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))

;; バイトコンパイル（より新しい方を読み込む）
(setq load-prefer-newer t)
