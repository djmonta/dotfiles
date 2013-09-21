;; Last Modified: 2013/09/21-10:39:25

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; ELPA/Marmaladeパッケージの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-refresh-contents)
(package-initialize)

;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))
