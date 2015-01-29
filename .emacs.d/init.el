;; Last Modified: 2015/01/29-14:57:17

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; ELPA/Marmaladeパッケージの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-refresh-contents)
(package-initialize)

;; 自動インストール設定
(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    auto-async-byte-compile
    auto-install
    auto-save-buffers-enhanced
    clmemo
    e2wm
    git-commit-mode
    git-rebase-mode
    init-loader
    magit
    open-junk-file
    paredit
    shell-pop
    twittering-mode
    window-layout
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))


;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "/conf"))

;; バイトコンパイル（より新しい方を読み込む）
(setq load-prefer-newer t)
