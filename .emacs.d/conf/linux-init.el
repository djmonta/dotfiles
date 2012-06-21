;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Linux用設定

;;Mule-UCS UTF-8
;(require 'un-define)
(setq bitmap-alterable-charset 'tibetan-1-column)
;(require 'jisx0213)

(add-hook 'after-init-hook 'redraw-display) ;

(global-font-lock-mode t)  ;文字装飾(カラー強調)
(setq-default transient-mark-mode t) ;リージョンのハイライト
;(tool-bar-mode nil) ;M-x tool-bar-mode で表示非表示を切り替え
(menu-bar-mode nil) ;メニューバー非表示

;; 全てのバックアップファイルを~/tmp/backup以下に保存する。
(defun make-backup-file-name (filename)
  (expand-file-name
    (concat "~/tmp/backup/" (file-name-nondirectory filename) "~")
    (file-name-directory filename)))

;; 最近使ったファイルを保存(M-x recentf-open-filesで開く)
(recentf-mode)

;; タイムスタンプ
;(add-hook 'time-stamp write-file-hooks)
(if (not (memq 'time-stamp write-file-functions))
    (setq write-file-functions
    (cons 'time-stamp write-file-functions)))

;; Using EmacsClient with Screen
;(add-hook 'after-init-hook 'server-start)
;(add-hook 'server-done-hook
;          (lambda ()
;            (shell-command
;             "screen -r -X select `cat ~/tmp/emacsclient-caller`")))

;(load "emacs-256color.el")

;; EmacsServer --バイブル P.91
;(server-start)
(add-hook 'after-init-hook 'server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

;編集が終了したらEmacsをアイコン化する
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)

;C-x C-c に割り当てる
(global-set-key (kbd "C-x C-c") 'server-edit)

;M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)

(provide 'linux-init)