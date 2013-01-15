;; Last Modified: 2013/01/15-21:17:54

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(add-to-list 'load-path (concat user-emacs-directory "/elisp/init-loader"))
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))

;コミットメッセージを日本語で
;; git commit したときのバッファを utf-8 にする
(add-hook 'server-visit-hook
  (function (lambda ()
     (if (string-match "COMMIT_EDITMSG" buffer-file-name)
         (set-buffer-file-coding-system 'utf-8)))))
