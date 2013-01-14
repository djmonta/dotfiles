;; Last Modified: 2013/01/14-12:34:33

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(add-to-list 'load-path (concat user-emacs-directory "/elisp/init-loader"))
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))

